--------------------------------------------------------------
-- FileName: 	background_map.lua
-- author:		����, 2013/12/28
-- purpose:		������ͼ�ࣨ��ʵ����
-- ע�⣺		������ǵ�����ע���÷���
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