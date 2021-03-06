--------------------------------------------------------------
-- FileName: 	card_manager.lua
-- author:		郭浩, 2013/12/28
-- purpose:		卡牌管理类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

require "card";

card_manager = card_manager or {};
local p = card_manager;

p.m_vecRemainCards = {};
p.m_vecPreCards = {};
p.m_pScene = nil;
p.m_pCardNode = nil;
p.m_pCardTexture = nil;
p.m_pCardsFunction = nil;
p.m_strLastErrorMsg = nil;

function p.initCards(nCount)
	if nil ~= p.m_pCardNode or 1 > nCount then
		return p.m_pCardNode;
	end
	
	CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("cards/cards.plist","cards/cards.png");
	p.m_pCardTexture = CCTextureCache:sharedTextureCache():textureForKey("cards/cards.png");

	if nil == p.m_pCardTexture then
		cclog("Wrong Key!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	end

	p.m_pCardNode = CCSpriteBatchNode:createWithTexture(p.m_pCardTexture);
	
	for t = 1,nCount do
		for j = 0,3 do
			for i = 0,12 do
				local nNum = i + 1;
				local pCard = card:new();
				
				if false == pCard:initialise(j + 1,nNum) then
					return false;
				end
				
				p.addCardToNode(pCard);
			end
		end
	
		local pBlackJoker = card:new();
		local pRedJoker = card:new();
		
		if false == pBlackJoker:initialise(0,14) then
			return nil;
		end
		
		if false == pRedJoker:initialise(0,15) then
			return nil;
		end
		
		p.addCardToNode(pBlackJoker);
		p.addCardToNode(pRedJoker);
	end
	
	cclog("Cards is "..#p.m_vecRemainCards);
	
	return p.m_pCardNode;
end

function p.registerCardsCallback(pFunction)
	p.m_pCardsFunction = pFunction;
end

function p.getLastErrorMsg()
	return p.m_strLastErrorMsg;
end

function p.checkRule(vecCardList)
	if nil == p.m_vecPreCards then
		p.m_strLastErrorMsg = "空卡牌";
		return false;
	end
	
	if 0 == table.getn(vecCardList) or 0 == table.getn(p.m_vecPreCards) then
		return true;
	end
	
	for k,v in ipairs(vecCardList) do
		if v ~= vecCardList[1] then
			p.m_strLastErrorMsg = "应该出相同的卡牌";
			return false;
		end
	end
	
	if vecCardList[1]:getNumber() <= p.m_vecPreCards[1]:getNumber() then
		p.m_strLastErrorMsg = "出的数比对方小";
		return false;
	end
	
	return true;
end

function p.roleCards(vecCardList)
	if nil == vecCardList then
		return false;
	end
	
	if false == p.checkRule(vecCardList) then
		return false;
	end
	
	if 0 ~= table.getn(vecCardList) then
		p.addCardsToOpenList(vecCardList);
	end

	if nil ~= p.m_pCardsFunction then
		p.m_pCardsFunction(vecCardList);
	end
	
	return true;
end

function p.getRandCardFromList()
	local nCardCount = table.getn(p.m_vecRemainCards);
	local pCard = nil;
	
	if 0 > nCardCount then
		return nil;
	end
	
	local nPos = math.random(1,nCardCount);
	
	pCard = p.m_vecRemainCards[nPos];
	
	if nil == pCard then
		return nil;
	end

	table.remove(p.m_vecRemainCards,nPos);
	
	return pCard;
end

function p.addCardsToOpenList(vecCards)
	p.m_vecPreCards = {};	
	
	if nil == vecCards or 0 == table.getn(vecCards) then
		return false;
	end

	for k,v in ipairs(vecCards) do
		table.insert(p.m_vecRemainCards,v);
		table.insert(p.m_vecPreCards,v);
	end
	
	return true;
end

function p.addCardToNode(pCard)
	if nil == pCard then
		return false;
	end
	
	local pSprite = pCard:getSprite();
	if nil == pSprite then
		return false;
	end
	
	p.m_pCardNode:addChild(pSprite);
	
	table.insert(p.m_vecRemainCards,pCard);
end