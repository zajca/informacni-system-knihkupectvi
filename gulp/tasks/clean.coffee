gulp = require('gulp')
clean = require("gulp-clean")

gulp.task 'CLEAN', ->
  gulp.src([
      "./assets"
      "./tmp"
      "./src/less/sprites.less"
    ]
    read: false
  ).pipe(clean())
