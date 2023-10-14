-- Author: Jumper
-- GitHub: https://github.com/Jumper-44

require('JumperLib.Math.JL_matrix_operations')

---@section matrix_getRotX
---Get 3d rotation matrix around x-axis
---@param angle number
---@param _return? matrix3x3
---@return any
function matrix_getRotX(angle, _return)
    _return = matrix_init(3, 3, _return)
    local s, c = math.sin(angle), math.cos(angle)
    _return[1][1] = 1
    _return[2][2] = c
    _return[2][3] = s
    _return[3][2] = -s
    _return[3][3] = c
    return _return
end
---@endsection

---@section matrix_getRotY
---Get 3d rotation matrix around y-axis
---@param angle number
---@param _return? matrix3x3
---@return any
function matrix_getRotY(angle, _return)
    _return = matrix_init(3, 3, _return)
    local s, c = math.sin(angle), math.cos(angle)
    _return[2][2] = 1
    _return[1][1] = c
    _return[1][3] = -s
    _return[3][1] = s
    _return[3][3] = c
    return _return
end
---@endsection

---@section matrix_getRotZ
---Get 3d rotation matrix around z-axis
---@param angle number
---@param _return? matrix3x3
---@return any
function matrix_getRotZ(angle, _return)
    _return = matrix_init(3, 3, _return)
    local s, c = math.sin(angle), math.cos(angle)
    _return[3][3] = 1
    _return[1][1] = c
    _return[1][2] = s
    _return[2][1] = -s
    _return[2][2] = c
    return _return
end
---@endsection

---@section matrix_getRot2d
---Get 2d rotation matrix (around z-axis)
---@param angle number
---@param _return? matrix2x2
---@return any
function matrix_getRot2d(angle, _return)
    _return = _return or matrix_init(2, 2, _return)
    local s, c = math.sin(angle), math.cos(angle)
    _return[1][1] = c
    _return[1][2] = s
    _return[2][1] = -s
    _return[2][2] = c
    return _return
end
---@endsection

---@section matrix_getRotZYX
---Get 3d rotation matrix of the order ZYX, intended when y-axis is up  
---https://www.songho.ca/opengl/gl_anglestoaxes.html
---@param angleX number
---@param angleY number
---@param angleZ number
---@param _return? matrix3x3
---@return any
function matrix_getRotZYX(angleX, angleY, angleZ, _return)
    _return = _return or matrix_init(3, 3, _return)
    local sx,sy,sz, cx,cy,cz = math.sin(angleX),math.sin(angleY),math.sin(angleZ), math.cos(angleX),math.cos(angleY),math.cos(angleZ)
    _return[1][1] = cy*cz
    _return[1][2] = cy*sz
    _return[1][3] = -sy
    _return[2][1] = -cx*sz + sx*sy*cz
    _return[2][2] = cx*cz + sx*sy*sz
    _return[2][3] = sx*cy
    _return[3][1] = sx*sz + cx*sy*cz
    _return[3][2] = -sx*cz + cx*sy*sz
    _return[3][3] = cx*cy
    return _return
end
---@endsection

---@section matrix_getRotZXY
---Get 3d rotation matrix of the order ZYX, intended when z-axis is up  
---https://www.songho.ca/opengl/gl_anglestoaxes.html
---@param angleX number
---@param angleY number
---@param angleZ number
---@param _return? matrix3x3
---@return any
function matrix_getRotZXY(angleX, angleY, angleZ, _return)
    _return = _return or matrix_init(3, 3, _return)
    local sx,sy,sz, cx,cy,cz = math.sin(angleX),math.sin(angleY),math.sin(angleZ), math.cos(angleX),math.cos(angleY),math.cos(angleZ)
    _return[1][1] = cz*cy-sz*sx*sy
    _return[1][2] = sz*cy+cz*sx*sy
    _return[1][3] = -cx*sy
    _return[2][1] = -sz*cx
    _return[2][2] = cz*cx
    _return[2][3] = sx
    _return[3][1] = cz*sy+sz*sx*cy
    _return[3][2] = sz*sy-cz*sx*cy
    _return[3][3] = cx*cy
    return _return
end
---@endsection

---@section matrix_getRotAroundAbitraryAxis
---https://www.songho.ca/opengl/gl_rotate.html
---@param angle number
---@param vec vec3d -- expected to be 3d unit vector
---@param _return? matrix3x3
---@return any
function matrix_getRotAroundAbitraryAxis(angle, vec, _return)
    _return = _return or matrix_init(3, 3, _return)
    local x, y, z, s, c, ic, X, Y, xy, xz, yz, sx, sy, sz
    x, y, z, s, c = vec[1], vec[2], vec[3], math.sin(angle), math.cos(angle)
    ic = 1 - c
    X, Y = ic*x, ic*y
    xy, xz, yz, sx, sy, sz = X*y, X*z, Y*z, s*x, s*y, s*z
    _return[1][1] = X*x + c
    _return[1][2] = xy + sz
    _return[1][3] = xz - sy
    _return[2][1] = xy - sz
    _return[2][2] = Y*y + c
    _return[2][3] = yz + sx
    _return[3][1] = xz + sy
    _return[3][2] = yz - sx
    _return[3][3] = ic*z*z + c
    return _return
end
---@endsection