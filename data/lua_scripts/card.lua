--------------------------------------------------------------
-- FileName: 	card.lua
-- author:		郭浩, 2013/12/28
-- purpose:		卡牌类（多实例）
-- 注意：		这个类会有多个实例，注意用法！
--------------------------------------------------------------

card = {};
local p = card;

function p:new()	
	o = {}
	setmetatable( o, self );
	self.__index = self;
	o:ctor();
	return o;
end

--构造函数
function p:ctor()
	self.m_pSprite = nil;
	self.m_nNumber = 0;
	self.m_bSkin = true;
end

function p:initialise(pCardTexture,nNumber)
	
	self.m_nNumber = nNumber;
	
	return true;
end

function p:getSkin()
	return self.m_bSkin;
end

function p:setSkin(bValue)
	self.m_bSkin = bValue;
end