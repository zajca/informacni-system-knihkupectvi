changed = require("gulp-changed")
gulp = require("gulp")
imagemin = require("gulp-imagemin")
livereload = require("gulp-livereload")
gulpif = require('gulp-if')

gulp.task "images", ->
  gulp.src(["./src/images/**/*.jpg","./src/images/**/*_ns.png"])
  .pipe changed("./assets/images")
  .pipe imagemin()
  .pipe gulp.dest("./assets/images")
  # .pipe(gulpif(!prod,livereload()))
  .pipe livereload()