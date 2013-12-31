--------------------------------------------------------------
-- FileName: 	card_player.lua
-- author:		郭浩, 2013/12/30
-- purpose:		玩家类（多实例）
-- 注意：		这个类会有多个实例，注意用法！
--------------------------------------------------------------

card_player = card_role:new();
local p = card_player;
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
	
	self.m_nRoleType = card_define.PLAYER;
end

function p:initialise(strName)
	return super.initialise(self,strName);
end

function p:showCards()
	card_util.computeCardsSize(self.m_vecOwnCards,8);
	
	return super.showCards(self);
end