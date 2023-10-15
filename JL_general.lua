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

---@section getNumber
---@param ... integer
---@return number
function getNumber(...)
    local r = {...}
    for i = 1, #r do r[i] = input.getNumber(r[i]) end
    return table.unpack(r)
end
---@endsection

---@section getNumber3
---@param x integer
---@param y integer
---@param z integer
---@return number, number, number
function getNumber3(x, y, z)
    return input.getNumber(x), input.getNumber(y), input.getNumber(z)
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