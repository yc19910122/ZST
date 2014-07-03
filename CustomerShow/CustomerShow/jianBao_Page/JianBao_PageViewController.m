//
//  JianBao_PageViewController.m
//  Icicle
//
//  Created by 讯 鹿 on 13-5-29.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "JianBao_PageViewController.h"
#define ITEM_SPACING 410
#import "DataPist.h"
@interface JianBao_PageViewController ()

@end

@implementation JianBao_PageViewController
@synthesize viewBg,imageView,carousel,btn,scroll,jianbaoArrys;
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
    self.view.frame=CGRectMake(0, 0, 1024, 710);
    jianbaoArrys=[[NSMutableArray alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
    carousel=[[iCarousel alloc]initWithFrame:CGRectMake(0, 0, 1024, 700)];
    carousel.type=3;
    carousel.delegate=self;
    carousel.dataSource=self;
    [self.view addSubview:carousel];
    [self performSelector:@selector(loadInfo) withObject:Nil afterDelay:0];
 
}
-(void)loadInfo{
    
    jianbaoArrys=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:1]]];
    [DataPist hideLoading];
    [carousel reloadData];
}
-(void)viewDidAppear:(BOOL)animated{//[DataPist shared].ipString

}
#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [jianbaoArrys count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //create a numbered view
   UIView  *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 395, 559)];
    views.backgroundColor=[UIColor clearColor];//369, 507
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 395, 559)];
    [views addSubview:image];
    
    UIButton *imageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn.frame=CGRectMake(6, 0, 357,500);
    //----------------------------
    UIImageView *images=[[UIImageView alloc]initWithFrame:CGRectMake(8, 6, 381-2, 530)];
    image.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:[NSString stringWithFormat:@"s_%@",[[jianbaoArrys objectAtIndex:index] objectForKey:@"img"]]]];
    
    
    
    //-------------------------
    [imageBtn addTarget:self action:@selector(openPic:) forControlEvents:UIControlEventTouchUpInside];
    imageBtn.backgroundColor=[UIColor clearColor];
    imageBtn.tag=index;
    [views addSubview:images];
    [views addSubview:imageBtn];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(175, 532, 100, 20)];
    lable.backgroundColor=[UIColor clearColor];
    lable.text=[NSString stringWithFormat:@"%d - %d",[jianbaoArrys count],index+1];
    lable.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:7];
    lable.font=[UIFont systemFontOfSize:13];
    [views addSubview:lable];
    return views;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return imageView;
}

-(void)openPic:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"weixinView" object:Nil];

    viewBg=[[UIView alloc]initWithFrame:CGRectMake(0,-70, 1024, 768)];
    viewBg.backgroundColor=[UIColor blackColor];
    viewBg.alpha=0.5;
    [self.view addSubview:viewBg];
    
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    scroll.backgroundColor=[UIColor clearColor];
    scroll.delegate=self;
    scroll.maximumZoomScale=2;
    //    scroll.minimumZoomScale=1;
    [self.view addSubview:scroll];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap)];
    [scroll addGestureRecognizer:singleFingerTap];
    
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(200, 0, 600, 768)];
    
    imageView.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:[NSString stringWithFormat:@"l_%@",[[jianbaoArrys objectAtIndex:sender.tag] objectForKey:@"img"]]]];

    //---------------------
    
    [scroll addSubview:imageView];
    
    btn=[UIButton buttonWithType:0];
    btn.frame=CGRectMake(26, 720, 79,33);
    [btn setBackgroundImage:[UIImage imageNamed:@"fh.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)ok{
    [viewBg removeFromSuperview];
    [scroll removeFromSuperview];
    [btn removeFromSuperview];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                               scrollView.contentSize.height * 0.5 + offsetY);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [viewBg removeFromSuperview];
    [scroll removeFromSuperview];
    [btn removeFromSuperview];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"stopClick" object:@"otherView"];

}

- (void)handleSingleTap
{
    [viewBg removeFromSuperview];
    [scroll removeFromSuperview];
    [btn removeFromSuperview];
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
