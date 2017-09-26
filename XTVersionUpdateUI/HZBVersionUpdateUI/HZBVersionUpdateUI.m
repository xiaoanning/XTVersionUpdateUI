//
//  HZBVersionUpdateUI.m
//  XTVersionUpdateUI
//
//  Created by 安宁 on 2017/9/11.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "HZBVersionUpdateUI.h"

@interface HZBVersionUpdateUI ()

@property ( nonatomic , copy ) void(^callback)(KKCallbackTypeEnum type) ;

@end

@implementation HZBVersionUpdateUI

static HZBVersionUpdateUI * _instance = nil;
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
    return [HZBVersionUpdateUI shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [HZBVersionUpdateUI shareInstance] ;
}


+(void)showUpdate:(KKUpdateStatusEnum )updateStatus callback:(void (^)(KKCallbackTypeEnum))callback
{
    
    CGRect screenBounds = [[UIScreen mainScreen]bounds] ;
    
    HZBVersionUpdateUI * updateView = [HZBVersionUpdateUI shareInstance];
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
    
    //背景图 810*620
    NSString * path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle]resourcePath],@"comon_head@3x.png"];
    UIImage * image = [UIImage imageWithContentsOfFile:path] ;
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    CGFloat imageWidth = 810.0f / 3.0f * 2.0f / 750.0f * CGRectGetWidth(screenBounds) ;
    CGFloat imageHeight = imageWidth/image.size.width * image.size.height ;
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [mainView addSubview:imageView];
    
    //new 810*620
    NSString * path2 = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle]resourcePath],@"comon_head_new@3x.png"];
    UIImage * image2 = [UIImage imageWithContentsOfFile:path2] ;
    UIImageView * imageView2 = [[UIImageView alloc]initWithImage:image2];
    [imageView2 setContentMode:UIViewContentModeScaleAspectFit];
    [mainView addSubview:imageView2];

    
    //提示文字 发现新版本V1.0.1
    UILabel * tipsLabel = [[UILabel alloc]init];
    tipsLabel.backgroundColor = [UIColor clearColor];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    NSString * versionStr = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    tipsLabel.text = [NSString stringWithFormat:@"发现新版本V%@",versionStr];
    tipsLabel.font = [UIFont systemFontOfSize:19.0f];
    [tipsLabel sizeToFit];
    CGFloat tipsWidth = CGRectGetWidth(tipsLabel.frame) ;
    CGFloat tipsHeight = CGRectGetHeight(tipsLabel.frame) ;
    [mainView addSubview:tipsLabel];
    
    //更新和取消的背景色
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:bottomView];
    
    CGFloat lineHeight = 0.5f ;
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor grayColor];
    [mainView addSubview:lineView];
    
    //更新
    CGFloat btnWidth = imageWidth/2.0 ;
    UILabel * updateBtn = [[UILabel alloc]init];
    [updateBtn setText:[NSString stringWithFormat:@"%@",@"更新"]] ;
    updateBtn.font = [UIFont systemFontOfSize:16.0f];
    updateBtn.textAlignment = NSTextAlignmentCenter ;
    updateBtn.backgroundColor  = [UIColor clearColor];
    updateBtn.userInteractionEnabled = YES ;
    [updateBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:updateView action:@selector(updateBtnDidClick)]];
    [updateBtn sizeToFit];
    CGFloat btnHeight = CGRectGetHeight(updateBtn.frame) + 12.0f * 2 ;
    [mainView addSubview:updateBtn];

    
    CGFloat height = imageHeight + lineHeight + btnHeight ;
    
    imageView.frame = CGRectMake(CGRectGetWidth(screenBounds)/2.0 - imageWidth/2.0f, CGRectGetHeight(screenBounds)/2.0 - (height)/2.0, imageWidth, imageHeight) ;
    imageView2.frame = imageView.frame ;
    tipsLabel.frame = CGRectMake(CGRectGetMidX(imageView2.frame) - tipsWidth/2.0f, CGRectGetMidY(imageView2.frame) - tipsHeight/2.0f, tipsWidth, tipsHeight) ;
    lineView.frame = CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMaxY(imageView.frame), imageWidth, lineHeight) ;
    bottomView.frame = CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMaxY(imageView.frame), imageWidth, btnHeight) ;

    
    if (updateStatus == KKUpdateStatusNeedUpdate)
    {
        updateBtn.frame = CGRectMake( CGRectGetMidX(imageView.frame) , CGRectGetMaxY(lineView.frame) , btnWidth, btnHeight) ;

        //选择更新 取消按钮
        UILabel * closeBtn = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMaxY(lineView.frame), btnWidth, btnHeight)];
        closeBtn.backgroundColor  = [UIColor clearColor];
        [closeBtn setText:[NSString stringWithFormat:@"%@",@"取消"]] ;
        closeBtn.font = [UIFont systemFontOfSize:16.0f];
        closeBtn.textAlignment = NSTextAlignmentCenter ;
        closeBtn.userInteractionEnabled = YES ;
        [closeBtn addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:updateView action:@selector(closeBtnDicClick)]];
        [mainView addSubview:closeBtn];
        
    }else 
    {
        //强制更新
        updateBtn.frame = CGRectMake( CGRectGetMidX(imageView.frame) - btnWidth/2.0f , CGRectGetMaxY(lineView.frame) , btnWidth, btnHeight) ;

    }
    
    [updateView setWindowLevel:UIWindowLevelAlert  ];
    [updateView makeKeyAndVisible];
    
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
