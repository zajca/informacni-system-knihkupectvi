gulp = require("gulp")
livereload = require("gulp-livereload")
gulp.task "watch", ->
  gulp.watch "src/**/*.coffee", ["browserify"]
  gulp.watch "src/**/*.less", ["LESS"]
  gulp.watch "src/images/**", ["images"]
  livereload()
  return
