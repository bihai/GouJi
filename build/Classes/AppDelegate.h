#ifndef  _APP_DELEGATE_H_
#define  _APP_DELEGATE_H_

#include "CCApplication.h"
#include <vector>
#include <string>
#include "cocoa\CCGeometry.h"

#define ENTRY_LUA_FUNC "main.lua"
#define GAME_FPS 30

using namespace std;
using namespace cocos2d;

typedef vector<string> StringVector;

/**
@brief    The cocos2d Application.

The reason for implement as private inheritance is to hide some interface call by CCDirector.
*/
class  AppDelegate : private cocos2d::CCApplication
{
public:

    AppDelegate();
    virtual ~AppDelegate();

    /**
    @brief    Implement CCDirector and CCScene init code here.
    @return true    Initialize success, app continue.
    @return false   Initialize failed, app terminate.
    */
    virtual bool applicationDidFinishLaunching();

    /**
    @brief  The function be called when the application enter background
    @param  the pointer of the application
    */
    virtual void applicationDidEnterBackground();

    /**
    @brief  The function be called when the application enter foreground
    @param  the pointer of the application
    */
    virtual void applicationWillEnterForeground();

	CC_SYNTHESIZE_READONLY(CCSize,m_kDesignSize,DesignSize);
	CC_SYNTHESIZE_READONLY(CCSize,m_kResourceSize,ResourceSize);
	CC_SYNTHESIZE_READONLY(string,m_strBasePlatformPath,BasePlatformPath);
	CC_SYNTHESIZE_READONLY(string,m_strLuaScriptPath,LuaScriptPath);
	CC_SYNTHESIZE_READONLY(string,m_strImagePath,ImagePath);
	CC_SYNTHESIZE_READONLY(string,m_strFontPath,FontPath);
	CC_SYNTHESIZE_READONLY(string,m_strAppIconPath,AppIconPath);
	CC_SYNTHESIZE_READONLY(string,m_strSoundPath,SoundPath);
	CC_SYNTHESIZE_READONLY(string,m_strPublishedPath,PublishedPath);

protected:
	
	bool autoSizeMachineResolutions(StringVector& kPaths);
	bool initSearchPaths(StringVector& kPaths);
};

#endif // _APP_DELEGATE_H_
