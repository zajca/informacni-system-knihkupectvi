###


CONFIG


###

gulp = require('gulp')
gutil = require('gulp-util')
autoprefixer = require("gulp-autoprefixer")
minifycss = require("gulp-minify-css")
imagemin = require("gulp-imagemin")
rename = require("gulp-rename")
clean = require("gulp-clean")
notify = require("gulp-notify")
cache = require("gulp-cache")
livereload = require("gulp-livereload")
lr = require("tiny-lr")
server = lr()
recess = require("gulp-recess")
minifyHtml = require("gulp-minify-html")
concat = require("gulp-concat")
uglify = require("gulp-uglify")
less = require('gulp-less')
gulpif = require('gulp-if')
coffeelint = require('gulp-coffeelint')
coffee = require('gulp-coffee')
rev = require('gulp-rev')
sprite = require('css-sprite').stream
runSequence = require('run-sequence')
watch = require('gulp-watch')
plumber = require('gulp-plumber')
libnotify = require('libnotify')
browserify = require('gulp-browserify')
jade = require('gulp-jade')

modules=[
  "vendor/angular/angular.js",
  "vendor/angular-sanitize/angular-sanitize.js",
  "vendor/angular-animate/angular-animate.js",
  "vendor/angular-touch/angular-touch.js",
  "vendor/angular-translate/angular-translate.js",
  #  "vendor/angular-bootstrap/ui-bootstrap-tpls.js",
  "vendor/angular-ui-router/release/angular-ui-router.js",
  "vendor/angular-ui-utils/ui-utils.js",
#        "vendor/angular-gestures/gestures.js",
  "vendor/angular-easyfb/angular-easyfb.js",
   "vendor/angular-strap/dist/angular-strap.js",
  #  "vendor/angular-strap/dist/modules/modal.tpl.js",
  "vendor/ng-file-upload/angular-file-upload.js",
  "libs/cs_cz.js"
]

dirs=
  "src":"src"
  "dest":"assets"
  "tmp":"tmp"
config=
  "jsDest":"#{dirs.dest}/js"
  "images":"*{.ico,.svg,.gif}"
  "css":
    "src":"#{dirs.src}/less/main.less"
    "dest":"#{dirs.dest}/css"
  "admin":
    "cs":
      "src":"#{dirs.src}/app/admin.coffee"
  "create":
    "cs":
      "src":"#{dirs.src}/app/create.coffee"
  "editor":
    "cs":
      "src":"#{dirs.src}/app/editor.coffee"
  "finance":
    "cs":
      "src":"#{dirs.src}/app/finance.coffee"
  "portal":
    "cs":
      "src":"#{dirs.src}/app/finance.coffee"
  "store":
    "cs":
      "src":"#{dirs.src}/app/store.coffee"
prod = true
###



WATCH



###
gulp.task "watch", ->
  server.listen 35729, (err) ->
    return console.log(err)  if err

  gulp.watch "#{dirs.src}/**/*.less", (event)->
    libnotify.notify("FILE: #{event.path} - #{event.type}")
    runSequence 'LESS'

  gulp.watch "#{dirs.src}/**/*.coffee", (event)->
    libnotify.notify("FILE: #{event.path} - #{event.type}")
    runSequence 'COFFEE-EDITOR'

  gulp.watch ["#{dirs.src}/**/*.png","!#{dirs.src}/**/*_ns.png"], (event)->
    libnotify.notify("FILE: #{event.path} - #{event.type}")
    runSequence 'SPRITES'

  gulp.watch ["#{dirs.src}/images/**/*.jpg","#{dirs.src}/images/**/*_ns.png"], (event)->
    libnotify.notify("FILE: #{event.path} - #{event.type}")
    runSequence 'IMG'

  gulp.watch "#{dirs.src}/images/**/#{config.images}", (event)->
    libnotify.notify("FILE: #{event.path} - #{event.type}")
    runSequence 'IMG_OTHER'

  gulp.watch "#{dirs.src}/**/*.jade", (event)->
    libnotify.notify("FILE: #{event.path} - #{event.type}")
    runSequence 'JADE'
