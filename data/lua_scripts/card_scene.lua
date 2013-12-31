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

p.m_pScene = nil;
p.m_bSingle = true;

function p.init(bSingle)
	if false == bSingle then
		cclog("NO SINGLE MODE");
		return false;
	end
	
	if p.m_pScene == nil then 
		p.m_pScene = CCScene:create();
		
		background_map.initMap();
		local pMap = background_map.getMap();
		
		if pMap == nil then
			cclog("Wrong Map!");
			return false;
		end
		
		local pNode = card_manager.initCards(4);
		
		if nil == pNode then
			cclog("Wrong Node");
			return false;
		end
		
		p.m_pScene:addChild(pNode,10);
		p.m_pScene:addChild(pMap,-10);
	end
	
	if false == role_manager.initialise(true) then
		return false;
	end
	
	p.beginGame();
	
	return true;
end

function p.beginGame()
	if p.m_bSingle then
		if false == p.toDeal() then
			cclog("DEAL FAILED!");
			return false;
		end
	end
	
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
	
	for k,v in ipairs(vecList) do
		if false == v:sortCards() then
			cclog("ERROR SORT CARDS");
			return false;
		end
		
		v:showCards();
	end
	
	return true;
end

function p.getScene()
	return p.m_pScene;
end