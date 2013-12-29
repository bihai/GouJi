--------------------------------------------------------------
-- FileName: 	card_npc.lua
-- author:		����, 2013/12/30
-- purpose:		NPC�ࣨ��ʵ����
-- ע�⣺		�������ж��ʵ����ע���÷���
--------------------------------------------------------------

card_npc = card_role:new();
local p = card_npc;
local super = card_role;

function p:new()
	o = {};
	setmetatable( o, self );
	self.__index = self;
	o:ctor();
	return o;
end

function p:ctor()
    super.ctor(self);
	self.m_nRoleType = card_define.ROLE_NPC;
end

function p:initialise(strName)
	if nil == strName then
		cclog("NULL NAME!");
		return false;
	end
	
	super.initialise(self,strName);
end