###



TASKS




###
gulp.task 'default', ->
  runSequence "CLEAN", [
    "SPRITES"
    "IMG"
    "JADE"
    "IMG_OTHER"
  ],
    "COFFEE-EDITOR",
    "LESS"
    "watch"
###
DEVEL
###
gulp.task 'dev',->
  prod = false
  runSequence "default",["watch"]
###
PRODUCTION
###
gulp.task 'prod', ['default'],->
  prod = true

###



CLEAN



###
gulp.task 'CLEAN', ->
  gulp.src([
    dirs.dest,
    dirs.tmp,
    "#{dirs.src}/less/sprites.less"
    ],
    read: false)
  .pipe(clean())

###



LESS



###
gulp.task 'LESS', ->
  gulp.src(config.css.src)
  .pipe(plumber())
  # .pipe(recess())
  .pipe(less())
  .pipe(autoprefixer(
      "last 2 version",
      "safari 5",
      "ie 9",
      "opera 12.1",
      "ios 6",
      "android 4"
    ))
  .pipe(gulpif(prod,minifycss()))
  .pipe(gulpif(prod, rename suffix: ".min"))
  # .pipe(gulpif(prod, rev()))
  .pipe(gulp.dest(config.css.dest))
  .pipe(gulpif(!prod,livereload(server)))

###



COFFEE



###
gulp.task 'COFFEE',->
  runSequence "COFFEELINT",["COFFEE-ADMIN","COFFEE-CREATE","COFFEE-EDITOR","COFFEE-FINANCE","COFFEE-PORTAL","COFFEE-STORE"]

gulp.task 'COFFEELINT', ->
  gulp.src("#{dirs.src}/**/*.coffee")
  .pipe(plumber())
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())

# gulp.task 'COFFEE-ADMIN', ["COFFEELINT"] ,->
#   gulp.src(config.admin.cs.src, { read: false })
#   .pipe(browserify({
#       debug: true
#       transform: ['caching-coffeeify', 'brfs']
#       extensions: ['.coffee'],
#       noParse: modules
#     }))
#   .pipe(gulpif(prod,rename('admin.js',suffix: ".min")))
#   .pipe(gulpif(!prod,rename('admin.js')))
#   .pipe(gulpif(prod, rev()))
#   .pipe(gulpif(prod,uglify mangle:false))
#   .pipe(gulp.dest(config.jsDest))
#   .pipe(gulpif(!prod,livereload(server)))
# gulp.task 'COFFEE-CREATE', ["COFFEELINT"] ,->
#   gulp.src(config.create.cs.src, { read: false })
#   .pipe(browserify({
#       debug: true
#       transform: ['caching-coffeeify', 'brfs']
#       extensions: ['.coffee'],
#       noParse: modules
#     }))
#   .pipe(gulpif(prod,rename('create.js',suffix: ".min")))
#   .pipe(gulpif(!prod,rename('create.js')))
#   .pipe(gulpif(prod, rev()))
#   .pipe(gulpif(prod,uglify mangle:false))
#   .pipe(gulp.dest(config.jsDest))
#   .pipe(gulpif(!prod,livereload(server)))
gulp.task 'COFFEE-EDITOR', ["COFFEELINT"] ,->
  gulp.src(config.editor.cs.src, { read: false })
  .pipe(plumber())
  .pipe(browserify({
      debug: true
      transform: ['caching-coffeeify', 'brfs']
      extensions: ['.coffee'],
      noParse: modules
    }))
  .pipe(rename('editor.js'))
  # .pipe(gulpif(prod, rev()))
  .pipe(gulpif(prod,uglify mangle:false))
  .pipe(gulp.dest(config.jsDest))
  .pipe(gulpif(!prod,livereload(server)))
