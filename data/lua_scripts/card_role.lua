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
	
	for i = 1,table.getn(self.m_vecOwnCards) do
		local nCardType = self.m_vecOwnCards[i]:getCardType();
		local strType = "";
		
		if 0 ~= nCardType then
			strType = card_define.CARD_TYPE[nCardType];
		end
		
		cclog(strType..self.m_vecOwnCards[i]:getNumber());
	end
end

function p:addCard(pCard)
	if nil == pCard then
		return false;
	end

	table.insert(self.m_vecOwnCards,pCard);
	
	return true;
end