--------------------------------------------------------------
-- FileName: 	card.lua
-- author:		郭浩, 2013/12/28
-- purpose:		卡牌类（多实例）
-- 注意：		这个类会有多个实例，注意用法！
--------------------------------------------------------------

card = {};
local p = card;

function p:new()
	o = {};
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
	self.m_pPosition = nil;
	self.m_nType = 0;
	self.m_strCardTexture = nil;
end

function p:initialise(nType,nNumber,fScale)
	self.m_nNumber = nNumber;
	self.m_nType = nType;

	if 14 == nNumber then
		self.m_strCardTexture = "black_joker.bmp";
	elseif 15 == nNumber then
		self.m_strCardTexture = "red_joker.bmp";
	else
		self.m_strCardTexture = string.format("%s%d.bmp",card_define.CARD_TYPE[nType],nNumber)
	end
	
	self.m_pSprite = CCSprite:createWithSpriteFrameName(self.m_strCardTexture);
	
	if nil == self.m_pSprite then
		cclog("m_pSprite == nil");
		return false;
	end
	
	if nil == fScale then
		self.m_pSprite:setScale(0.5);
	else
		self.m_pSprite:setScale(fScale);
	end
	
	self.m_pSprite:setPosition(background_map.getPosByTiled(0,0));
	self.m_pSprite:setVisible(false);
	
	return true;
end

function p:getContentSize()
	return self.m_pSprite:getContentSize()
end

function p:getBoundingBoxSize()
	return self.m_pSprite:boundingBox();
end

function p:getSkin()
	return self.m_bSkin;
end

function p:getCardType()
	return self.m_nType;
end

function p:getNumber()
	return self.m_nNumber;
end

function p:setSkin(bValue)
	self.m_bSkin = bValue;

	local pFrame = nil;
	
	if bValue then
		pFrame = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName("skin.bmp");
	else
		pFrame = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(self.m_strCardTexture);
	end
	
	if pFrame ~= nil then
		self.m_pSprite:setDisplayFrame(pFrame);
	end
end

function p:getSprite()
	return self.m_pSprite;
end

function p:setTilePos(pPos)
	if nil == pPos then
		cclog("Wrong Pos setTilePos");
		return;
	end
	
	self.m_pPosition = pPos;
	self.m_pSprite:setPosition(background_map.getPosByTiled(pPos.x,pPos.y));
end