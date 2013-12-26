card_scene = card_scene or {};
local p = card_scene;

p.m_pScene = nil;

function p.init()
	return true;
end

function p.getScene()
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
	
	return p.m_pScene;
end