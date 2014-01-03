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
p.m_nIndex = 1;
p.m_bEnable = true;
p.m_pLastCardsRole = nil;
p.m_pPreCardsPlayer = nil;

function p.initialise(bSingleMode)
	if 0 ~= table.getn(p.m_vecRoleList) or nil ~= p.m_pPlayer then
		return false;
	end
	
	if false == bSingleMode then
		cclog("NO ONLINE MODE!");
	end
	
	return p.initSingleMode();
end

function p.reset()
	p.m_vecRoleList = {};
	p.m_pPlayer = nil;
	p.m_nIndex = 1;
end

function p.getPlayer()
	return p.m_pPlayer;
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
	
	p.m_nIndex = math.random(1,table.getn(p.m_vecRoleList));
	p.m_pLastCardsRole = p.m_vecRoleList[p.m_nIndex];
	
	return true;
end

function p.turn(vecPreCards)
	if 0 ~= table.getn(vecPreCards) then
		p.m_pLastCardsRole = p.m_pPreCardsPlayer;
	end

	
	local pRole = p.nextRole();
	local pCardsList = {};

	if nil == pRole or nil == vecPreCards then
		return nil;
	end
	
	p.m_pPreCardsPlayer = pRole;
	if pRole ~= p.m_pLastCardsRole then	
		if pRole:isWin() then
			cclog(pRole:getName().." was win");
		else
			pCardsList = pRole:turnCards(vecPreCards);
			
			if nil == pCardsList then
				return nil;
			end
		end
	else
		cclog("没人管，重新出牌");
		local vecTemp = {};
		pCardsList = pRole:turnCards(vecTemp);
	end
	
	return pCardsList;
end

function p.getEnable()
	return p.m_bEnable;
end

function p.getLastCardsPlayer()
	return p.m_vecRoleList;
end

function p.setEnable(bVar)
	p.m_bEnable = bVar;
end

function p.getRoleList()
	return p.m_vecRoleList;
end

function p:nextRole()
	if p.m_nIndex > table.getn(p.m_vecRoleList) then
		p.m_nIndex = 1;
	end
	
	local pRole = p.m_vecRoleList[p.m_nIndex];
	p.m_nIndex = p.m_nIndex + 1;
	
	return pRole;
end