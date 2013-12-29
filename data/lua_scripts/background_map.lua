--------------------------------------------------------------
-- FileName: 	background_map.lua
-- author:		郭浩, 2013/12/28
-- purpose:		背景地图类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

background_map = background_map or {};
local p = background_map;

p.m_pTiledMap = nil;

function p.initMap()
	
	if nil == p.m_pTiledMap then
		p.m_pTiledMap = CCTMXTiledMap:create("../tlmap/bg.tmx");
	end
	
	return true;
end