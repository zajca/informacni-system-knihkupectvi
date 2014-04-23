gulp = require("gulp")
runSequence = require('run-sequence')

gulp.task 'default', ->
  runSequence "CLEAN", [
    "images"
    "JADE"
    "browserify"
    "LESS"
  ]