---@class cffi
local cffi = {}

local dll = require("cffi.dll")
local settings = dll.settings

---@class CFFIInterface
local CFFIInterface = {}

---Declare c types (globally)
---@param contents string The c-syntax header declarations
---@return nil nothing
function CFFIInterface.cdef(contents)
  if dll == nil then error('cffi.dll not initialized') end
  dll.cdef(contents)
end

---Cast c types
---@param ct string The c-syntax type specifier
---@param init unknown
---@return unknown any
function CFFIInterface.cast(ct, init)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.cast(ct, init)
end

---Get the address of cdata
---@param cdata unknown the object
---@return unknown any
function CFFIInterface.addressof(cdata)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.addressof(cdata)
end

---Create a cdata object
---@param ct string The c-syntax type specifier
---@param ... unknown number of elements or ...
---@return unknown any
function CFFIInterface.new(ct, ...)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.new(ct, ...)
end

---Create a cdata object
---@param ct string The c-syntax type specifier
---@param nelem number|nil number of elements
---@return number size
function CFFIInterface.sizeof(ct, nelem)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.sizeof(ct, nelem)
end

function CFFIInterface.copy(dst, src, len)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.copy(dst, src, len)
end

function CFFIInterface.fill(dst, len, value)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.fill(dst, len, value)
end

---@param any any
---@return integer number
function CFFIInterface.tonumber(any)
  if dll == nil then error('cffi.dll not initialized') end
  return dll.tonumber(any)
end

---Get a handle to the cffi lua library
---@return CFFIInterface cffi
function cffi:cffi() return dll end


function cffi.enable(self, config)
  if dll == nil then error() end  
    -- bool gc_log_cdata = false;
    -- bool gc_log_lib = false;
    -- bool gc_cdata_tryExcept = false;
  settings("gc_log_cdata", config.debugging.logGC.enabled)
  settings("gc_log_lib", config.debugging.logGC.enabled)
  settings("gc_cdata_tryExcept", config.debugging.tryExceptGC.enabled)
end

function cffi.settings(self)
  return settings
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
