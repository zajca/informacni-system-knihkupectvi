gulp = require('gulp')
plumber = require('gulp-plumber')
coffeelint = require('gulp-coffeelint')

gulp.task 'COFFEELINT', ->
  gulp.src("./src/**/*.coffee")
  .pipe(plumber())
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())