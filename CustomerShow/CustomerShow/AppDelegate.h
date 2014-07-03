//
//  AppDelegate.h
//  Icicle
//
//  Created by User #⑨ on 13-5-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWindow.h"
#import "PingBao_PageViewController.h"
@class LogIn_PageViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSString   *viewInfo;
}
@property (strong, nonatomic) MyWindow *window;
@property (strong, nonatomic) LogIn_PageViewController *viewController;
@property (strong,nonatomic)NSTimer *g_timeCount;
@property(nonatomic)NSTimeInterval screenLockTimeInterval;
- (void)zeroTimer;
- (void)startTimer;

@end
