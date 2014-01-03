--------------------------------------------------------------
-- FileName: 	card_npc.lua
-- author:		郭浩, 2013/12/30
-- purpose:		NPC类（多实例）
-- 注意：		这个类会有多个实例，注意用法！
--------------------------------------------------------------

card_npc = card_role:new();
local p = card_npc;
local super = card_role;

function p:new()
	o = {};
	setmetatable( o, self );
	self.__index = self;
	o:ctor();
	return o;
end

function p:ctor()
    super.ctor(self);
	self.m_nRoleType = card_define.ROLE_NPC;
end

function p:turnCards(preList)
	if nil == preList then
		cclog("turncards get preList is nil,do you copy?");
		return nil;
	end
	
	local vecRetPos = card_ai.getNuts(preList,self.m_vecOwnCards);
	
	if nil == vecRetPos or type(vecRetPos) ~= "table" then
		return nil;
	end
	
	local vecCards = {};

	cclog(self.m_strName.."\n\nCards those:");
	
	for k,v in ipairs(vecRetPos) do
		local pCard = self.m_vecOwnCards[v];
		table.remove(self.m_vecOwnCards[v]);
		
		if nil == pCard then
			return false;
		end

		cclog(pCard:getNumber());
		
		table.insert(vecCards,pCard);
	end

	card_manager.roleCards(vecCards);
	
	return vecCards;
end

function p:initialise(strName)
	if nil == strName then
		cclog("NULL NAME!");
		return false;
	end
	
	super.initialise(self,strName);
end