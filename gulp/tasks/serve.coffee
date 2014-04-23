gulp = require('gulp')
coffeelint = require('gulp-coffeelint')
plumber = require('gulp-plumber')
libnotify = require('libnotify')
nodemon = require('gulp-nodemon')

gulp.task "serve", ->
  nodemon(
    script: "app.js"
    ext: "jade coffee"
    env:
      "ENV":"dev"
    ignore: ["./src/**/*","./assets/**/*","./gulp/**/*"]
  ).on("change", ["serverLint"]).on "restart", ->
    libnotify.notify("NODEMON RESTART")
    console.log "restarted!"

gulp.task 'serverLint', ->
  gulp.src([
    "./config/**/*.coffee"
    "./database/**/*.coffee"
    "./middleware/**/*.coffee"
    "./routes/**/*.coffee"
    "./config.coffee"
    "./index.coffee"
  ])
  .pipe(plumber())
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())
