-- Author: Jumper
-- GitHub: https://github.com/Jumper-44



---@section vec3
---@class vec3
---@field x number
---@field y number
---@field z number
---@field add fun(a:vec3, b:vec3):vec3
---@field sub fun(a:vec3, b:vec3):vec3
---@field scale fun(a:vec3, b:number):vec3
---@field dot fun(a:vec3, b:vec3):number
---@field cross fun(a:vec3, b:vec3):vec3
---@field len fun(a:vec3):number
---@field normalize fun(a:vec3):vec3
---@field unpack fun(a:vec3, ...:any):number, number, number, ...:any
---@field mult fun(a:vec3, b:vec3):vec3
---@field project fun(a:vec3, b:vec3):vec3
---@field reject fun(a:vec3, b:vec3):vec3
---@field tolocal fun(a:vec3, r:vec3, f:vec3, u:vec3):vec3
---@field toglobal fun(a:vec3, r:vec3, f:vec3, u:vec3):vec3
---@field tospherical fun(a:vec3, r:vec3, f:vec3, u:vec3, c?:vec3):vec3
---Convenient, but slow vector class with x|y|z hash entries and capable of using ':' sugar syntax for vector operations
---@param x? number
---@param y? number
---@param z? number
---@return vec3
function vec3(x,y,z) return {
    x=x or 0,
    y=y or 0,
    z=z or 0,
    add         = function(a,b)     return vec3(a.x+b.x,a.y+b.y,a.z+b.z) end,
    sub         = function(a,b)     return vec3(a.x-b.x,a.y-b.y,a.z-b.z) end,
    scale       = function(a,b)     return vec3(a.x*b,a.y*b,a.z*b) end,
    dot         = function(a,b)     return a.x*b.x+a.y*b.y+a.z*b.z end,
    cross       = function(a,b)     return vec3(a.y*b.z-a.z*b.y,a.z*b.x-a.x*b.z,a.x*b.y-a.y*b.x) end,
    len         = function(a)       return a:dot(a)^0.5 end,
    normalize   = function(a)       return a:scale(1/a:len()) end,
    unpack      = function(a,...)   return a.x,a.y,a.z,... end,
    clone       = function(a)       return vec3(a.x,a.y,a.z) end,
    mult        = function(a,b)     return vec3(a.x*b.x,a.y*b.y,a.z*b.z) end,
    project     = function(a,b)     return b:scale(a:dot(b)) end,
    reject      = function(a,b)     return a:sub(a:project(b)) end,
    tolocal     = function(a,r,f,u) return vec3(r:dot(a),f:dot(a),u:dot(a)) end,
    toglobal    = function(a,r,f,u) return r:scale(a.x):add(f:scale(a.y)):add(u:scale(a.z)) end,
    tospherical = function(a,r,f,u,c) local b = a:tolocal(r,f,u):sub(c or vec3()) return vec3(math.atan(b.x,b.y),math.asin(b.z/(b:len()))) end
} end
---@endsection

---@section stoc_vec3
---spherical to cartesian conversion
---@param hor number
---@param ver number
---@param d? number
---@return vec3
function stoc_vec3(hor, ver, d)
    d = d or 1
    return vec3(math.sin(hor) * math.cos(ver) * d, math.cos(hor) * math.cos(ver) * d, math.sin(ver) * d)
end
---@endsection

---@section str2vec3
---comment
---@param str string
---@return vec3
function str2vec3(str) --separator , x,y,z
    local x, y, z = str:match("([^,]+),([^,]+),([^,]+)")
    return vec3(tonumber(x), tonumber(y), tonumber(z))
end
---@endsection