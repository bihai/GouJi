--------------------------------------------------------------
-- FileName: 	card_scene.lua
-- author:		郭浩, 2013/12/28
-- purpose:		卡牌场景类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

require "background_map";

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
		pNode:addChild(pSprite);
		
		background_map.initMap();
		local pMap = background_map.getMap();
		
		if pMap == nil then
			cclog("Wrong Map!");
			return false;
		end
		
		pSprite:setScale(0.5);
		pSprite:setPosition(background_map.getPosByTiled(10,10));
		
		p.m_pScene:addChild(pMap,-10);
		
	end
	return true;
end

function p.getScene()	
	return p.m_pScene;
end