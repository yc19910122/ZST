//
//  AppDelegate.m
//  Icicle
//
//  Created by User #⑨ on 13-5-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//
//admin001 admin001
#import "AppDelegate.h"
#import "LogIn_PageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PingBao_PageViewController.h"
@implementation AppDelegate
@synthesize g_timeCount,screenLockTimeInterval;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
     [UIApplication sharedApplication].idleTimerDisabled=YES;    //不自动锁屏
    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];//去掉导航
    [[NSUserDefaults standardUserDefaults]setObject:@"图片" forKey:@"TypeTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [NSString stringWithFormat:@"Version %@",[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [NSString stringWithFormat:@"Build %@",[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleVersion"]];
    NSLog(@"----%@", [NSString stringWithFormat:@"Version %@",[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]);
    NSLog(@"----%@", [NSString stringWithFormat:@"Build %@",[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleVersion"]]);

    self.window = [[MyWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor=[UIColor clearColor];
        
    self.viewController = [[LogIn_PageViewController alloc]init];
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.25f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionReveal];
    [animation setSubtype: kCATransitionFromBottom];
        [self.window setRootViewController:self.viewController];
     [self.window.layer addAnimation:animation forKey:@"Reveal"];
    [self.window makeKeyAndVisible];
    return YES;
}

//NStimer 清零
- (void)zeroTimer{
//    NSLog(@"set timer zero");
    if (!g_timeCount) {
        g_timeCount = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:nil userInfo:nil repeats:NO];
    }
    [g_timeCount invalidate];
    g_timeCount = nil;
}
//start the NSTimer
- (void)startTimer {
//    NSLog(@"NSTimer start");
    BOOL enableSecBrowserScreen = YES;
  NSString *time=[[NSUserDefaults standardUserDefaults]objectForKey:@"AnimationTime"];
    if (time==Nil) {
        time=@"5";
    }
    int t=[time integerValue];
    if (enableSecBrowserScreen) {
        if (!g_timeCount) {
            screenLockTimeInterval =t*60;
            g_timeCount = [NSTimer scheduledTimerWithTimeInterval:screenLockTimeInterval target:self selector:@selector(lockSecBrowserScreen) userInfo:nil repeats:YES];
        }
    }
}
//设置屏保
-(void)lockSecBrowserScreen{
    NSString *TypeTime=[[NSUserDefaults standardUserDefaults]objectForKey:@"TypeTime"];
//    NSLog(@"open");
//    if ([TypeTime isEqualToString:@"走秀"]) {
////        NSLog(@"走秀屏保");
//        
//           self.window.rootViewController=Nil;
//        ShiPIn_ViewController *shipin = [[ShiPIn_ViewController alloc]init];
////        move_page.which = YES;
//         self.window.rootViewController=shipin;
//    }else
     //        NSLog(@"图片屏保");
        if ([TypeTime isEqualToString:@"图片"]){
            self.window.rootViewController=Nil;
            NSLog(@"屏保");
            PingBao_PageViewController *pic_page=[[PingBao_PageViewController alloc]init];
            self.window.rootViewController=pic_page;
            }
            [g_timeCount invalidate];
            g_timeCount = nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 他们唱的歌很好听的哦，赶紧去听听啊，
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
