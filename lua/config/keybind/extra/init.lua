local database = require("config.keybind.extra.database")
database.setup()

return {
  require("config.keybind.extra.git"),
  require("config.keybind.extra.mail"),
}
