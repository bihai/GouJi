--------------------------------------------------------------
-- FileName: 	card_manager.lua
-- author:		����, 2013/12/28
-- purpose:		���ƹ����ࣨ��ʵ����
-- ע�⣺		������ǵ�����ע���÷���
--------------------------------------------------------------

card_manager = card_manager or {};
local p = card_manager;

p.m_vecCards = {};
p.m_pScene = nil;
p.m_pCardNode = nil;
p.m_pCardTexture = nil;

function p.initCards(nCount)
	if nil ~= p.m_pCardNode then
		return p.m_pCardNode;
	end
	
	CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("cards/cards.plist","cards/cards.png");
	p.m_pCardTexture = CCTextureCache:sharedTextureCache():textureForKey("cards/cards.png");

	if nil == pTexture then
		cclog("Wrong Key!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	end
		
	p.m_pCardNode = CCSpriteBatchNode:createWithTexture(p.m_pCardTexture);
	local pSprite = CCSprite:createWithSpriteFrameName("hong_1.bmp");
	pSprite:setScale(0.5);
	pSprite:setPosition(background_map.getPosByTiled(10,10));
	p.m_pCardNode:addChild(pSprite);
	
	return p.m_pCardNode;
end

function p.getSpecialCard(strType,nNumber)
	
end