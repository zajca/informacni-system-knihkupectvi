jade = require('gulp-jade')
gulp = require('gulp')
plumber = require('gulp-plumber')
gulpif = require('gulp-if')
livereload = require("gulp-livereload")
runSequence = require('run-sequence')

gulp.task 'JADE', ->

  gulp.src("./src/**/*.jade")
  .pipe(plumber())
  .pipe(jade(
    pretty:true
    debug:false
    ))
  # .pipe(gulpif(prod,jade(
  #   pretty:false
  #   )))
  # .pipe(gulpif(!prod,jade(
  #   pretty:true
  #   debug:false
  #   )))
  # .pipe(gulpif(prod,minifyHtml {
  #     empty: true
  #     spare: true
  #     quotes: true
  #   }))
#   .pipe(ngHtml2Js({
#       moduleName: "templates"
# #        prefix: "build/"
#     }))
  .pipe(gulp.dest("./assets/partials"))
  # .pipe(gulpif(!prod,livereload()))
  .pipe livereload()