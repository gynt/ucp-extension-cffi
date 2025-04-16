---@class cffi
local cffi = {}

local dll = require("cffi.dll")

---@class CFFIInterface
local CFFIInterface = {}

---Declare c types (globally)
---@param contents string The c-syntax header declarations
---@return nil nothing
function CFFIInterface.cdef(contents)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.cdef(contents)
end

---Cast c types
---@param ct string The c-syntax type specifier
---@param init unknown
---@return nil nothing
function CFFIInterface.cast(ct, init)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.cast(ct, init)
end

---Get the address of cdata
---@param cdata unknown the object
---@return nil nothing
function CFFIInterface.addressof(cdata)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.addressof(cdata)
end

---Create a cdata object
---@param ct string The c-syntax type specifier
---@param ... unknown number of elements or ...
---@return nil nothing
function CFFIInterface.new(ct, ...)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.new(ct, ...)
end

---Create a cdata object
---@param ct string The c-syntax type specifier
---@param nelem number number of elements
---@return nil nothing
function CFFIInterface.sizeof(ct, nelem)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.sizeof(ct, nelem)
end

---Get a handle to the cffi lua library
---@return CFFIInterface cffi
function cffi:cffi() return dll end


function cffi.enable(self, config)
  if dll == nil then error() end
end
  
  
function cffi.disable(self, config) end

function cffi:importHeaderString(str)
  CFFIInterface.cdef(str)
end
  
function cffi:importHeaderFile(path)
  local handle, err = io.open(path, 'r')
  if not handle then error(err) end
  local contents = handle:read("*all")
  self:importHeaderString(contents)
end

return cffi, {
  proxy = {
    ignored = {
      "cffi",
    },
  },
}
