--------------------------------------------------------------
-- FileName: 	card_define.lua
-- author:		����, 2013/12/29
-- purpose:		���ƶ����ࣨ��ʵ����
-- ע�⣺		������ǵ�����ע���÷���
--------------------------------------------------------------

card_define = card_define or {};
local p = card_define;

p.CARD_MAX_COUNT = 54;
p.CARD_TYPE = {"hei_","hong_","hua_","pian_"};
p.ROLE_PLAYER = 0x000000ff;
p.ROLE_NPC = 0x00000011;
p.ROLE_MAX = 6;
p.PLAYER_CARDS_Y = 20.0;
p.CARD_SPACE = 10.0;
p.CARD_POP_PERCENT = 0.5;