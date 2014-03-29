coffee = require("coffee-script")
jade = require("jade")
express = require("express")
expstate = require("express-state")
nconf = require("nconf")
authom = require("authom")
request = require("request")
path = require("path")
xmlbuilder = require("xmlbuilder")
es = require("event-stream")
hbs = require("hbs")
lactate = require("lactate")
JSONStream = require("JSONStream")

pkginfo = require("./package.json")


# Set defaults in nconf
require "./configure"

lactateOptions = 
  "max age": "one second"

app = module.exports = express()

expstate.extend(app)
  
app.set "views", "#{__dirname}/views"
app.set "view engine", "jade"
app.set "view options", layout: false
app.engine "html", hbs.__express

app.use require("prerender-node")
app.use require("./middleware/redirect").middleware(nconf.get("redirect"))
app.use require("./middleware/vary").middleware()
# app.use lactate.static "#{__dirname}/vendor/angular-loader/angular-loader.js", lactateOptions
# app.use lactate.static "#{__dirname}/vendor/scriptjs/dist/script.js", lactateOptions
app.use lactate.static "#{__dirname}/vendor", lactateOptions
app.use lactate.static "#{__dirname}/assets", lactateOptions

if nconf.get("NODE_ENV") is "production"
  console.log "Starting Plunker in: PRODUCTION"
else
  console.log "Starting Plunker in: DEVELOPMENT"
  
app.use express.cookieParser()
app.use express.bodyParser()

app.expose nconf.get("url"), "_plunker.url"
app.expose pkginfo, "_plunker.package"
app.expose null, "_plunker.bootstrap"
    
app.use require("./middleware/subdomain").middleware()
app.use app.router

app.use express.errorHandler()

addSession = require("./middleware/session").middleware()



app.get "/partials/:partial", (req, res, next) ->
  res.render "assets/partials/#{req.params.partial}"

app.get "/edit/*", addSession, (req, res, next) ->
  res.render "editor"
  
app.all "/edit/", addSession, (req, res, next) ->
  res.header("Access-Control-Allow-Origin", req.headers.origin or "*")
  res.header("Access-Control-Allow-Methods", "OPTIONS,GET,PUT,POST,DELETE")
  res.header("Access-Control-Allow-Headers", "Authorization, User-Agent, Referer, X-Requested-With, Proxy-Authorization, Proxy-Connection, Accept-Language, Accept-Encoding, Accept-Charset, Connection, Content-Length, Host, Origin, Pragma, Accept-Charset, Cache-Control, Accept, Content-Type")
  res.header("Access-Control-Expose-Headers", "Link")
  res.header("Access-Control-Max-Age", "60")

  if "OPTIONS" == req.method then res.send(200)
  else next()

app.post "/edit/", addSession, (req, res, next) ->    
  res.header "X-XSS-Protection", 0
  
  bootstrap =
    description: req.body.description or ""
    tags: req.body.tags or []
    files: {}
    'private': req.body.private != "false"

  if req.body.files
    for filename, file of req.body.files
      bootstrap.files[filename] =
        filename: filename
        content: if typeof file is "string" then file else file.content or ""
      
  res.expose bootstrap, "_plunker.bootstrap"
  res.render "editor"

app.all "/edit", addSession, (req, res, next) -> res.redirect("/edit/", 302)

# /////////////////////////////////

app.get "/auth/:service", addSession, (req, res, next) ->
  req.headers.host = nconf.get("host")
  
  authom.app(arguments...)


authom.on "auth", (req, res, auth) ->
  res.expose auth, "_plunker.auth"
  res.render "auth/success"


authom.on "error", (req, res, auth) ->
  console.log "Auth error", auth
  res.expose auth, "_plunker.auth"
  res.status 403
  res.render "auth/error"
  
# /////////////////////////////////

apiUrl = nconf.get("url:api")
wwwUrl = nconf.get("url:www")

localsMiddleware = (req, res, next) ->
  res.locals.timestamp = ""
  res.locals.suffix = "-min"
  
  if process.env.NODE_ENV is "development"
    res.locals.timestamp = Date.now()
    res.locals.suffix = ""
  
  next()


app.get "/sitemap.xml", (req, res) ->
  outstanding = 0
  
  urlset = xmlbuilder.create "urlset",
    version: "1.0"
    encoding: "UTF-8"
  
  urlset.attribute "xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9"
  
  finalize = ->
    res.set('Content-Type', 'application/xml')
    res.send(urlset.end())
  
  complete = -> finalize() unless --outstanding > 0
  
  outstanding++
  plunks = request("#{apiUrl}/plunks?pp=40000").pipe(JSONStream.parse([true])).pipe es.mapSync (plunk) ->
    url = urlset.ele("url")
    url.ele("loc").text("#{wwwUrl}/#{plunk.id}").up()
    url.ele("lastmod").text(plunk.updated_at).up()
    url.ele("changefreq").text("daily").up()
    url.up()
  
  plunks.on "end", complete
  

apiUrl = nconf.get("url:api")

app.get "/catalogue", addSession, (req, res) -> res.render "packages"
app.get "/catalogue/*", addSession, (req, res) -> res.render "packages"


secureFilters = require("secure-filters")


hbs.registerHelper "jsObj", (obj) -> new hbs.SafeString(secureFilters.jsObj(obj))

app.get "/plunks", addSession, (req, res) -> res.render "editor"
app.get "/plunks/trending", addSession, (req, res) -> res.render "editor"
app.get "/plunks/popular", addSession, (req, res) -> res.render "editor"
app.get "/plunks/recent", addSession, (req, res) -> res.render "editor"
app.get "/plunks/views", addSession, (req, res) -> res.render "editor"
app.get "/users", addSession, (req, res) -> res.render "editor"
app.get "/users/:username", addSession, (req, res) -> res.render "editor"
app.get "/group", addSession, (req, res) -> res.render "editor"
app.get "/tags", addSession, (req, res) -> res.render "editor"
app.get "/tags/:tagname", addSession, (req, res) -> res.render "editor"
app.get "/:id", addSession, (req, res) ->
  request.get "#{apiUrl}/plunks/#{req.params.id}", (err, response, body) ->
    return res.send(500) if err
    return res.send(response.statusCode) if response.statusCode >= 400
    
    try
      plunk = JSON.parse(body)
    catch e
      return res.render "editor"
    
    res.locals.bootstrap =
      plunks: [plunk]
      page_title: plunk.description
    res.render "editor"

app.get "/*", addSession, (req, res) ->
  res.render "editor"
