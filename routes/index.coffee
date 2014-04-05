#
# * GET home page.
#
exports.editor = (req, res) ->
  res.render "editor",
    title: "Express"
  return