# gulp.task 'COFFEE-FINANCE', ["COFFEELINT"] ,->
#   gulp.src(config.finance.cs.src, { read: false })
#   .pipe(browserify({
#       debug: true
#       transform: ['caching-coffeeify', 'brfs']
#       extensions: ['.coffee'],
#       noParse: modules
#     }))
#   .pipe(gulpif(prod,rename('finance.js',suffix: ".min")))
#   .pipe(gulpif(!prod,rename('finance.js')))
#   .pipe(gulpif(prod, rev()))
#   .pipe(gulpif(prod,uglify mangle:false))
#   .pipe(gulp.dest(config.jsDest))
#   .pipe(gulpif(!prod,livereload(server)))
# gulp.task 'COFFEE-PORTAL', ["COFFEELINT"] ,->
#   gulp.src(config.portal.cs.src, { read: false })
#   .pipe(browserify({
#       debug: true
#       transform: ['caching-coffeeify', 'brfs']
#       extensions: ['.coffee'],
#       noParse: modules
#     }))
#   .pipe(gulpif(prod,rename('portal.js',suffix: ".min")))
#   .pipe(gulpif(!prod,rename('portal.js')))
#   .pipe(gulpif(prod, rev()))
#   .pipe(gulpif(prod,uglify mangle:false))
#   .pipe(gulp.dest(config.jsDest))
#   .pipe(gulpif(!prod,livereload(server)))
# gulp.task 'COFFEE-STORE', ["COFFEELINT"] ,->
#   gulp.src(config.store.cs.src, { read: false })
#   .pipe(browserify({
#       debug: true
#       transform: ['caching-coffeeify', 'brfs']
#       extensions: ['.coffee'],
#       noParse: modules
#     }))
#   .pipe(gulpif(prod,rename('store.js',suffix: ".min")))
#   .pipe(gulpif(!prod,rename('store.js')))
#   .pipe(gulpif(prod, rev()))
#   .pipe(gulpif(prod,uglify mangle:false))
#   .pipe(gulp.dest(config.jsDest))
#   .pipe(gulpif(!prod,livereload(server)))
###



IMG SPRITES



###
gulp.task('SPRITES', ->
  gulp.src(["#{dirs.src}/images/**/*.png","!#{dirs.src}/images/**/*_ns.png"])
  .pipe(sprite(
      name: 'sprite.png'
      style: 'sprites.less',
      cssPath: 'images/',
      processor: 'less'
    ))
  .pipe(gulpif('*.png', gulp.dest("#{dirs.dest}/images")))
  .pipe(gulpif('*.less', gulp.dest("#{dirs.src}/less")))
  .pipe(gulpif(!prod,livereload(server)))
)
###



JPG Images



###
gulp.task('IMG', ->
  gulp.src(["#{dirs.src}/images/**/*.jpg","#{dirs.src}/images/**/*_ns.png"])
#  .pipe(gulpif(prod,imagemin {
#      optimizationLevel: 5
#      progressive: true
#      interlaced: true
#    }))
  .pipe(gulp.dest("#{dirs.dest}/images"))
  .pipe(gulpif(!prod,livereload(server)))
)
###



COPY OTHER IMAGES



###
gulp.task('IMG_OTHER', ->
  gulp.src("#{dirs.src}/images/**/#{config.images}")
  .pipe(gulp.dest("#{dirs.dest}/images"))
  .pipe(gulpif(!prod,livereload(server)))
)
###



JADE



###
gulp.task('JADE', ->
  gulp.src("#{dirs.src}/**/*.jade")
  .pipe(gulpif(prod,jade(
    pretty:false
    )))
  .pipe(gulpif(!prod,jade(
    pretty:true
    debug:true
    )))
  # .pipe(gulpif(prod,minifyHtml {
  #     empty: true
  #     spare: true
  #     quotes: true
  #   }))
#   .pipe(ngHtml2Js({
#       moduleName: "templates"
# #        prefix: "build/"
#     }))
  .pipe(gulp.dest("#{dirs.dest}/partials"))
  .pipe(gulpif(!prod,livereload(server)))
)