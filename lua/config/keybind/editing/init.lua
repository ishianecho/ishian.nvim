local database = require("config.keybind.editing.database")
database.setup()

return {
  require("config.keybind.editing.codemap"),
  require("config.keybind.editing.explorer"),
  require("config.keybind.editing.git"),
  require("config.keybind.editing.notify"),
  require("config.keybind.editing.pairs"),
  require("config.keybind.editing.replace"),
  require("config.keybind.editing.picker"),
  require("config.keybind.editing.words"),
  require("config.keybind.editing.workspace"),
}
