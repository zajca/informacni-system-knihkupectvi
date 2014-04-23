browserify = require("browserify")
gulp = require("gulp")
handleErrors = require("../util/handleErrors")
livereload = require("gulp-livereload")
source = require("vinyl-source-stream")
gulpif = require('gulp-if')
filesize = require('gulp-filesize')

gulp.task "browserify", ["COFFEELINT"], ->
  enviroments = ["editor","store"]
  for e in enviroments
    browserify(
      entries: ["./src/app/#{e}.coffee"]
      extensions: [".coffee"]
    )
    .bundle(
      debug: true
    )
    .on("error", handleErrors)
    .pipe source("#{e}.js")
    # .pipe gulpif(prod,uglify mangle:false)
    .pipe gulp.dest("./assets/")
    .pipe filesize()
    .pipe livereload()