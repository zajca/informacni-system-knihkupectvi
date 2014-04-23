browserify = require("browserify")
gulp = require("gulp")
handleErrors = require("../util/handleErrors")
livereload = require("gulp-livereload")
source = require("vinyl-source-stream")
gulpif = require('gulp-if')
filesize = require('gulp-filesize')

gulp.task "browserify", ["COFFEELINT"], ->
  # enviroments = ["editor","store"]
  # for e in enviroments
  #   browserify(
  #     entries: ["./src/app/#{e}.coffee"]
  #     extensions: [
  #       ".coffee"
  #     ]
  #     transform: ['caching-coffeeify', 'brfs','envify']
  #   )
  #   # .require("backbone/node_modules/underscore",
  #   #   expose: "underscore"
  #   # )
  #   .bundle(
  #     debug: true
  #   )
  #   .on("error", handleErrors)
  #   .pipe source("#{e}.js")
  #   # .pipe gulpif(prod,uglify mangle:false)
  #   .pipe gulp.dest("./assets/")
  #   .pipe filesize()
  #   .pipe livereload()
  browserify(
    entries: ["./src/app/editor.coffee"]
    extensions: [
      ".coffee"
    ]
    transform: ['caching-coffeeify', 'brfs','envify']
  )
  # .require("backbone/node_modules/underscore",
  #   expose: "underscore"
  # )
  .bundle(
    debug: true
  )
  .on("error", handleErrors)
  .pipe source("editor.js")
  # .pipe gulpif(prod,uglify mangle:false)
  .pipe gulp.dest("./assets/")
  .pipe filesize()
  .pipe livereload()
