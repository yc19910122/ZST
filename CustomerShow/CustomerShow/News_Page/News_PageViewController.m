//
//  News_PageViewController.m
//  Icicle
//
//  Created by 讯 鹿 on 13-5-29.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "News_PageViewController.h"

//#import "Source/TouchXML.h"

@interface News_PageViewController ()

@end

@implementation News_PageViewController
@synthesize scroll;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stopClick" object:@"otherView"];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame=CGRectMake(0, 0, 1024, 710);
     [DataPist showLoading];
//     [self initFrameTitle];
//     self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [self performSelector:@selector(loadXml) withObject:nil afterDelay:0];
	// Do any additional setup after loading the view.
}

-(void)loadXml{
    
    [self parseDire];
   
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 80, 1024, 768-80)];
    scroll.delegate=self;
    scroll.backgroundColor=[UIColor whiteColor];
    scroll.showsVerticalScrollIndicator=YES;
    [self.view addSubview:scroll];
    
    for (int i = 0; i < newsArry.count; i++) {
        //240 360
        UIView *View = [[UIView alloc]init];
        [View setBackgroundColor:[UIColor clearColor]];
        View.frame = CGRectMake((i)*240+i*75+90, 50, 240, 360);
        UIImageView *image=[[UIImageView alloc]init];
        image.frame=CGRectMake(0, 0, 240, 200);
        NSString *newsImage=[NSString stringWithFormat:@"l_%@",[[newsArry objectAtIndex:i]objectForKey:@"front_img"]];
        image.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:newsImage]];
        [View addSubview:image];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 220, 240, 20)];
        label.text=[[newsArry objectAtIndex:i] objectForKey:@"title"];
        label.backgroundColor=[UIColor clearColor];
        [View addSubview:label];
        
        UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake(0, 250, 240, 100)];
        text.text=[[newsArry objectAtIndex:i]objectForKey:@"content"];
        text.editable=NO;
        text.textColor=[UIColor blackColor];
        text.backgroundColor=[UIColor clearColor];
        [View addSubview:text];
        
        UIButton *btn=[UIButton buttonWithType:0];
        btn.backgroundColor=[UIColor clearColor];
        btn.tag=i+100;
        btn.frame=CGRectMake(0, 0, 240, 360);
        [btn addTarget:self action:@selector(openDatetil:) forControlEvents:UIControlEventTouchUpInside];
        [View addSubview:btn];
        [scroll addSubview:View];
    }
    
    [scroll setContentSize:CGSizeMake(240*newsArry.count+newsArry.count*75+100, 0)];
    [DataPist hideLoading];

}
-(void)viewWillDisappear:(BOOL)animated{
   
    
}
- (void) parseDire
{
    newsArry = [[NSMutableArray alloc]init];
     newsArry=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:4]]];
}



-(void)openDatetil:(UIButton *)sender{
//    [DataPist showLoading];
    tag=sender.tag-100;
    [self performSelector:@selector(nextInfo) withObject:nil afterDelay:0];
        
}
-(void)nextInfo{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"weixinView" object:Nil];
    NewsDetail_ViewController *detailVC=[[NewsDetail_ViewController alloc]init];
//    detailVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    detailVC.contentDic=[newsArry objectAtIndex:tag];
    [self presentViewController:detailVC animated:YES completion:NULL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
