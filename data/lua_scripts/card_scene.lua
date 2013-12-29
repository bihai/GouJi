--------------------------------------------------------------
-- FileName: 	card_scene.lua
-- author:		郭浩, 2013/12/28
-- purpose:		卡牌场景类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

require "background_map";
require "card_manager";

card_scene = card_scene or {};
local p = card_scene;

p.m_pScene = nil;

function p.init()
	if p.m_pScene == nil then 
		p.m_pScene = CCScene:create();
		
		background_map.initMap();
		local pMap = background_map.getMap();
		
		if pMap == nil then
			cclog("Wrong Map!");
			return false;
		end
		
		local pNode = card_manager.initCards(1);
		
		if nil == pNode then
			cclog("Wrong Node");
			return false;
		end
		
		p.m_pScene:addChild(pNode,10);
		p.m_pScene:addChild(pMap,-10);
		
	end
	
	return true;
end

function p.getScene()	
	return p.m_pScene;
end