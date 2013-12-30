--------------------------------------------------------------
-- FileName: 	common_func.lua
-- author:		����, 2013/12/28
-- purpose:		���亯����
--------------------------------------------------------------

cclog = function(...)
    print(string.format(...))
end

function table.deepcopy(t, n)
    local newT = {};
	
    if n == nil then
        n = 1;
    end
	
    for i,v in pairs(t) do
        if n > 0 and type(v) == "table" then
            local vecT = table.deepcopy(v, n - 1);
            newT[i] = vecT;
        else
            local x = v;
            newT[i] = x;
        end
    end
	
    return newT;
end