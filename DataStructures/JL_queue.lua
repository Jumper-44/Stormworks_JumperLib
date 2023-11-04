-- Author: Jumper
-- GitHub: https://github.com/Jumper-44
-- MIT License at end of this file

---https://www.lua.org/pil/11.4.html
---@return queue
function queue()
    ---@class queue
    ---@field queue_pushLeft fun(value: any)
    ---@field queue_pushRight fun(value: any)
    ---@field queue_popLeft fun():any
    ---@field queue_popRight fun():any
    ---@field queue_isEmpty fun():boolean
    ---@field queue_size fun():integer
    local queue, first, last, return_value = {first = 0, last = -1}, 0, 0, 0

    ---@section queue_pushLeft
    ---@param value any
    function queue.queue_pushLeft(value)
        first = queue.first - 1
        queue.first = first
        queue[first] = value
    end
    ---@endsection

    ---@section queue_pushRight
    ---@param value any
    function queue.queue_pushRight(value)
        last = queue.last + 1
        queue.last = last
        queue[last] = value
    end
    ---@endsection

    ---@section queue_popLeft
    ---@return any
    function queue.queue_popLeft()
        first = queue.first
        return_value = queue[first]
        queue[first] = nil
        queue.first = first + 1
        return return_value
    end
    ---@endsection

    ---@section queue_popRight
    ---@return any
    function queue.queue_popRight()
        last = queue.last
        return_value = queue[last]
        queue[last] = nil
        queue.last = last - 1
        return return_value
    end
    ---@endsection

    ---@section queue_isEmpty
    ---@return boolean
    function queue.queue_isEmpty()
        return queue.first > queue.last
    end
    ---@endsection

    ---@section queue_size
    ---@return integer
    function queue.queue_size()
        return queue.last - queue.first + 1
    end
    ---@endsection

    return queue
end


---@section __queue_DEBUG__
--do
--    local q = queue()
--    print(tostring( q.queue_isEmpty() ).." "..tostring( q.queue_size() ))
--    q.queue_pushLeft(5)
--    print(tostring( q.queue_isEmpty() ).." "..tostring( q.queue_size() ))
--    print(q.queue_popRight())
--    print(tostring( q.queue_isEmpty() ).." "..tostring( q.queue_size() ))
--end
--do
--    print("...")
--    local q = queue()
--    q.queue_pushRight(531)
--    q.queue_pushRight(721)
--    print(tostring( q.queue_isEmpty() ).." "..tostring( q.queue_size() ))
--    print(q.queue_popLeft())
--    print(tostring( q.queue_isEmpty() ).." "..tostring( q.queue_size() ))
--end
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