LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_CFLAGS := -DMINIUPNPC_SET_SOCKET_TIMEOUT -D_BSD_SOURCE -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600

LOCAL_MODULE := miniupnpc
LOCAL_SRC_FILES := \
  src/igd_desc_parse.c \
  src/miniupnpc.c \
  src/minixml.c \
  src/minisoap.c \
  src/minissdpc.c \
  src/miniwget.c \
  src/upnpcommands.c \
  src/upnpdev.c \
  src/upnpreplyparse.c \
  src/upnperrors.c \
  src/connecthostport.c \
  src/portlistingparse.c \
  src/receivedata.c \
  src/addr_is_reserved.c \

LOCAL_LDLIBS :=
LOCAL_C_INCLUDES += $(LOCAL_PATH)/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/android

include $(BUILD_SHARED_LIBRARY)
