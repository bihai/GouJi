--[[
		File name: MainUI.lua
		Author: Guo Hao
--]]

require "CCBReaderLoad"
require "common_func";
require "card_scene";

MainScene = MainScene or {};
MainSceneOwner = MainSceneOwner or {};
ccb["MainScene"] = MainScene;
ccb["MainSceneOwner"] = MainSceneOwner;

local p = MainScene;

function p.onPressEntryBtn()
	local kNextScene = card_scene.getScene();

	if kNextScene == nil then
		cclog("Error!");
		return false;
	end

	CCDirector:sharedDirector():replaceScene(kNextScene);

	return true;
end

function p.initMainUI()
   local kProxy = CCBProxy:create();
   local kUIMainNode = CCBuilderReaderLoad("MainScene.ccbi",kProxy,true,"MainSceneOwner");

   if nil == kUIMainNode then
      return;
   end

   local kLayer= tolua.cast(kUIMainNode,"CCLayer");

   return kLayer;
end

MainScene["onPressEntryBtn"] = p.onPressEntryBtn;
MainScene["onTestButton"] = p.onPressEntryBtn;
