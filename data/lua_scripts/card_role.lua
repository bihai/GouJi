--------------------------------------------------------------
-- FileName: 	card_role.lua
-- author:		����, 2013/12/30
-- purpose:		��ɫ�ࣨ��ʵ����
-- ע�⣺		�������ж��ʵ����ע���÷���
--------------------------------------------------------------

card_role = {}
local p = card_role;

function p:new()	
	o = {};
	setmetatable( o, self );
	self.__index = self;
	o:ctor();
	return o;
end

function p:ctor()
	self.m_vecOwnCards = {};
	self.m_strName = nil;
	self.m_nRoleType = 0;
end

function p:initialise(strName)
	if nil == strName then
		cclog("Null Name");
	end
	
	self.m_strName = strName;
	
	cclog("Create Role! Name Is "..strName);
	return true;
end

function p:showCards()
	cclog(self.m_strName.." has "..#self.m_vecOwnCards.." cards");
	
	if nil == self.m_vecOwnCards then
		cclog("THIS PLAYER iS NO CARDS");
		return false;
	end
	
	if false == self:sortCards() then
		cclog("ERROR SORT CARDS");
		return false;
	end
	
	return true;
end

function p:addCard(pCard)
	if nil == pCard then
		return false;
	end

	table.insert(self.m_vecOwnCards,pCard);
	
	return true;
end

function p:sortCards()
	if nil == self.m_vecOwnCards then
		return false;
	end
	
	if 0 == table.getn(self.m_vecOwnCards) then
		return false;
	end
	
	local fBeforeSort = os.clock();
	local fAfterSort = 0.0;
	
	for i = 1,table.getn(self.m_vecOwnCards) do
		local nCardType = self.m_vecOwnCards[i]:getCardType();
		local strType = "";
		
		if 0 ~= nCardType then
			strType = card_define.CARD_TYPE[nCardType];
		end
		
		cclog(strType..self.m_vecOwnCards[i]:getNumber());
	end
	
	for j = 1,table.getn(self.m_vecOwnCards) do
		for i = j,table.getn(self.m_vecOwnCards) - 1 do
			local pPreCard = self.m_vecOwnCards[i];
			local pPostCard = self.m_vecOwnCards[i + 1];
			
			if pPreCard:getNumber() < pPostCard:getNumber() then
				self.m_vecOwnCards[i] = pPostCard;
				self.m_vecOwnCards[i + 1] = pPreCard;
			end
		end
	end
	
	fAfterSort = os.clock();
	
	cclog(string.format("Sort Time Is %f",fAfterSort - fBeforeSort));
	
	for i = 1,table.getn(self.m_vecOwnCards) do
		local nCardType = self.m_vecOwnCards[i]:getCardType();
		local strType = "";
		
		if 0 ~= nCardType then
			strType = card_define.CARD_TYPE[nCardType];
		end
		
		cclog(strType..self.m_vecOwnCards[i]:getNumber());
	end
	
	return true;
end