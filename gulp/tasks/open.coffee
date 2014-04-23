gulp = require("gulp")
open = require("gulp-open")
config = require("../config")
gulp.task "open", ->
  options =
    url: "http://localhost:" + config.port
    app: "google chrome"

  gulp.src("./index.html").pipe open("", options)
