--------------------------------------------------------------
-- FileName: 	card_manager.lua
-- author:		郭浩, 2013/12/28
-- purpose:		卡牌管理类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

card_manager = card_manager or {};
local p = card_manager;

p.m_vecCards = {};

function p.initCards()
	return true;
end