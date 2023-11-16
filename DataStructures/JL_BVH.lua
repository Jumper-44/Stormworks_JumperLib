-- Author: Jumper
-- GitHub: https://github.com/Jumper-44
-- MIT License at end of this file

require("DataStructures.JL_list")

---@section BVH_AABB 1 _BVH_AABB_
---@class BoundingVolumeHierarchyAABB
---@field BVH_nodes list
---@field BVH_rootIndex integer
---@field BVH_insert fun(item: number|table|true, minAABB: table<number, number, number>, maxAABB: table<number, number, number>): integer
---@field BVH_remove fun(LeafNode: integer)
---@field BVH_treeCost fun(): number

---Incrementive Bounding Volume Hierarchy (BVH) constructed by Surface Area Heuristic (SAH) of axis-aligned bounding box (AABB).  
---Base class with insert and remove. Implement own search like frustum culling or ray intersection.  
---Reference for implementation of insertion SAH https://box2d.org/files/ErinCatto_DynamicBVH_Full.pdf
---@return BoundingVolumeHierarchyAABB
BVH_AABB = function()
    local AABB_min_buffer, AABB_max_buffer, temp_table, AABB_minX, AABB_minY, AABB_minZ, AABB_maxX, AABB_maxY, AABB_maxZ, node_child1, node_child2, node_parent, node_item, node_surfaceArea, node_buffer =
        {0,0,0}, {0,0,0}, {},   -- AABB_min_buffer, AABB_max_buffer, temp_table
        {}, {}, {}, {}, {}, {}, -- AABB_minX, AABB_minY, AABB_minZ, AABB_maxX, AABB_maxY, AABB_maxZ
        {}, {}, {}, {}, {},     -- node_child1, node_child2, node_parent, node_item, node_surfaceArea
        {false, false, false, false, 0, 0,0,0, 0,0,0}

    local BVH, nodes, AABB_min, AABB_max =
        {},
        list({node_child1, node_child2, node_parent, node_item, node_surfaceArea,  AABB_minX, AABB_minY, AABB_minZ, AABB_maxX, AABB_maxY, AABB_maxZ}),
        {AABB_minX, AABB_minY, AABB_minZ}, {AABB_maxX, AABB_maxY, AABB_maxZ}

    local temp1, temp2, temp3, temp4, index, newNode, newNode_SA, unionAABB, surfaceAreaAABB, best_sibling, best_cost, inherited_cost

    BVH.BVH_rootIndex = false
    BVH.BVH_nodes = nodes

    ---@param node integer
    ---@param minAABB table<number, number, number>
    ---@param maxAABB table<number, number, number>
    function unionAABB(node, minAABB, maxAABB)
        for i = 1, 3 do
            AABB_min_buffer[i] = math.min(AABB_min[i][node], minAABB[i])
            AABB_max_buffer[i] = math.max(AABB_max[i][node], maxAABB[i])
        end
    end

    ---@param minAABB table<number, number, number>
    ---@param maxAABB table<number, number, number>
    ---@return number
    function surfaceAreaAABB(minAABB, maxAABB)
        temp1, temp2, temp3 = maxAABB[1] - minAABB[1], maxAABB[2] - minAABB[2], maxAABB[3] - minAABB[3]
        return temp1 * temp2 + temp2 * temp3 + temp3 * temp1 -- (dx * dy + dy * dz + dz * dx)
    end

    ---@section BVH_refitAAB
    ---Walk up the tree refitting AABBs and set node surface area
    ---@param node integer|false
    BVH.BVH_refitAABBs = function(node)
        while node do
            temp1 = node_child1[node]
            temp2 = node_child2[node]
            for i = 1, 3 do -- Set node AABB to union(child1, child2)
                temp3 = AABB_min[i]
                temp4 = AABB_max[i]
                temp3[node] = math.min(temp3[temp1], temp3[temp2])
                temp4[node] = math.max(temp4[temp1], temp4[temp2])
                temp_table[i] = temp4[node] - temp3[node] -- delta of min and max AABB bounds, for SA
            end

            -- Could try apply tree rotations here. [Reference: Page 111-127]

            temp1 = node_surfaceArea[node]
            temp2 = temp_table[1]*temp_table[2] + temp_table[2]*temp_table[3] + temp_table[3]*temp_table[1]
            if temp1 == temp2 then break end -- Early termination if surface area remains the same

            node_surfaceArea[node] = temp2
            node = node_parent[node]
        end
    end
    ---@endsection

    ---@section BVH_insert
    ---comment
    ---@param item number|table|true
    ---@param minAABB table<number, number, number>
    ---@param maxAABB table<number, number, number>
    ---@return integer leafNode
    BVH.BVH_insert = function(item, minAABB, maxAABB) -- [Reference: Page 54]
        newNode = nodes.list_insert(node_buffer)
        node_item[newNode] = item
        newNode_SA = surfaceAreaAABB(minAABB, maxAABB)
        node_surfaceArea[newNode] = newNode_SA
        for i = 1, 3 do
            AABB_min[i][newNode] = minAABB[i]
            AABB_max[i][newNode] = maxAABB[i]
        end

        index = BVH.BVH_rootIndex
        if index then
            best_sibling = index
            unionAABB(index, minAABB, maxAABB)
            best_cost = surfaceAreaAABB(AABB_min_buffer, AABB_max_buffer)
            inherited_cost = best_cost - node_surfaceArea[index]

            -- Find best sibling that adds least surface area to tree. [Reference: Page 77-88]
            while (node_item[index] == false) and (newNode_SA + inherited_cost < best_cost) do -- Is node not a leaf and is lowerbound cost of child nodes less than best_cost. [Reference: Page 86-87]
                for i = 1, 2 do
                    temp4 = nodes[i][index] -- child1|2 index
                    unionAABB(temp4, minAABB, maxAABB)
                    temp1 = surfaceAreaAABB(AABB_min_buffer, AABB_max_buffer) + inherited_cost -- new_cost

                    if temp1 < best_cost then -- is new_cost better/less than best_cost
                        best_cost = temp1
                        best_sibling = temp4
                        inherited_cost = temp1 - node_surfaceArea[temp4]
                    end
                end

                if index == best_sibling then break end -- The children was not better cost than parent
                index = best_sibling
            end

            -- Insert newNode in tree and walk back up the tree refitting AABBs [Reference: Page 56-57]
            temp1 = nodes.list_insert(node_buffer) -- newParent
            temp2 = node_parent[best_sibling]      -- oldParent
            node_parent[temp1] = temp2
            node_child1[temp1] = best_sibling
            node_child2[temp1] = newNode
            node_parent[best_sibling] = temp1
            node_parent[newNode] = temp1

            if temp2 then -- best_sibling was not root
                nodes[node_child1[temp2] == best_sibling and 1 or 2][temp2] = temp1
            else -- best_sibling was root
                BVH.BVH_rootIndex = temp1
            end

            BVH.BVH_refitAABBs(temp1)
        else -- Is first/root node in tree
            BVH.BVH_rootIndex = newNode
        end

        return newNode
    end
    ---@endsection

    ---@section BVH_remove
    ---Remove node containing 'item', i.e. a leaf node.  
    ---@param leafNode integer
    BVH.BVH_remove = function(leafNode)
        nodes.list_remove(leafNode)
        temp1 = node_parent[leafNode]

        if temp1 then -- leafNode was not root
            nodes.list_remove(temp1)
            temp2 = node_parent[temp1]

            temp3 = nodes[node_child1[temp1] == leafNode and 2 or 1][temp1] --leafNode sibling
            node_parent[temp3] = temp2

            if temp2 then -- Set leafNode.parent.parent child reference to leafNode sibling
                nodes[node_child1[temp2] == temp1 and 1 or 2][temp2] = temp3
            else -- leafNode.parent was root
                BVH.BVH_rootIndex = temp3
            end

            BVH.BVH_refitAABBs(temp2)
        else -- leafNode was root
            BVH.BVH_rootIndex = false
        end
    end
    ---@endsection

    ---@section BVH_treeCost
    ---Debug function. Returns the sum of all internal nodes area.  
    ---If two trees have the same leaf nodes, then the tree with smaller cost is better by SAH cost metric.  
    ---If -1 is returned, then it was undetermined. (Didn't bother code a brute force check depending on a condition)  
    ---[Reference: Page 74]
    ---@return number cost
    BVH.BVH_treeCost = function()
        local cost = 0
        if #nodes.removed_id == 0 then
            for i = 1, #node_item do
                if node_item[i] == false then -- is internal node
                    cost = cost + node_surfaceArea[i]
                end
            end
        else
            cost = -1
        end
        return cost
    end
    ---@endsection

    return BVH
end
---@endsection _BVH_AABB_



---@section __DEBUG_BVH_AABB__
do
    local bvh = BVH_AABB()
    local AABB_minX, AABB_minY, AABB_minZ, AABB_maxX, AABB_maxY, AABB_maxZ, BVH_ID = {},{},{}, {},{},{}, {}
    local AABB = list({AABB_minX, AABB_minY, AABB_minZ, AABB_maxX, AABB_maxY, AABB_maxZ, BVH_ID})
    local AABB_min, AABB_max = {AABB_minX, AABB_minY, AABB_minZ}, {AABB_maxX, AABB_maxY, AABB_maxZ}
    local AABB_buffer, AABB_min_buffer, AABB_max_buffer = {0,0,0, 0,0,0, 0}, {0,0,0}, {0,0,0}

    local fetchAABB = function(id)
        for i = 1, 3 do
            AABB_min_buffer[i] = AABB_min[i][id]
            AABB_max_buffer[i] = AABB_max[i][id]
        end
    end

    math.randomseed(0)
    local rand = function(scale)
        return (math.random() - 0.5) * (scale or 1)
    end

    local n = 10000
    local temp = 0
    for i = 1, n do
        for j = 1, 3 do
            temp = rand(10000)

            AABB_buffer[j] = temp - 5 + rand(3)
            AABB_buffer[j+3] = temp + 5 + rand(3)
        end
        AABB.list_insert(AABB_buffer)
    end

    local t1 = os.clock()
    for i = 1, n do
        fetchAABB(i)
        BVH_ID[i] = bvh.BVH_insert(i, AABB_min_buffer, AABB_max_buffer)
    end
    local t2 = os.clock()
    print("init time1: "..(t2-t1))
    print(bvh.BVH_treeCost())

    for i = 1, n do
        bvh.BVH_remove(BVH_ID[i])
    end

    t1 = os.clock()
    for i = 1, n do
        fetchAABB(i)
        BVH_ID[i] = bvh.BVH_insert(i, AABB_min_buffer, AABB_max_buffer)
    end
    t2 = os.clock()

    print("init time2: "..(t2-t1))
    print(bvh.BVH_treeCost()) -- expected to be the same as earlier BVH.treeCost print
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