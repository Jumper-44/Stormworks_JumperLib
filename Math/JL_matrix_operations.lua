-- Author: Jumper
-- GitHub: https://github.com/Jumper-44
-- MIT License at end of this file

require('JumperLib.Math.JL_vector_operations')

---matrices are read column-major order like: m[column][row]  
---m[1][1], m[2][1], m[3][1]  
---m[1][2], m[2][2], m[3][2]
---@alias matrix table<number, table<number, number>>
---@alias matrix2x2 matrix
---@alias matrix3x3 matrix
---@alias matrix4x4 matrix

---@section matrix_init
---init matrix : m[column][row]
---@param rows integer
---@param columns integer
---@param _return? matrix
---@return any
function matrix_init(rows, columns, _return)
    _return = _return or {}
    for i = 1, columns do
        _return[i] = _return[i] or {}
        for j = 1, rows do
            _return[i][j] = 0
        end
    end
    return _return
end
---@endsection

---@section matrix_initIdentity
---init identity matrix : m[column][row]
---@param rows integer
---@param columns integer
---@param _return? matrix
---@return any
function matrix_initIdentity(rows, columns, _return)
    _return = matrix_init(rows, columns, _return)
    for i = 1, math.min(rows, columns) do
        _return[i][i] = 1
    end
    return _return
end
---@endsection

---@section matrix_clone
---clone matrix
---@param m matrix
---@param _return? matrix
---@return any
function matrix_clone(m, _return)
    _return = _return or {}
    for i = 1, #m do
        _return[i] = _return[i] or {}
        for j = 1, #m[1] do
            _return[i][j] = m[i][j]
        end
    end
    return _return
end
---@endsection

---@section matrix_transpose
---matrix transpose
---@param m matrix
---@param _return? matrix -- Cannot be *@param* **m**
---@return any
function matrix_transpose(m, _return)
    _return = _return or {}
    for i = 1, #m[1] do
        _return[i] = _return[i] or {}
        for j = 1, #m do
            _return[i][j] = m[j][i]
        end
    end
    return _return
end
---@endsection

---@section matrix_mult
---matrix multiplication
---@param a matrix
---@param b matrix
---@param _return? matrix
---@return any
function matrix_mult(a, b, _return)
    _return = _return or {}
    for i=1, #b do
        _return[i] = _return[i] or {}
        for j=1, #a[1] do
            _return[i][j] = 0
            for k=1, #a do
                _return[i][j] = _return[i][j] + a[k][j] * b[i][k]
            end
        end
    end
    return _return
end
---@endsection

---@section matrix_multVec2d
---comment
---@param m matrix2x2
---@param v vec2d
---@param _return vec2d
---@return any
function matrix_multVec2d(m, v, _return)
    for i = 1, 2 do
        _return[i] = m[1][i]*v[1] + m[2][i]*v[2]
    end
    return _return
end
---@endsection

---@section matrix_multVec3d
---comment
---@param m matrix3x3
---@param v vec3d
---@param _return vec3d
---@return any
function matrix_multVec3d(m, v, _return)
    for i = 1, 3 do
        _return[i] = m[1][i]*v[1] + m[2][i]*v[2] + m[3][i]*v[3]
    end
    return _return
end
---@endsection

---@section matrix_multVec4d
---comment
---@param m matrix4x4
---@param v vec4d
---@param _return vec4d
---@return any
function matrix_multVec4d(m, v, _return)
    for i = 1, 4 do
        _return[i] = m[1][i]*v[1] + m[2][i]*v[2] + m[3][i]*v[3] + m[4][i]*v[4]
    end
    return _return
end
---@endsection

---@section matrix_unpackRowMajor
---https://en.wikipedia.org/wiki/Row-_and_column-major_order
---@param m matrix
---@param _return vec
---@overload fun(m:matrix, _return:vec):vec
---@return vec
function matrix_unpackRowMajor(m, _return)
    for i = 1, #m[1] do
        for j = 1, #m do
            _return[(i-1)*#m + j] = m[j][i]
        end
    end
    return _return
end
---@endsection

---@section matrix_unpackColumnMajor
---https://en.wikipedia.org/wiki/Row-_and_column-major_order
---@param m matrix
---@param _return vec
---@overload fun(m:matrix, _return:vec):vec
---@return vec
function matrix_unpackColumnMajor(m, _return)
    for i = 1, #m do
        for j = 1, #m[1] do
            _return[(i-1)*#m[1] + j] = m[i][j]
        end
    end
    return _return
end
---@endsection




-- MIT License
-- 
-- Copyright (c) 2023 Jumper-44
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.