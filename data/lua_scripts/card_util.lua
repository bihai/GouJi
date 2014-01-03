--------------------------------------------------------------
-- FileName: 	card_util.lua
-- author:		郭浩, 2013/12/30
-- purpose:		卡牌功能逻辑类（单实例）
-- 注意：		这个类是单例，注意用法！
--------------------------------------------------------------

card_util = card_util or {};
local p = card_util;

function p.sortCards(vecCards)
	if nil == vecCards then
		return false;
	end
	
	if 0 == table.getn(vecCards) then
		return false;
	end
	
	local fBeforeSort = os.clock();
	local fAfterSort = 0.0;
	
	fAfterSort = os.clock();
	
	cclog(string.format("Sort Time Is %f",fAfterSort - fBeforeSort));
	
	pSortFunc = function(a,b)
		return a:getNumber() < b:getNumber()
	end
	
	table.sort(vecCards,pSortFunc);
	
	return true;
end

function p.getCardGroup(vecCards,nCount,bOverNumber)
	local vecGroup = {};
	
	local vecTemp = {};
	local nSame = 0;
	
	for i = 1,table.getn(vecCards) do
		if nSame == vecCards[i]:getNumber() then
			table.insert(vecTemp,i);
		else
			if table.getn(vecTemp) == nCount then
				local vecPush = table.deepcopy(vecTemp);
				
				if nil ~= vecPush then
					table.insert(vecGroup,vecPush);
				end
			elseif bOverNumber and table.getn(vecTemp) > nCount then
				local vecPush = table.deepcopy(vecTemp);
				
				if nil ~= vecPush then
					table.insert(vecGroup,vecPush);
				end
			end
		
			nSame = vecCards[i]:getNumber();
			vecTemp = {};
			table.insert(vecTemp,i);
		end
	end
	
	return vecGroup;
end

function p.getWinSize()
	return CCDirector:sharedDirector():getWinSize();
end

function p.getWinSizeInPixels()
	return CCDirector:sharedDirector():getWinSizeInPixels();
end

function p.computeCardsSize(vecCards,nPixel)
	if nil == vecCards or type(vecCards) ~= "table" then
		cclog("computeCardsSize failed");
		return nil;
	end

	local pRetRect = nil;
	local fTotalWidth = 0;
	local fTotalHeight = 0;
	local fCardWidth = 0;
	local fX = 0;
	local fY = 0;
	
	for i = 1,table.getn(vecCards) - 1 do
		local pSize = vecCards[i]:getBoundingBoxSize();
		fTotalWidth = fTotalWidth + nPixel;
		fTotalHeight = math.max(fTotalHeight,pSize.size.height);
		fCardWidth = pSize.size.width;
	end
	
	fTotalWidth = fTotalWidth + fCardWidth;
	local pWinSize = p.getWinSize();
	local pPixelSize = p.getWinSizeInPixels();
	
	local fMidWidth = pWinSize.width / 2.0;
	fX = fMidWidth - fTotalWidth / 2.0;
	fY = card_define.PLAYER_CARDS_Y;
	
	pRetRect = CCRectMake(fX,fY,fTotalWidth,fTotalHeight);
	
	--cclog("Cards Size Is "..pRetRect.origin.x.." "..pRetRect.origin.y.." "..pRetRect.size.width.." "..pRetRect.size.height);
	
	return pRetRect;
end

function p.isTouchInRect(x,y,pRect)
	if nil == pRect or nil == x or nil == y then
		cclog("nil rect or nil x nil y");
		return false;
	end
	
	local fRight = pRect.size.width + pRect.origin.x;
	local fTop = pRect.size.height + pRect.origin.y;
	
	if x < pRect.origin.x or y < pRect.origin.y or x > fRight or y > fTop then
		return false;
	end
	
	return true;
end

function p.getTouchInCardRect(x,y,vecOwnerCards)
	local pCard = nil;
	
	if nil == x or nil == y or nil == vecOwnerCards or 0 == table.getn(vecOwnerCards) then
		return nil;
	end
	
	local pRect = p.computeCardsSize(vecOwnerCards,card_define.CARD_SPACE);
	
	if nil == pRect then
		return nil;
	end
	
	for k = table.getn(vecOwnerCards),1,-1 do
		local v = vecOwnerCards[k];
		local pCardRect = v:getBoundingBoxSize();
		
		if true == p.isTouchInRect(x,y,pCardRect) then
			cclog(v:getNumber().." is touched");
			return v;
		end
	end
	
	return nil;
end

function p.isExistInList(vecList,pCard)
	if nil == vecList then
		return 0;
	end
	
	for k,v in ipairs(vecList) do
		if pCard == v then
			return k;
		end
	end
	
	return 0;
end