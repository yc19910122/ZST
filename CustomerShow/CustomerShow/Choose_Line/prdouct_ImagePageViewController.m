//
//  prdouct_BigImageViewController.m
//  Icicle
//
//  Created by 讯 鹿 on 13-5-30.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//
#import "prdouct_ImagePageViewController.h"
#import "DataPist.h"
@interface prdouct_ImagePageViewController ()

@end

@implementation prdouct_ImagePageViewController
@synthesize iamge,iamgeOne,textView,image_info,image_Name,imageArrys,infoView,currentNum,zoomScrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stopClick" object:@"otherView"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    flag=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    scroll.delegate=self;
    scroll.pagingEnabled=YES;
    scroll.userInteractionEnabled = YES;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.backgroundColor=[UIColor clearColor];
    scroll.maximumZoomScale = 2;
    scroll.minimumZoomScale = 1;
    [self.view addSubview:scroll];
    [self initImage:currentNum];
    
//    for (int i = 0; i < imageArrys.count; i++) {
//        zoomScrollView = [[MRZoomScrollView alloc]init];
//        CGRect frame = scroll.frame;
//        zoomScrollView.maximumZoomScale=2;
//        zoomScrollView.minimumZoomScale=1;
//        zoomScrollView.tag=2000+i;
//        zoomScrollView.showsVerticalScrollIndicator = NO;
//        zoomScrollView.showsHorizontalScrollIndicator=NO;
//        frame.origin.x = frame.size.width * i;
//        frame.origin.y = 0;
//        zoomScrollView.frame = frame;
//        [scroll addSubview:zoomScrollView];
//   }
//    
//    scroll.contentSize=CGSizeMake(1024*imageArrys.count, 768);
//    [self initImage:currentNum];
//    [scroll setContentOffset:CGPointMake(1024*currentNum, 0) animated:YES];
//    ret=NO;
    

//    btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame=CGRectMake(26, 700, 79,33);
//    [btn setBackgroundImage:[UIImage imageNamed:@"Move_back.png"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    
//    imageLogo=[[UIImageView alloc]initWithFrame:CGRectMake(120, 40, 104, 56)];
//     imageLogo.image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",[DataPist getFilePath:[[[DataPist shared].companyInfo objectAtIndex:0] objectForKey:@"company_logo"]]]];
//    [self.view addSubview:imageLogo];
    [self initImage:currentNum];
//    [infoView removeFromSuperview];
//    infoView=[[UIView alloc]initWithFrame:CGRectMake(810, 630, 300, 100)];
//    infoView.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:infoView];
//    
//    
//        UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(0, 85, 50, 15)];
//        name.text=[image_info objectForKey:@"name"];
//        name.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:7];
//        name.font=[UIFont systemFontOfSize:10];
//        name.backgroundColor=[UIColor clearColor];
//        [infoView addSubview:name];
//        
//        UILabel *huoHao=[[UILabel alloc]initWithFrame:CGRectMake(50, 85, 100, 15)];
//        huoHao.text=[image_info objectForKey:@"title"];
//        huoHao.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:7];
//        huoHao.font=[UIFont systemFontOfSize:10];
//        huoHao.backgroundColor=[UIColor clearColor];
//        [infoView addSubview:huoHao];
//        UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(0+150, 85, 50, 15)];
//        price.text=[image_info objectForKey:@"price"];
//        price.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:7];
//        price.font=[UIFont systemFontOfSize:10];
//        price.backgroundColor=[UIColor clearColor];
//        [infoView addSubview:price];
    
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"%d",tags);
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"left");
        if (tags >= 0 && tags < imageArrys.count-1) {
            tags++;
            [self initImage:tags];
        }
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right");
        if (tags > 0) {
            tags--;
            [self initImage:tags];
        }
    }
}
#pragma mark UIScrollView
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //    NSLog(@"------%@",NSStringFromCGSize(scrollView.contentSize));
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    //    if (YES) {
    imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                   scrollView.contentSize.height * 0.5 + offsetY);
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x >= 200) {
        if (tags >= 0 && tags < imageArrys.count-1) {
            tags++;
            [self initImage:tags];
        }
    }
    if (scrollView.contentOffset.x <= -200) {
        if (tags >= 0 && tags < imageArrys.count-1) {
            tags++;
            [self initImage:tags];
        }
    }
}

-(void)initImage :(int)tag{
    
    [DataPist showLoading];
    [imageView removeFromSuperview];
    [btn removeFromSuperview];
    [imageLogo removeFromSuperview];
    scroll.contentSize = CGSizeMake(1024, 768);
    BigView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    BigView.backgroundColor = [UIColor clearColor];
    BigView.userInteractionEnabled = YES;
    [scroll addSubview:BigView];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(224, 0, 576, 768)];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setUserInteractionEnabled:YES];
    [BigView addSubview:imageView];
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [BigView addGestureRecognizer:recognizer];
    UISwipeGestureRecognizer *recognizer1;
    recognizer1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer1 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [BigView addGestureRecognizer:recognizer1];
    
    
        btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(26, 700, 79,33);
        [btn setBackgroundImage:[UIImage imageNamed:@"Move_back.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    
        imageLogo=[[UIImageView alloc]initWithFrame:CGRectMake(120, 40, 104, 56)];
         imageLogo.image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",[DataPist getFilePath:[[[DataPist shared].companyInfo objectAtIndex:0] objectForKey:@"company_logo"]]]];
        [self.view addSubview:imageLogo];
    
    [self performSelector:@selector(getInfoImage) withObject:self afterDelay:0];
    tags=tag;
}
-(void)getInfoImage{
    
    NSString *imgPaths = [NSString stringWithFormat:@"l_%@",[[imageArrys objectAtIndex:tags] objectForKey:@"img"]];
    imageView.image = [UIImage imageWithContentsOfFile:[DataPist getFilePath:imgPaths]];
    
    NSLog(@"tags===%d",tags);
    
    [infoView removeFromSuperview];
    
    infoView=[[UIView alloc]initWithFrame:CGRectMake(810, 630, 200, 100)];
    infoView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:infoView];
    
    image_info=[imageArrys objectAtIndex:tags];
    [infoView removeFromSuperview];
    infoView=[[UIView alloc]initWithFrame:CGRectMake(810, 630, 200, 100)];
    infoView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:infoView];
    isHave=YES;
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(0, 85, 50, 15)];
    name.text=[image_info objectForKey:@"name"];
    name.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:7];
    name.font=[UIFont systemFontOfSize:10];
    name.backgroundColor=[UIColor clearColor];
    [infoView addSubview:name];
    
    UILabel *huoHao=[[UILabel alloc]initWithFrame:CGRectMake(50, 85, 100, 15)];
    huoHao.text=[image_info objectForKey:@"title"];
    huoHao.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:7];
    huoHao.font=[UIFont systemFontOfSize:10];
    huoHao.backgroundColor=[UIColor clearColor];
    [infoView addSubview:huoHao];
    
    UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(0+150, 85, 50, 15)];
    price.text=[image_info objectForKey:@"price"];
    price.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:7];
    price.font=[UIFont systemFontOfSize:10];
    price.backgroundColor=[UIColor clearColor];
    [infoView addSubview:price];
    [DataPist hideLoading];
    
    
}


- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
//    NSLog(@"ios6");
    return UIInterfaceOrientationMaskLandscape;
    //    self.interfaceOrientation
    
}

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:NULL];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
