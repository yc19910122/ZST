//
//  Choose_LineViewController.m
//  Icicle
//
//  Created by User #⑨ on 13-5-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "Choose_LineViewController.h"
#import "DataPist.h"
#import "ProdouctView.h"
#import "prdouct_ImagePageViewController.h"
@interface Choose_LineViewController ()

@end

@implementation Choose_LineViewController
@synthesize image_letforRight,proView;
- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
    //    self.interfaceOrientation
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stopClick" object:@"otherView"];
}
-(void)jumpbigImage:(NSNotification *)nocity{
    NSDictionary *dic=nocity.userInfo;
    NSString *string=nocity.object;
    NSArray *arrys=(NSArray *)dic;
    int num=[string intValue];
    
        prdouct_ImagePageViewController *pro=[[prdouct_ImagePageViewController alloc]init];
        pro.image_info=[arrys objectAtIndex:num];
        pro.image_Name=[NSString stringWithFormat:@"l_%@",[[arrys objectAtIndex:num] objectForKey:@"img"]];
        pro.imageArrys=arrys;
        pro.currentNum=num;
        [DataPist hideLoading];
        [self presentViewController:pro animated:YES completion:NULL];
}
-(void)remove{
    
    [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        proView.frame=CGRectMake(1024, 0, 1024, 768-80);
     
    }completion:^(BOOL finisd){
         [proView removeFromSuperview];
    }];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"remove" object:Nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"infoIMage" object:Nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpbigImage:) name:@"infoIMage" object:Nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove) name:@"remove" object:Nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stopClick" object:@"otherView"];

    self.view.frame=CGRectMake(0, 0, 1024, 768);
    self.view.backgroundColor=[UIColor colorWithRed:240 green:240 blue:240 alpha:1];
//     [self initFrameTitle];
    UIImageView *imageLeft=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 512,698)];
    NSArray *ArryLeft=[[[DataPist shared].plistInfo objectAtIndex:0] objectForKey:@"lines"];
    if (ArryLeft.count==0) {
        imageLeft.image=[UIImage imageNamed:@"weitu.jpg"];
    }else{
        NSString *nameLeft=[NSString stringWithFormat:@"l_%@",[[[DataPist shared].plistInfo objectAtIndex:0]objectForKey:@"img"]];
        imageLeft.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:nameLeft]];
    }
    [self.view addSubview:imageLeft];
    
    UIImageView *imageRight=[[UIImageView alloc]initWithFrame:CGRectMake(512,0,512,698)];
    NSArray *Arryright=[[[DataPist shared].plistInfo objectAtIndex:1] objectForKey:@"lines"];
    if (Arryright.count ==0) {
        imageRight.image=[UIImage imageNamed:@"weitu.jpg"];
    }else{
        NSString *nameRight=[NSString stringWithFormat:@"l_%@",[[[DataPist shared].plistInfo objectAtIndex:1]objectForKey:@"img"]];
        imageRight.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:nameRight]];
    }
    [self.view addSubview:imageRight];
    
    UIButton *btnLeft=[UIButton buttonWithType:0];
    btnLeft.frame=CGRectMake(0, 0, 512,686);
    btnLeft.tag=998;
    [btnLeft addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLeft];
    
    UIButton *btnRight=[UIButton buttonWithType:0];
    btnRight.frame=CGRectMake(512, 0, 512,686);
    btnRight.tag=999;
    [btnRight addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRight];
   
}
-(void)loading{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)next:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"weixinView" object:Nil];

    proView=[[ProdouctView alloc]init];
    if (sender.tag == 998) {
           proView.line_name =[[[DataPist shared].plistInfo objectAtIndex:0]objectForKey:@"lines"];
        proView.season=@"left";
    }
    if (sender.tag == 999){
           proView.line_name =[[[DataPist shared].plistInfo objectAtIndex:1]objectForKey:@"lines"];
        proView.season=@"right";
    }
    [proView loadView];
    [DataPist hideLoading];
    proView.frame=CGRectMake(1024, 0, 1024, 768-80);
//    [self presentViewController:pro animated:YES completion:NULL];
    
    
    [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        proView.frame=CGRectMake(0, 0, 1024, 768-80);
        [self.view addSubview:proView];
    }completion:NULL];
}

- (void)GoBack
{
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
