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
	local fX = 0;
	local fY = 0;
	
	for k,v in ipairs(vecCards) do
		local pSize = v:getBoundingBoxSize();
		fTotalWidth = fTotalWidth + nPixel;
		fTotalHeight = math.max(fTotalHeight,pSize.size.height);
	end
	
	fTotalWidth = fTotalWidth - nPixel;
	local pWinSize = p.getWinSize();
	local pPixelSize = p.getWinSizeInPixels();
	
	local fMidWidth = pWinSize.width / 2.0;
	fX = fMidWidth - fTotalWidth / 2.0;
	fY = card_define.PLAYER_CARDS_Y;
	
	pRetRect = CCRectMake(fX,fY,fTotalWidth,fTotalHeight);
	
	cclog("WinSize Is "..pRetRect.origin.x.." "..pRetRect.origin.y.." "..pRetRect.size.width.." "..pRetRect.size.height);
	
	return pRetRect;
end