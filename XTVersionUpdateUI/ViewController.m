//
//  ViewController.m
//  XTVersionUpdateUI
//
//  Created by 安宁 on 2017/9/11.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "ViewController.h"
#if 0
#import "HZBVersionUpdateView.h"
#else
#import "HZBVersionUpdateUI.h"
#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self update2];
//    [self update1];
}

#if 0

-(void)update1
{
    [HZBVersionUpdateView showUpdate:KKUpdateStatusNeedUpdate callback:^(KKCallbackTypeEnum type) {
        
        NSLog(@"%@",@(type));
        
    }];
}

#else
-(void)update2
{
    [HZBVersionUpdateUI showUpdate:KKUpdateStatusNeedUpdate callback:^(KKCallbackTypeEnum type) {
        
        NSLog(@"==== %@",@(type));

    }];
}

#endif

@end
