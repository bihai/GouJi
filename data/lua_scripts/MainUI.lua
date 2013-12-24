--[[
		File name: MainUI.lua
		Author: Guo Hao
--]]

require "CCBReaderLoad"

MainScene = MainScene or {};
MainSceneOwner = MainSceneOwner or {};
ccb["MainScene"] = MainScene;
ccb["MainSceneOwner"] = MainSceneOwner;

local function onPressEntryBtn()
   local kNextScene = CCScene:create();
   CCDirector:sharedDirector():replaceScene(kNextScene);
end

function initMainUI()
   local kProxy = CCBProxy:create();
   local kUIMainNode = CCBuilderReaderLoad("MainScene.ccbi",kProxy,true,"MainSceneOwner");

   if nil == kUIMainNode then
      return;
   end

   local kLayer= tolua.cast(kUIMainNode,"CCLayer");

   return kLayer;
end

MainScene["onPressEntryBtn"] = onPressEntryBtn;
MainScene["onTestButton"] = onPressEntryBtn;
