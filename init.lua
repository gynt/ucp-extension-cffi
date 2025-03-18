
local dll

return {
  enable = function(self, config)
    dll = require("cffi.dll")
  end,
  
  cffi = function(self) return dll end,
  
  disable = function(self, config) end,

}, {
  proxy = {
    ignored = "cffi",
  },
}
