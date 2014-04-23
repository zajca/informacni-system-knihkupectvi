gulp = require('gulp')
runSequence = require('run-sequence')

gulp.task 'dev',->
  prod = false
  runSequence "default",["watch"],"serve"