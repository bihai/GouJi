--------------------------------------------------------------
-- FileName: 	card_scene.lua
-- author:		郭浩, 2013/12/28
-- purpose:		卡牌场景类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

card_scene = card_scene or {};
local p = card_scene;

p.m_pScene = nil;

function p.init()
	if p.m_pScene == nil then
		p.m_pScene = CCScene:create();

		CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("cards/cards.plist","cards/cards.png");
		local pTexture = CCTextureCache:sharedTextureCache():textureForKey("cards/cards.png");

		if nil == pTexture then
			cclog("Wrong Key!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		end
		
		local pNode = CCSpriteBatchNode:createWithTexture(pTexture);
		p.m_pScene:addChild(pNode);
		local pSprite = CCSprite:createWithSpriteFrameName("cl1.bmp");
		pSprite:setPosition(ccp(200,100));
		pNode:addChild(pSprite);
		
	end
	return true;
end

function p.getScene()	
	return p.m_pScene;
end