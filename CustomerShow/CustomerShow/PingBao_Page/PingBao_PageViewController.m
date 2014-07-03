;//
//  Pic_PageViewController.m
//  Icicle
//
//  Created by 讯 鹿 on 13-5-28.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "PingBao_PageViewController.h"
#import "Choose_LineViewController.h"
#import "DataPist.h"
#import "Main_ViewController.h"
@interface PingBao_PageViewController ()
@end

@implementation PingBao_PageViewController
@synthesize pingBaoArrys;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [timer invalidate];
    timer = Nil;
    Main_ViewController *mainVC=[[Main_ViewController alloc]init];
    mainVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self  presentViewController:mainVC animated:YES completion:NULL];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pingBaoArrys=[[NSMutableArray alloc]init];
    pingBaoArrys=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:7]]];;
    Flag = YES;
    _transitionImageView = [[LTransitionImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    _transitionImageView.animationDuration = 3;
      _transitionImageView.image = [UIImage imageWithContentsOfFile:[DataPist getFilePath:[NSString stringWithFormat:@"l_%@",[[pingBaoArrys objectAtIndex:0] objectForKey:@"img"]]]];
    [self.view addSubview:_transitionImageView];
    self.view.backgroundColor = [UIColor grayColor];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        [self startAnimations];
    });
}
- (void)startAnimations
{
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(change) userInfo:nil repeats:YES];
}
-(void)change{
        [UIView beginAnimations:NULL context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:2];
        int n = arc4random()%[pingBaoArrys count];
        flag = n;
        _transitionImageView.animationDirection = arc4random()%4;
        _transitionImageView.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:[NSString stringWithFormat:@"l_%@",[[pingBaoArrys objectAtIndex:n] objectForKey:@"img"]]]];
        [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
    //    self.interfaceOrientation
    
}
@end
