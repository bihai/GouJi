--------------------------------------------------------------
-- FileName: 	card_define.lua
-- author:		郭浩, 2013/12/29
-- purpose:		卡牌定义类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

card_define = card_define or {};
local p = card_define;

p.CARD_MAX_COUNT = 54;
p.CARD_TYPE = {"hei_","hong_","hua_","pian_"};
p.ROLE_PLAYER = 0x000000ff;
p.ROLE_NPC = 0x00000011;
p.ROLE_MAX = 6;