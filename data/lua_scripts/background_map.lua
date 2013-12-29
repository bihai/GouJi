--------------------------------------------------------------
-- FileName: 	background_map.lua
-- author:		郭浩, 2013/12/28
-- purpose:		背景地图类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

background_map = background_map or {};
local p = background_map;

p.m_pTiledMap = nil;
p.m_pMapSize = nil;
p.m_pTileSize = nil;

function p.initMap()
	
	if nil == p.m_pTiledMap then
		p.m_pTiledMap = CCTMXTiledMap:create("../tlmap/bg.tmx");
		p.m_pMapSize = p.m_pTiledMap:getMapSize();
		p.m_pTileSize = p.m_pTiledMap:getTileSize();
	end
	
	return true;
end

function p.getMap()
	return p.m_pTiledMap;
end

function p.getMapSize()
	return p.m_pMapSize;
end

function p.getTileSize()
	return p.m_pTileSize;
end

function p.getPosByTiled(x,y)
	return ccp(p.m_pTileSize.width * x,p.m_pTileSize.height * y);
end