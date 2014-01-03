--------------------------------------------------------------
-- FileName: 	card_ai.lua
-- author:		郭浩, 2013/12/31
-- purpose:		AI类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

card_ai = card_ai or {};
local p = card_ai;

function p.getNuts(vecCards,vecOwnCards)	
	local vecNuts = {};
	
	if nil == vecCards or 0 == table.getn(vecCards) then
		for i = 1,4 * 4 do
			local vecList = card_util.getCardGroup(vecOwnCards,i,false);
			
			if 0 < table.getn(vecList) then
				vecNuts = vecList[1];
				return vecNuts;
			end
		end
	end
	
	local nSameCount = table.getn(vecCards);
	local vecTable = card_util.getCardGroup(vecOwnCards,nSameCount,false);
	
	for i = 1,table.getn(vecTable) do
		local pCard = vecOwnCards[vecTable[i][1]];
		
		if nil ~= pCard then
			if pCard:getNumber() > vecCards[1]:getNumber() then
				vecNuts = vecTable[i];
				return vecNuts;
			end
		end
	end
	
	return vecNuts;
end