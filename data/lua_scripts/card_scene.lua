--------------------------------------------------------------
-- FileName: 	card_scene.lua
-- author:		郭浩, 2013/12/28
-- purpose:		卡牌场景类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

require "background_map";
require "card_manager";
require "role_manager";
require "card_util";
require "card_ai";

card_scene = card_scene or {};
local p = card_scene;

p.m_vecShowCards = {};
p.m_pScene = nil;
p.m_pCardsLayer = nil;
p.m_bSingle = true;
p.m_vecPlayerSelected = {};

function p.init(bSingle)
	if false == bSingle then
		cclog("NO SINGLE MODE");
		return false;
	end
	
	if p.m_pScene == nil then 
		p.m_pScene = CCScene:create();
		p.m_pCardsLayer = CCLayer:create();
		p.m_pScene:addChild(p.m_pCardsLayer,1);
		
		p.m_pCardsLayer:registerScriptTouchHandler(p.onTouch);
		p.m_pCardsLayer:setTouchEnabled(true);
		
		--以下是UI测试代码------------------------------------------
		local testLabel = CCLabelTTF:create("Cards", "Arial", 24);
		local MainMenu = CCMenu:create()
		local testMenuItem = CCMenuItemLabel:create(testLabel);
		testMenuItem:registerScriptTapHandler(p.menuCallback);
		testMenuItem:setPosition(ccp(0,0));
		MainMenu:addChild(testMenuItem);
		p.m_pCardsLayer:addChild(MainMenu);
		MainMenu:setPosition(ccp(420,300));
		------------------------------------------------------------
		
		--p.m_pScene:AddChild(menuLayer);
		
		background_map.initMap();
		local pMap = background_map.getMap();
		
		if pMap == nil then
			cclog("Wrong Map!");
			return false;
		end
		
		local pNode = card_manager.initCards(4);
		card_manager.registerCardsCallback(p.showCards);
		
		if nil == pNode then
			cclog("Wrong Node");
			return false;
		end

		p.m_pCardsLayer:addChild(pNode,10);
		p.m_pCardsLayer:addChild(pMap,-10);
	end
	
	if false == role_manager.initialise(true) then
		return false;
	end
	
	p.beginGame();
	
	return true;
end

function p.menuCallback(tag)
	if role_manager.getPlayer():getTurn() then
	else
		cclog("Your not turn");
	end
end

function p.reset()
	p.m_pScene = nil;
	p.m_bSingle = true;
	p.m_pCardsLayer:removeAllChildrenWithCleanup(true);
	p.m_pCardsLayer = nil;
end

function p.beginGame()
	if p.m_bSingle then
		if false == p.toDeal() then
			cclog("DEAL FAILED!");
			return false;
		end
		
		local vecList = role_manager.getRoleList();
		
		if nil == vecList or 0 == table.getn(vecList) then
			cclog("vecList error! Size is "..#vecList);
			return false;
		end
		
		for k,v in ipairs(vecList) do
			v:showCards();
		end
		
		local pPre = {};
		local pCards = role_manager.turn(pPre);
		
		if nil == pCards then
			cclog("TURN ERROR");
			return false;
		end
	end
	
	return true;
end

function p.showCards(vecList)
	if nil == vecList then
		cclog("showCards nil");
		return false;
	end
	
	for k,v in ipairs(p.m_vecShowCards) do
		v:setPos(ccp(-500,-500));
		v:setVisible(false);
	end
	
	for k,v in ipairs(vecList) do
		v:setPos(ccp(240 - k * 50,160));
		v:setVisible(true);
	end
	
	p.m_vecShowCards = vecList;
	
	return true;
end

function p.toDeal()
	local vecList = role_manager.getRoleList();
	
	if nil == vecList or 0 == table.getn(vecList) then
		cclog("vecList error! Size is "..#vecList);
		return false;
	end
	
	local nIndex = 1;
	
	repeat
		local pCard = card_manager.getRandCardFromList();
		
		if nil ~= pCard then
			local nNumber = nIndex % table.getn(vecList) + 1;
			local pRole = vecList[nNumber];
			
			if pRole then
				pRole:addCard(pCard);
			end
		end
		
		nIndex = nIndex + 1;
	until nil == pCard
	
	return true;
end

function p.onTouch(eventType, x, y)
	if eventType == "began" then   
		return p.onTouchBegan(x, y)
	elseif eventType == "moved" then
		return p.onTouchMoved(x, y)
	else
		return p.onTouchEnded(x, y)
	end
end

function p.onTouchBegan(x, y)
	local pPlayer = role_manager.getPlayer();
	
	if nil == pPlayer or false == pPlayer:getTurn() then
		return false;
	end
	
	local pCard = pPlayer:getTouchedCard(x,y);
	
	if nil == pCard then
		return false;
	end
	
	pCard:setPop();
	
	return true;
end

function p.onTouchEnded(x, y)
	return true;
end

function p.onTouchMoved(x, y)
	return true;
end

function p.getScene()
	return p.m_pScene;
end