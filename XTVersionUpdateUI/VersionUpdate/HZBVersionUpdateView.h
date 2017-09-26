//
//  HZBVersionUpdateView.h
//  Tests
//
//  Created by 安宁 on 17/3/17.
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

@interface HZBVersionUpdateView : UIWindow

+(void)showUpdate:(KKUpdateStatusEnum )updateStatus  callback:(void(^)( KKCallbackTypeEnum) )callback;

@end
