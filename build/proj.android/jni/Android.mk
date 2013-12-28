LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := gouji_shared

LOCAL_MODULE_FILENAME := libGouJi

LOCAL_SRC_FILES := GouJi/main.cpp \
                   ../../Classes/AppDelegate.cpp

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../Classes

LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocosdenshion_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos_lua_static
LOCAL_WHOLE_STATIC_LIBRARIES += cocos_extension_static

include $(BUILD_SHARED_LIBRARY)

$(call import-module,cocos2dx)
$(call import-module,CocosDenshion/android)
$(call import-module,scripting/lua/proj.android)
$(call import-module,extensions)
