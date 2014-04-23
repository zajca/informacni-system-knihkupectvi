fs = require("fs")
prod = false
onlyScripts = require("./util/scriptFilter")
tasks = fs.readdirSync("./gulp/tasks/").filter(onlyScripts)
tasks.forEach (task) ->
  require "./tasks/#{task}"
  return
