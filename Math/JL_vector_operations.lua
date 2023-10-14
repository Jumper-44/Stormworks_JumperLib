-- Author: Jumper
-- GitHub: https://github.com/Jumper-44

-- Vector library with focus on reusing tables for operations

---@alias vec table
---@alias vec2d table
---@alias vec3d table
---@alias vec4d table

---@section str_to_vec
---Given a string with arbitrary length of the pattern "x,y,...,n" then return the table/vector {x, y, ..., n}
---@param str string
---@param _return? table if table given with array entries then elements will be inserted after #_return
---@return vec
function str_to_vec(str, _return)
    _return = _return or {}
    for v in str:gmatch("([^,]+)") do
        _return[#_return+1] = tonumber(v)
    end
    return _return
end
---@endsection

---@section vec_init2d
---Init 2d vector with array part
---@param x? number
---@param y? number
---@return vec2d
function vec_init2d(x, y)
    return {x or 0, y or 0}
end
---@endsection

---@section vec_init3d
---Init 3d vector with array part
---@param x? number
---@param y? number
---@param z? number
---@return vec3d
function vec_init3d(x, y, z)
    return {x or 0, y or 0, z or 0}
end
---@endsection

---@section vec_init4d
---Init 3d vector with array part
---@param x? number
---@param y? number
---@param z? number
---@param w? number
---@return vec4d
function vec_init4d(x, y, z, w)
    return {x or 0, y or 0, z or 0, w or 0}
end
---@endsection

---@section vec_init
---comment
---@param rows integer
---@param _return? vec
---@return any
function vec_init(rows, _return)
    _return = _return or {}
    for i = 1, rows do
        _return[i] = 0
    end
    return _return
end
---@endsection

---@section vec_add
---comment
---@param a vec
---@param b vec
---@param _return vec
---@return any
function vec_add(a, b, _return)
    for i = 1, #a do
        _return[i] = a[i] + b[i]
    end
    return _return
end
---@endsection

---@section vec_sub
---comment
---@param a vec
---@param b vec
---@param _return vec
---@return any
function vec_sub(a, b, _return)
    for i = 1, #a do
        _return[i] = a[i] - b[i]
    end
    return _return
end
---@endsection

---@section vec_scale
---comment
---@param a vec
---@param scalar number
---@param _return vec
---@return any
function vec_scale(a, scalar, _return)
    for i = 1, #a do
        _return[i] = a[i] * scalar
    end
    return _return
end
---@endsection

---@section vec_mult
---Element-wise product (Vector Hadamard product)
---@param a vec
---@param b vec
---@param _return vec
---@return any
function vec_mult(a, b, _return)
    for i = 1, #a do
        _return[i] = a[i] * b[i]
    end
    return _return
end
---@endsection

---@section vec_sum
---Sum all elements of vector
---@param a vec
---@return number
function vec_sum(a)
    local sum = 0
    for i = 1, #a do
        sum = sum + a[i]
    end
    return sum
end
---@endsection

---@section vec_dot
---comment
---@param a vec
---@param b vec
---@return number
function vec_dot(a, b)
    local sum = 0
    for i = 1, #a do
        sum = sum + a[i]*b[i]
    end
    return sum
end
---@endsection

---@section vec_cross
---comment
---@param a vec
---@param b vec
---@param _return vec
---@return vec3d?
function vec_cross(a, b, _return)
    _return[1], _return[2], _return[3] =
        a[2]*b[3] - a[3]*b[2],
        a[3]*b[1] - a[1]*b[3],
        a[1]*b[2] - a[2]*b[1]
    return _return
end
---@endsection

---@section vec_det2d
---comment
---@param a vec
---@param b vec
---@return number
function vec_det2d(a, b)
    return a[1]*b[2] - a[2]*b[1]
end
---@endsection

---@section vec_det3d
---comment
---@param a vec
---@param b vec
---@param c vec
---@return number
function vec_det3d(a, b, c)
    return a[1]*b[2]*c[3] + b[1]*c[2]*a[3] + c[1]*a[2]*b[3] - c[1]*b[2]*a[3] - b[1]*a[2]*c[3] - a[1]*c[2]*b[3]
end
---@endsection

---@section vec_len
---comment
---@param a vec
---@return number
function vec_len(a)
    return vec_dot(a, a)^0.5
end
---@endsection

---@section vec_len2
---comment
---@param a vec
---@return number
function vec_len2(a)
    return vec_dot(a, a)
end
---@endsection

---@section vec_normalize
---comment
---@param a vec
---@param _return vec
---@return any
function vec_normalize(a, _return)
    return vec_scale(a, vec_len(a), _return)
end
---@endsection

---@section vec_clone
---comment
---@param a vec
---@param _return? vec
---@return any
function vec_clone(a, _return)
    _return = _return or {}
    for i = 1, #a do
        _return[i] = a[i]
    end
    return _return
end
---@endsection

---@section vec_invert
---comment
---@param a vec
---@param _return vec
---@return any
function vec_invert(a, _return)
    return vec_scale(a, -1, _return)
end
---@endsection

---@section vec_project
---comment
---@param a vec
---@param b vec
---@param _return vec
---@return any
function vec_project(a, b, _return)
    return vec_scale(b, vec_dot(a, b), _return)
end
---@endsection

---@section vec_reject
do
    local temp = {}
    ---comment
    ---@param a vec
    ---@param b vec
    ---@param _return vec
    ---@return any
    function vec_reject(a, b, _return)
        return vec_sub(a, vec_project(a, b, temp), _return)
    end
end
---@endsection

---@section vec_angle
---Returns angle between two vectors
---@param a vec
---@param b vec
---@return number radians
function vec_angle(a, b)
    return math.acos(vec_dot(a, b) / (vec_len(a) * vec_len(b)))
end
---@endsection

---@section vec_stoc
---spherical to cartesian conversion, in which y-axis is up
---@param horizontal_ang number
---@param vertical_ang number
---@param magnitude? number
---@param temp nil -- dirty local variable to reduce char
---@return any
function vec_stoc(horizontal_ang, vertical_ang, magnitude, temp)
    magnitude = magnitude or 1
    temp = math.cos(vertical_ang) * magnitude
    return {
        math.cos(horizontal_ang) * temp,
        math.sin(vertical_ang) * magnitude,
        math.sin(horizontal_ang) * temp
    }
end
---@endsection

---@section vec_ctos
---cartesian to spherical
---@param a vec
---@param temp nil -- dirty local to reduce char
---@return number, number, number
function vec_ctos(a, temp)
    temp = vec_len(a)
    return math.atan(a[3], a[1]), math.asin(a[2]/temp), temp
end
---@endsection


---@section vec_tolocal3d
---transposedMatrix-vector multiplication : _return = <b_x|b_y|b_z><sup>T</sup> * a  
---if matrix is orthonormal (i.e. rotation matrix) then the transpose is the same as inverse  
---a and b_x|y|z are expected to be 3D.  
---b_x|y|z are basis vectors
---@param a vec3d
---@param b_x vec3d
---@param b_y vec3d
---@param b_z vec3d
---@param _return vec
---@return any
function vec_tolocal3d(a, b_x, b_y, b_z, _return)
    _return[1], _return[2], _return[3] =
        vec_dot(b_x, a),
        vec_dot(b_y, a),
        vec_dot(b_z, a)
    return _return
end
---@endsection

---@section vec_toglobal3d
do
    local temp1, temp2 = {}, {}
    ---matrix-vector multiplication : _return = <b_x|b_y|b_z> * a  
    ---a and b_x|y|z are expected to be 3D.  
    ---b_x|y|z are basis vectors
    ---@param a vec3d
    ---@param b_x vec3d
    ---@param b_y vec3d
    ---@param b_z vec3d
    ---@param _return vec
    ---@return any
    function vec_toglobal3d(a, b_x, b_y, b_z, _return)
        return vec_add(
            vec_add(
                vec_scale(b_x, a[1], temp1),
                vec_scale(b_y, a[2], temp2),
                temp2
            ),
            vec_scale(b_z, a[3], temp1),
            _return
        )
    end
end
---@endsection