--------------------------------------------------------------
-- FileName: 	card.lua
-- author:		����, 2013/12/28
-- purpose:		�����ࣨ��ʵ����
-- ע�⣺		�������ж��ʵ����ע���÷���
--------------------------------------------------------------

card = {};
local p = card;

function p:new()	
	o = {}
	setmetatable( o, self );
	self.__index = self;
	o:ctor();
	return o;
end

--���캯��
function p:ctor()
	self.m_pSprite = nil;
	self.m_nNumber = 0;
end