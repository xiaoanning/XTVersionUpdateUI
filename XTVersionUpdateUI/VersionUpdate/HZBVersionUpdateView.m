//
//  HZBVersionUpdateView.m
//  Tests
//
//  Created by 安宁 on 17/3/17.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "HZBVersionUpdateView.h"

@interface HZBVersionUpdateView ()

@property ( nonatomic , copy ) void(^callback)(KKCallbackTypeEnum type) ;

@end

@implementation HZBVersionUpdateView

static HZBVersionUpdateView * _instance = nil;
+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [HZBVersionUpdateView shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [HZBVersionUpdateView shareInstance] ;
}


+(void)showUpdate:(KKUpdateStatusEnum )updateStatus callback:(void (^)(KKCallbackTypeEnum))callback
{
    
    CGRect screenBounds = [[UIScreen mainScreen]bounds] ;
    
    HZBVersionUpdateView * updateView = [HZBVersionUpdateView shareInstance];
    updateView.frame = screenBounds ;
    [updateView setCallback:callback];
    updateView.userInteractionEnabled = YES ;
    updateView.backgroundColor = [UIColor clearColor];
    
    //遮罩层
    UIView * mainView = [[UIView alloc] initWithFrame:screenBounds];
    mainView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1f];
//    mainView.backgroundColor = [UIColor redColor];
    [updateView addSubview:mainView];
    
    //加载的背景图
    UIImageView * backView = [[UIImageView alloc] initWithFrame:screenBounds];
//    [backView setImage:[UIImage imageNamed:@"loading_background.png"]];
    [backView setBackgroundColor:[UIColor blackColor]];
    [backView setAlpha:0.50];
    backView.userInteractionEnabled = YES ;
    [mainView addSubview:backView];
    
    //900*555
    NSString * path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle]resourcePath],@"version_tip.png"];
    UIImage * image = [UIImage imageWithContentsOfFile:path] ;
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    CGFloat imageWidth = CGRectGetWidth(screenBounds) * 9 / 11 ;
    CGFloat imageHeight = imageWidth/image.size.width * image.size.height ;
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [mainView addSubview:imageView];
    
    //更新
    UIImage * updateImage = [UIImage imageNamed:@"version_button.png"];
    CGFloat btnWidth = CGRectGetWidth(screenBounds)/2.0 ;
    CGFloat btnHeight = btnWidth / updateImage.size.width * updateImage.size.height ;
    UIImageView * updateBtn = [[UIImageView alloc]initWithImage:updateImage];
    [updateBtn setContentMode:UIViewContentModeScaleAspectFit];
    updateBtn.backgroundColor  = [UIColor clearColor];
    updateBtn.userInteractionEnabled = YES ;
    [updateBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:updateView action:@selector(updateBtnDidClick)]];
    [mainView addSubview:updateBtn];
    
    CGFloat space = 6.0 / 100 *  CGRectGetHeight(screenBounds);
    imageView.frame = CGRectMake(CGRectGetWidth(screenBounds)/2.0 - imageWidth/2.0f, CGRectGetHeight(screenBounds)/2.0 - (imageHeight+btnHeight+space)/2.0, imageWidth, imageHeight) ;
    updateBtn.frame = CGRectMake( CGRectGetMidX(imageView.frame) - btnWidth/2.0 , CGRectGetMaxY(imageView.frame) + space, btnWidth, btnHeight) ;
    
    
    //关闭
    if (updateStatus == KKUpdateStatusNeedUpdate)
    {
        CGFloat closeHeight = 46.0f ;
        UIImageView * closeBtn = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) - closeHeight/2.0, CGRectGetMinY(imageView.frame) , closeHeight, closeHeight)];
        closeBtn.backgroundColor  = [UIColor clearColor];
        closeBtn.image = [UIImage imageNamed:@"version_close.png"];
        [closeBtn setContentMode:UIViewContentModeScaleAspectFit];
        closeBtn.userInteractionEnabled = YES ;
        [closeBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:updateView action:@selector(closeBtnDicClick)]];
        [mainView addSubview:closeBtn];
        
    }
    
    
    [updateView setWindowLevel:UIWindowLevelAlert  ];
    [updateView makeKeyAndVisible];
    
    
//    NSLog(@" UIWindowLevelAlert %f UIWindowLevelNormal %f UIWindowLevelStatusBar %f updateView %f UIApplication%f ",UIWindowLevelAlert,UIWindowLevelNormal,UIWindowLevelStatusBar,updateView.windowLevel,[[[[UIApplication sharedApplication]delegate]window]windowLevel]) ;
    
}


-(void)updateBtnDidClick
{
    if (_callback)
    {
        _callback(KKCallbackTypeIsUpdate);
    }
}

-(void)closeBtnDicClick
{

    [self setHidden:YES];
    [self removeFromSuperview];
    
    if (_callback)
    {
        _callback(KKCallbackTypeIsClose);
    }

}


@end
