local cffi = {}

local dll

---@class CFFIInterface
local CFFIInterface = {}

---Declare c types (globally)
---@param contents string The c-syntax header declarations
---@return nil nothing
function CFFIInterface.cdef(contents)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.cdef(contents)
end

---Get a handle to the cffi lua library
---@return CFFIInterface cffi
function cffi:cffi() return CFFIInterface end


function cffi.enable(self, config)
  dll = require("cffi.dll")
end
  
  
function cffi.disable(self, config) end

return cffi, {
  proxy = {
    ignored = "cffi",
  },
}
