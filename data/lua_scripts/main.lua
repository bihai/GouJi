require "MainUI";
require("card_scene");

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
	cclog("----------------------------------------")
	cclog("LUA ERROR: " .. tostring(msg) .. "\n")
	cclog(debug.traceback())
	cclog("----------------------------------------")
end

local function main()
	require "common_func";
	
	local kMainLayer = MainScene.initMainUI();

	if nil == kMainLayer then
		endcclog("can't get kMainLayer");
	end

	kMainLayer:setTouchEnabled(true);
	
	local kMainScene = CCScene:create();

	kMainScene:addChild(kMainLayer);
	CCDirector:sharedDirector():runWithScene(kMainScene);
end

xpcall(main, __G__TRACKBACK__)
