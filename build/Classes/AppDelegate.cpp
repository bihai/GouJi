#include "cocos2d.h"
#include "AppDelegate.h"
#include "SimpleAudioEngine.h"
#include "script_support/CCScriptSupport.h"
#include "CCLuaEngine.h"
#include "Lua_extensions_CCB.h"
#include "CCBReader.h"

USING_NS_CC;
using namespace CocosDenshion;
using namespace cocos2d::extension;

AppDelegate::AppDelegate()
{
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
	m_strBasePlatformPath = "../../data/";
#else
	m_strBasePlatformPath = "";
#endif
}

AppDelegate::~AppDelegate()
{
	// end simple audio engine here, or it may crashed on win32
	SimpleAudioEngine::sharedEngine()->end();
	//CCScriptEngineManager::purgeSharedManager();
}

bool AppDelegate::applicationDidFinishLaunching()
{
	// initialize director
	CCDirector *pDirector = CCDirector::sharedDirector();
	pDirector->setOpenGLView(CCEGLView::sharedOpenGLView());

	//    CCEGLView::sharedOpenGLView()->setDesignResolutionSize(480, 320, kResolutionNoBorder);

	// turn on display FPS
	pDirector->setDisplayStats(true);

	// set FPS. the default value is 1.0/60 if you don't call this
	pDirector->setAnimationInterval(1.0 / GAME_FPS);
	StringVector kSearchPaths;
	StringVector kOrders;

	if (!initSearchPaths(kSearchPaths))
	{
		CCLOG("Initialise searching path failed!");
		return false;
	}

	if (false == autoSizeMachineResolutions(kOrders))
	{
		return false;
	}

	CCFileUtils::sharedFileUtils()->setSearchResolutionsOrder(kOrders);

	pDirector->setContentScaleFactor(
		m_kResourceSize.width / m_kDesignSize.width);

	// register lua engine
	CCLuaEngine* pEngine = CCLuaEngine::defaultEngine();

	CCLuaStack *pStack = pEngine->getLuaStack();
	lua_State *tolua_s = pStack->getLuaState();
	tolua_extensions_ccb_open(tolua_s);

	CCScriptEngineManager::sharedManager()->setScriptEngine(pEngine);
	CCFileUtils::sharedFileUtils()->setSearchPaths(kSearchPaths);

	std::string strLuaPath = CCFileUtils::sharedFileUtils()->fullPathForFilename(
		ENTRY_LUA_FUNC);
	CCLOG("Will exceute %s\n",strLuaPath.c_str());
	pEngine->executeScriptFile(strLuaPath.c_str());

	return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
	CCDirector::sharedDirector()->stopAnimation();
	SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
	CCDirector::sharedDirector()->startAnimation();
	SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
}

bool AppDelegate::autoSizeMachineResolutions(StringVector& kPaths)
{
	CCSize kiPhone4 = CCSizeMake(480, 320);
	CCSize kiPhone5 = CCSizeMake(1136, 640);
	CCSize kiPhoneHD = CCSizeMake(960, 640);
	CCSize kiPad = CCSizeMake(1024, 768);
	CCSize kiPadHD = CCSizeMake(2048, 1536);
	m_kResourceSize = kiPhoneHD;
	CCSize kScreenSize = CCEGLView::sharedOpenGLView()->getFrameSize();

	if (0 == kScreenSize.width && 0 == kScreenSize.height)
	{
		return false;
	}

	m_kDesignSize = kiPhoneHD;

	TargetPlatform kPlatform =
		CCApplication::sharedApplication()->getTargetPlatform();

	if (kTargetIphone == kTargetIphone || kTargetIpad == kTargetIpad)
	{
		if (768 < kScreenSize.height)
		{
			m_kResourceSize = kiPadHD;
			m_kDesignSize = kiPadHD;

			kPaths.push_back("resources-ipadhd");
		}
		else if (640 < kScreenSize.height)
		{
			m_kResourceSize = kiPad;
			m_kDesignSize = kiPad;

			kPaths.push_back("resources-ipad");
			kPaths.push_back("resources-iphonehd");

			CCBReader::setResolutionScale(2.0f);
		}
		else if (480 < kScreenSize.height)
		{
			if (960 <= kScreenSize.width)
			{
				m_kDesignSize = kiPhone5;
			}
			else
			{
				m_kDesignSize = kiPhoneHD;
			}

			m_kResourceSize = kiPhoneHD;

			kPaths.push_back("resources-iphonehd");
		}
		else
		{
			CCBReader::setResolutionScale(1.0f);

			m_kDesignSize = kiPhone4;
			m_kResourceSize = kiPhone4;

			kPaths.push_back("resources-iphone");
		}

		//CCEGLView::sharedOpenGLView()->setFrameSize(1136, 640);
		CCEGLView::sharedOpenGLView()->setDesignResolutionSize(
			m_kDesignSize.width, m_kDesignSize.height, kResolutionExactFit);
	}

	return true;
}

bool AppDelegate::initSearchPaths(StringVector& kPaths)
{
	string strPlatformUIPath = "Published-iOS";

#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
	strPlatformUIPath = "Published-Android";
#endif

	m_strLuaScriptPath = m_strBasePlatformPath + string("lua_scripts");
	m_strImagePath = m_strBasePlatformPath + string("images");
	m_strAppIconPath = m_strBasePlatformPath + string("images/app_icon");
	m_strFontPath = m_strBasePlatformPath + string("fonts");
	m_strSoundPath = m_strBasePlatformPath + string("sounds");
	m_strPublishedPath = m_strBasePlatformPath + string("ui_system/") + strPlatformUIPath;

	kPaths.push_back(m_strLuaScriptPath);
	kPaths.push_back(m_strImagePath);
	kPaths.push_back(m_strAppIconPath);
	kPaths.push_back(m_strFontPath);
	kPaths.push_back(m_strSoundPath);
	kPaths.push_back(m_strPublishedPath);

	return true;
}
