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

function p:free()
end

function p:initialise(strName)
	return super.initialise(self,strName);
end

function p:showCards()
	local pSize = card_util.computeCardsSize(self.m_vecOwnCards,card_define.CARD_SPACE);

	if nil == pSize then
		return false;
	end
	
	local x = pSize.origin.x;
	local y = pSize.origin.y;
	local nTempX = x;
	
	for k,v in ipairs(self.m_vecOwnCards) do
		v:setPos(ccp(nTempX,y));
		v:setVisible(true);
		v:reOrder(k);
		nTempX = nTempX + card_define.CARD_SPACE;
	end
	
	return super.showCards(self);
end