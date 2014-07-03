//
//  NewsDetail_ViewController.m
//  Icicle
//
//  Created by 讯 鹿 on 13-7-9.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "NewsDetail_ViewController.h"
#import "ASIHTTPRequest.h"
@interface NewsDetail_ViewController ()

@end

@implementation NewsDetail_ViewController
@synthesize scroll,contentDic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [DataPist showLoading];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self initFrameTitle];
//    [DataPist showLoading];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *backBtn=[UIButton buttonWithType:0];
    backBtn.frame=CGRectMake(26, 700, 79,33);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"Move_back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, 1024, 450)];
    scroll.delegate=self;
    scroll.backgroundColor=[UIColor clearColor];
    scroll.showsVerticalScrollIndicator=NO;
    scroll.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scroll];
    [self performSelector:@selector(initFrame) withObject:nil afterDelay:0];
    //    [DataPist hideLoading];
}
//-(void)loadView{
//    
//}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}
-(void)initFrame{
   
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, -7, 280, 30)];
    label.text=[contentDic objectForKey:@"title"];
    label.numberOfLines=0;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:15];
    [scroll addSubview:label];
    
    UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(95, 30, 280, 370)];
    NSString *stirng=[[contentDic objectForKey:@"content"] stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    textView.text=stirng;
    textView.delegate=self;
    textView.font=[UIFont systemFontOfSize:14];
//    textView.editable=NO;
    [scroll addSubview:textView];
    weizhi = 380;
    UIImageView *image;
    NSArray *imageArry=[contentDic objectForKey:@"images"];
    for (int i=0; i<imageArry.count; i++) {
        image=[[UIImageView alloc]init];
        NSData *data=[NSData dataWithContentsOfFile:[DataPist getFilePath:[imageArry objectAtIndex:i]]];
        UIImage *images=[UIImage imageWithData:data];
        
        if (i == 0) {
//            image.frame = CGRectMake(380, 0, images.size.width, images.size.height);
            if (images.size.height >=400) {
                [image setFrame:CGRectMake(380, 10, 400/images.size.height*images.size.width,410)];
                image.image=images;
                 weizhi = weizhi+400/images.size.height*images.size.width;
            }else
                {
                    [image setFrame:CGRectMake(380, 10, images.size.width, images.size.height)];
                    image.image=images;
                    weizhi = weizhi+images.size.width;
                }
        }else
        {
            if (images.size.height >=400)
            {
                [image setFrame:CGRectMake(weizhi, 10, 400/images.size.height*images.size.width, 410)];
                image.image=images;
                weizhi = weizhi+400/images.size.height*images.size.width;
            }
             else
                {
                    [image setFrame:CGRectMake(weizhi, 10, images.size.width, images.size.height)];
                    image.image=images;
                    weizhi = weizhi+images.size.width;
                }
        }
        
//        weizhi = weizhi+images.size.width;
        image.backgroundColor=[UIColor clearColor];
        [scroll addSubview:image];
    }
    [scroll setContentSize:CGSizeMake(weizhi, 0)];
    [DataPist hideLoading];

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
