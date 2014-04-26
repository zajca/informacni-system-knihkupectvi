gulp = require('gulp')
plumber = require('gulp-plumber')
less = require('gulp-less')
autoprefixer = require("gulp-autoprefixer")
gulpif = require('gulp-if')
filesize = require('gulp-filesize')
minifycss = require("gulp-minify-css")
sprite = require('css-sprite').stream
livereload = require("gulp-livereload")


gulp.task 'LESS', ["SPRITES"] ,->
# gulp.task 'LESS', ->
  gulp.src("./src/less/main.less")
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
  # .pipe(gulpif(prod,filesize()))
  # .pipe(gulpif(prod,minifycss()))
  # .pipe(gulpif(prod, rename suffix: ".min"))
  # .pipe(gulpif(prod, rev()))
  .pipe(gulp.dest("./assets/css"))
  .pipe(filesize())
  .pipe livereload()
  # .pipe(gulpif(!prod,livereload(server)))

gulp.task('SPRITES', ->
  gulp.src(["./src/images/**/*.png","!./src/images/**/*_ns.png"])
  .pipe(plumber())
  .pipe(sprite(
      base64: true,
      name: 'sprite.png'
      style: 'sprites.less',
      cssPath: 'images/',
      processor: 'less'
    ))
  .pipe(gulpif('*.png', gulp.dest("./assets/images")))
  .pipe(gulpif('*.less', gulp.dest("./src/less")))
)