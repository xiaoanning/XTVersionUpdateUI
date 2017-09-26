//
//  HZBVersionUpdateUI.h
//  XTVersionUpdateUI
//
//  Created by 安宁 on 2017/9/11.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , KKUpdateStatusEnum)
{
    KKUpdateStatusMustUpdate = 1 ,
    KKUpdateStatusNeedUpdate = 2 ,
    
};
typedef NS_ENUM(NSInteger , KKCallbackTypeEnum)
{
    KKCallbackTypeIsClose = 1 ,
    KKCallbackTypeIsUpdate = 2 ,
    
};

@interface HZBVersionUpdateUI : UIWindow

+(void)showUpdate:(KKUpdateStatusEnum )updateStatus  callback:(void(^)( KKCallbackTypeEnum) )callback;

@end
