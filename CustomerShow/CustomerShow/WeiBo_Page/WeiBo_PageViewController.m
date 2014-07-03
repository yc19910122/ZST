//
//  WeiBo_PageViewController.m
//  Icicle
//
//  Created by User #⑨ on 13-5-16.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "WeiBo_PageViewController.h"

@interface WeiBo_PageViewController ()

@end

@implementation WeiBo_PageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.frame=CGRectMake(0, 0, 1024, 710);
//    [self initFrameTitle];
	// Do any additional setup after loading the view.
        WeiBo = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 1024, 710)];
//        [WeiBo setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
        [WeiBo setUserInteractionEnabled:YES];
        WeiBo.delegate=self;
        [self.view addSubview:WeiBo];
       [DataPist shared].companyInfo=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:3]]];
        NSString *urlString = [NSString stringWithFormat:@"%@",[[[DataPist shared].companyInfo objectAtIndex:0] objectForKey:@"company_weibo"]];
        [WeiBo loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
     [DataPist showLoading];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
     [DataPist hideLoading];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [DataPist hideLoading];
    
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"暂时无法连接网络，请稍后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}


- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:Nil];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
