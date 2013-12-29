--------------------------------------------------------------
-- FileName: 	role_manager.lua
-- author:		郭浩, 2013/12/30
-- purpose:		角色管理类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

require "card_role";
require "card_player";
require "card_npc";

role_manager = role_manager or {};
local p = role_manager;

p.m_vecRoleList = {};
p.m_pPlayer = nil;

function p.initialise(bSingleMode)
	if 0 ~= table.getn(p.m_vecRoleList) or nil ~= p.m_pPlayer then
		return false;
	end
	
	if false == bSingleMode then
		cclog("NO ONLINE MODE!");
	end
	
	return p.initSingleMode();
end

function p.initSingleMode()
	for i = 1,card_define.ROLE_MAX - 1 do
		local pNPC = card_npc:new();

		local strText = string.format("NPC_%d",i);
		
		if false == pNPC:initialise(strText) then
			return false;
		end
		
		table.insert(p.m_vecRoleList,pNPC);
	end
	
	p.m_pPlayer = card_player:new();
	
	if false == p.m_pPlayer:initialise("Korman") then
		return false;
	end
	
	table.insert(p.m_vecRoleList,p.m_pPlayer);
	
	return true;
end

function p.getRoleList()
	return p.m_vecRoleList;
end