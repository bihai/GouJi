--------------------------------------------------------------
-- FileName: 	card_role.lua
-- author:		郭浩, 2013/12/30
-- purpose:		角色类（多实例）
-- 注意：		这个类会有多个实例，注意用法！
--------------------------------------------------------------

card_role = {}
local p = card_role;

function p:new()	
	o = {};
	setmetatable( o, self );
	self.__index = self;
	o:ctor();
	return o;
end

function p:ctor()
	self.m_vecOwnCards = {};
	self.m_strName = nil;
	self.m_nRoleType = 0;
end

function p:initialise(strName)
	if nil == strName then
		cclog("Null Name");
	end
	
	self.m_strName = strName;
	
	cclog("Create Role! Name Is "..strName);
	return true;
end

function p:showCards()
	cclog(self.m_strName.." has "..#self.m_vecOwnCards.." cards");
	
	if nil == self.m_vecOwnCards then
		cclog("THIS PLAYER iS NO CARDS");
		return false;
	end
	
	if false == self:sortCards() then
		cclog("ERROR SORT CARDS");
		return false;
	end
	
	return true;
end

function p:addCard(pCard)
	if nil == pCard then
		return false;
	end

	table.insert(self.m_vecOwnCards,pCard);
	
	return true;
end

function p:sortCards()
	if nil == self.m_vecOwnCards then
		return false;
	end
	
	if 0 == table.getn(self.m_vecOwnCards) then
		return false;
	end
	
	for i = 1,table.getn(self.m_vecOwnCards) do
		local nCardType = self.m_vecOwnCards[i]:getCardType();
		local strType = "";
		
		if 0 ~= nCardType then
			strType = card_define.CARD_TYPE[nCardType];
		end
		
		cclog(self.m_vecOwnCards[i]:getNumber());
	end
	
	local fBeforeSort = os.clock();
	local fAfterSort = 0.0;
	
	fAfterSort = os.clock();
	
	cclog(string.format("Sort Time Is %f",fAfterSort - fBeforeSort));
	
	pSortFunc = function(a,b)
		return a:getNumber() < b:getNumber()
	end
	
	table.sort(self.m_vecOwnCards,pSortFunc);
	
	for i = 1,table.getn(self.m_vecOwnCards) do
		local nCardType = self.m_vecOwnCards[i]:getCardType();
		local strType = "";
		
		if 0 ~= nCardType then
			strType = card_define.CARD_TYPE[nCardType];
		end
		
		cclog(self.m_vecOwnCards[i]:getNumber());
	end
	
	return true;
end