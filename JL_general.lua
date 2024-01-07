-- Author: Jumper
-- GitHub: https://github.com/Jumper-44
-- MIT License at end of this file

---@section tau
tau = math.pi*2
---@endsection

---@section clamp
---Clamp the value x in the range [s;l]
---@param x number
---@param s number
---@param l number
---@return number
function clamp(x,s,l)
    return x < s and s or x > l and l or x
end
---@endsection

---@section getMultipleNumber
---@param ... integer
---@return number
function getMultipleNumber(...)
    local r = {...}
    for i = 1, #r do r[i] = input.getNumber(r[i]) end
    return table.unpack(r)
end
---@endsection

---@section getNumber3
---@param x? integer
---@param y? integer
---@param z? integer
---@return number, number, number
function getNumber3(x, y, z)
    return input.getNumber(x), input.getNumber(y), input.getNumber(z)
end
---@endsection


---@section pack_uint16_pair_to_float
---Useful for encoding/packing 2 uint16 into a float representation, such that it can be outputtet with composite  
---and be decoded/unpacked by unpack_float_to_uint16_pair(float)  
---  
---Note that there are 256 integers that cannot be converted to float and vice versa,  
---which is reflected with 'b' parameter, which range is 256 less than 'a'.
---@param a integer range [0, 2^16-1]
---@param b integer range [0, 2^16-257]
---@return number
function pack_uint16_pair_to_float(a, b)
    return ( ('f'):unpack(('I2I2'):pack(a, b + b//32640*64)) )
end
---@endsection

---@section unpack_float_to_uint16_pair
---@param a number pack_uint16_pair_to_float(a, b)
---@param b nil local var
---@overload fun(a: number): int16: integer, partial_int16: integer
---@return integer uint16 range [0, 2^16-1]
---@return integer partial_uint16 range [0, 2^16-257]
function unpack_float_to_uint16_pair(a, b)
    a, b = ('I2I2'):unpack(('f'):pack(a))
    return a, b - b//32704*64
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