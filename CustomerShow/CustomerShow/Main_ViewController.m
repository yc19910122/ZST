//
//  Main_ViewController.m
//  CustomerShow
//
//  Created by 讯 鹿 on 13-11-18.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "Main_ViewController.h"
#import "LogIn_PageViewController.h"
#import "companyView.h"
@interface Main_ViewController ()

@end

@implementation Main_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)closeView{
    [viewBg removeFromSuperview];
}

-(void)openView:(NSNotification *)nocity{
    weizhi=0;
    [viewBg removeFromSuperview];
    NSDictionary *dic=nocity.userInfo;
    if ([[DataPist shared].leftOrright isEqualToString:@"left"]) {
        viewBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        viewBg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"open.png"]];
        [self.view addSubview:viewBg];
        UIButton *btn=[UIButton buttonWithType:0];
        btn.frame=CGRectMake(840, 80, 100, 100);
        [btn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [viewBg addSubview:btn];
        
        UIScrollView *scrll=[[UIScrollView alloc]initWithFrame:CGRectMake(123, 155, 233, 565)];
        scrll.backgroundColor=[UIColor clearColor];
        [viewBg addSubview:scrll];
        arryImages=[dic objectForKey:@"images"];
        
        for (int i=0; i<arryImages.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            
             NSString *name=[NSString stringWithFormat:@"%@",[arryImages objectAtIndex:i]];
            [btn addTarget:self action:@selector(openImage:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageWithContentsOfFile:[DataPist getFilePath:name]] forState:0];
            
            NSData *data=[NSData dataWithContentsOfFile:[DataPist getFilePath:name]];
            UIImage *IMAGE=[UIImage imageWithData:data];
            if (IMAGE.size.width>=231) {
                [ btn setFrame:CGRectMake(0, weizhi+5*i,231,231/IMAGE.size.width*IMAGE.size.height)];
                weizhi = weizhi+231/IMAGE.size.width*IMAGE.size.height;
            }else{
                 [ btn setFrame:CGRectMake(0, weizhi+5*i, IMAGE.size.width,IMAGE.size.height)];
                weizhi = weizhi+IMAGE.size.height;
            }
            
            [scrll addSubview:btn];
            btn.tag=i;
            [scrll setContentSize:CGSizeMake(0, weizhi)];
        }
        //385 154
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(385, 154, 400, 50)];
        label.font=[UIFont systemFontOfSize:30];
        [viewBg addSubview:label];
        label.text=[dic objectForKey:@"title"];
        label.backgroundColor=[UIColor clearColor];
        UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake(385, 154+60, 517, 520)];
        text.backgroundColor=[UIColor clearColor];
        text.font=[UIFont systemFontOfSize:18];
        text.text=[dic objectForKey:@"content"];
//        text.userInteractionEnabled=NO;
        text.editable=NO;
        [viewBg addSubview:text];
    }else{
        
        viewBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        viewBg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"open.png"]];
        [self.view addSubview:viewBg];
        UIButton *btn=[UIButton buttonWithType:0];
       
        btn.frame=CGRectMake(840, 80, 100, 100);
        [btn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [viewBg addSubview:btn];
        UIScrollView *scrll=[[UIScrollView alloc]initWithFrame:CGRectMake(123, 155, 233, 565)];
        scrll.backgroundColor=[UIColor clearColor];
        [viewBg addSubview:scrll];
//        int weizhi;
          arryImages=[dic objectForKey:@"images"];
        for (int i=0; i<arryImages.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            NSString *name=[NSString stringWithFormat:@"%@",[arryImages objectAtIndex:i]];
            [btn setImage:[UIImage imageWithContentsOfFile:[DataPist getFilePath:name]] forState:0];
            [btn addTarget:self action:@selector(openImage:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageWithContentsOfFile:[DataPist getFilePath:name]] forState:0];
            NSData *data=[NSData dataWithContentsOfFile:[DataPist getFilePath:name]];
            UIImage *IMAGE=[UIImage imageWithData:data];
            
            
            
            if (IMAGE.size.width>=231) {
                [ btn setFrame:CGRectMake(0, weizhi+5*i,231,231/IMAGE.size.width*IMAGE.size.height)];
                weizhi = weizhi+231/IMAGE.size.width*IMAGE.size.height;
            }else{
                [ btn setFrame:CGRectMake(0, weizhi+5*i, IMAGE.size.width,IMAGE.size.height)];
                weizhi = weizhi+IMAGE.size.height;
            }
            [scrll addSubview:btn];
             btn.tag=i;
            [scrll setContentSize:CGSizeMake(0, weizhi)];
        }
        //385 154
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(385, 154, 400, 50)];
        label.font=[UIFont systemFontOfSize:30];
        [viewBg addSubview:label];
        label.text=[dic objectForKey:@"title"];
        label.backgroundColor=[UIColor clearColor];
        UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake(385, 154+60, 517, 520)];
        text.backgroundColor=[UIColor clearColor];
        text.text=[dic objectForKey:@"content"];
        text.font=[UIFont systemFontOfSize:18];
//        text.userInteractionEnabled=NO;
        text.editable=NO;
        [viewBg addSubview:text];
    }
}
-(void)openImage:(UIButton *)sender{
//    if (Isopen==YES) {
    [viewshade removeFromSuperview];
        viewshade=[[UIView alloc]initWithFrame:CGRectMake(400/2+45, 154+15, 517+10, 520+10)];
        viewshade.backgroundColor=[UIColor blackColor];
        viewshade.alpha=0.5;
        [viewBg addSubview:viewshade];

        [image removeFromSuperview];
        image=[[UIImageView alloc]initWithFrame:CGRectMake(400/2+50, 154+20, 517, 520)];
        NSString *name=[NSString stringWithFormat:@"%@",[arryImages objectAtIndex:sender.tag]];
        image.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:name]];
        NSData *data=[NSData dataWithContentsOfFile:[DataPist getFilePath:name]];
        UIImage *Image=[UIImage imageWithData:data];
    
    if (Image.size.height>=600) {
        viewshade.frame=CGRectMake(400/2+45, 154, 600/Image.size.height*Image.size.width+10, 600+10);
        image.frame=CGRectMake(400/2+50, 159, 600/Image.size.height*Image.size.width, 600);
    }else{
        
        if (Image.size.width>=517) {
            viewshade.frame=CGRectMake(400/2+45, 154+15, 517+10, 517/Image.size.width*Image.size.height+10);
            image.frame=CGRectMake(400/2+50, 154+20, 517+10, 517/Image.size.width*Image.size.height+10);
        }else{
            viewshade.frame=CGRectMake(400/2+45+100, 154+15, Image.size.width+10, Image.size.height+10);
            image.frame=CGRectMake(400/2+50+100, 154+20, Image.size.width, Image.size.height);
            
        }

    }
    
    
           [viewBg addSubview:image];
    
        Isopen=NO;
//    }else if (Isopen==NO){
//        [image removeFromSuperview];
//        Isopen=YES;
//    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    viewshade.hidden=YES;
    [viewshade removeFromSuperview];
     [image removeFromSuperview];
}
-(void)closeWeiXin{
    [imageWeiXin removeFromSuperview];
    isOpenWeiXin=NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    Isopen=YES;
    isOpenWeiXin=NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openView:) name:@"openView" object:Nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeWeiXin) name:@"weixinView" object:Nil];

    [self initTitle];
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 1024, 768)];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:contentView];
    
    chooseView=[[Choose_LineViewController alloc]init];
    [self addChildViewController:chooseView];
    
    videoView =[[Move_BigPicViewController alloc]init];
    [self addChildViewController:videoView];
    
    jianBaoView=[[JianBao_PageViewController alloc]init];
    [self addChildViewController:jianBaoView];
    
    newsView=[[News_PageViewController alloc]init];
    [self addChildViewController:newsView];
    
    weiBoView=[[WeiBo_PageViewController alloc]init];
    [self addChildViewController:weiBoView];
    
    dapeiView=[[DaPei_ViewController alloc]init];
    [self addChildViewController:dapeiView];
    
    
    [contentView addSubview:chooseView.view];
    currentViewController=chooseView;
    isDown=@"0";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isDown:) name:@"downLing" object:Nil];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"downLing" object:Nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"openView" object:Nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"weixinView" object:Nil];
    

}
-(void)isDown:(NSNotification *)nocity{
    isDown=nocity.object;
}

-(void)backLogn:(UITapGestureRecognizer *)gg{
    
    if (gg.numberOfTapsRequired==1) {
        
        [self companyInfo];
        
    }else if (gg.numberOfTapsRequired==2){
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否注销" delegate:self
                                           cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alter show];
        alter.tag=1;
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex==0) {
            LogIn_PageViewController *login=[[LogIn_PageViewController alloc]init];
            [self presentViewController:login animated:YES completion:NULL];
        }else if(buttonIndex==1){
            
        }
    }
}
-(void)companyInfo{
    [imageWeiXin removeFromSuperview];
    isOpenWeiXin=NO;
    [DataPist shared].isCurrent=@"NO";
    [videoView.MovieView pause];
    [productBtn setTitleColor:[UIColor blackColor] forState:0];
    [videoBtn setTitleColor:[UIColor blackColor] forState:0];
    [newsBtn setTitleColor:[UIColor blackColor] forState:0];
    [jianBaoBtn setTitleColor:[UIColor blackColor] forState:0];
    [dapei setTitleColor:[UIColor blackColor] forState:0];
    [company removeFromSuperview];
    company=[[companyView alloc]initWithFrame:CGRectMake(0, 70, 1024, 768)];
    company.backgroundColor=[UIColor whiteColor];
    company.webString=[[[DataPist shared].companyInfo objectAtIndex:0] objectForKey:@"company_profile"];
    [self.view addSubview:company];
    company.arrys=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:10]]];
    [company companyInfo];
}
//初始化导航栏
-(void)initTitle{
    
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"isDown" object:@"0"];
        [DataPist shared].titleArry=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:6]]];
        [DataPist shared].companyInfo=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:3]]];
    
        UIImageView *images=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 104, 56)];
        images.image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",[DataPist getFilePath:[[[DataPist shared].companyInfo objectAtIndex:0] objectForKey:@"company_logo"]]]];
        images.userInteractionEnabled=YES;
        [self.view addSubview:images];
    
        UITapGestureRecognizer *oneFingerONe=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backLogn:)];
        oneFingerONe.numberOfTapsRequired = 1;
        [images addGestureRecognizer:oneFingerONe];
    
        UITapGestureRecognizer *oneFingerTwo=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backLogn:)];
        oneFingerTwo.numberOfTapsRequired = 2;
        [images addGestureRecognizer:oneFingerTwo];
    
   
    
    
        productBtn=[UIButton buttonWithType:0];
        productBtn.frame=CGRectMake(118, 0, 86, 61);
        productBtn.tag=0;
        [productBtn setTitleColor:[UIColor grayColor] forState:0];
        [productBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [productBtn setTitle:[[DataPist shared].titleArry objectAtIndex:0] forState:0];
        [productBtn setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:productBtn];
        
         videoBtn=[UIButton buttonWithType:0];
        videoBtn.frame=CGRectMake(205, 0, 86, 61);
        videoBtn.tag=1;
        [videoBtn setBackgroundColor:[UIColor whiteColor]];
        [videoBtn setTitleColor:[UIColor blackColor] forState:0];
        [videoBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [videoBtn setTitle:[[DataPist shared].titleArry objectAtIndex:1] forState:0];
        
        [self.view addSubview:videoBtn];
        
         jianBaoBtn=[UIButton buttonWithType:0];
        jianBaoBtn.frame=CGRectMake(292, 0, 86, 61);
        jianBaoBtn.tag=2;
        [jianBaoBtn setBackgroundColor:[UIColor whiteColor]];
        [jianBaoBtn setTitleColor:[UIColor blackColor] forState:0];
        [jianBaoBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [jianBaoBtn setTitle:[[DataPist shared].titleArry objectAtIndex:2] forState:0];
        [self.view addSubview:jianBaoBtn];
        
        newsBtn=[UIButton buttonWithType:0];
        newsBtn.frame=CGRectMake(379, 0, 86, 61);
        newsBtn.tag=3;
        [newsBtn setBackgroundColor:[UIColor whiteColor]];
        [newsBtn setTitleColor:[UIColor blackColor] forState:0];
        [newsBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [newsBtn setTitle:[[DataPist shared].titleArry objectAtIndex:3] forState:0];
        [self.view addSubview:newsBtn];
    
    
    dapei=[UIButton buttonWithType:0];
    dapei.frame=CGRectMake(379+86, 0, 86, 61);
    dapei.tag=5;
      [dapei setBackgroundColor:[UIColor whiteColor]];
    [dapei setTitleColor:[UIColor blackColor] forState:0];
    [dapei addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [dapei setTitle:[[DataPist shared].titleArry objectAtIndex:4] forState:0];
    [self.view addSubview:dapei];
    
    
   UIButton *WeixinBtn=[UIButton buttonWithType:0];
    WeixinBtn.frame=CGRectMake(952-86, 25, 34, 28);
    [WeixinBtn setBackgroundColor:[UIColor whiteColor]];
    [WeixinBtn setTitleColor:[UIColor blackColor] forState:0];
    [WeixinBtn addTarget:self action:@selector(weixin:) forControlEvents:UIControlEventTouchUpInside];
    [WeixinBtn setBackgroundImage:[UIImage imageNamed:@"wx.png"]  forState:UIControlStateNormal];
    [self.view addSubview:WeixinBtn];
    
    
    NSString *weiBoString = [[[DataPist shared].companyInfo objectAtIndex:0] objectForKey:@"company_weibo"];
    if ([weiBoString isEqualToString:@""]) {
        
    }else{
        weiBoBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        weiBoBtn.frame=CGRectMake(952, 24, 32, 26);
        weiBoBtn.tag=4;
        [weiBoBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [weiBoBtn setBackgroundImage:[UIImage imageNamed:@"xinglang.png"]  forState:UIControlStateNormal];
        [self.view addSubview:weiBoBtn];
    }
    
}
-(void)weixin:(UIButton *)sender{
    if (isOpenWeiXin==NO) {
        
        imageWeiXin=[[UIImageView alloc]initWithFrame:CGRectMake(760, -267, 251, 267)];
        imageWeiXin.image=[UIImage imageNamed:@"wxber_03.png"];
        [self.view addSubview:imageWeiXin];
        
        UITapGestureRecognizer *ger=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remoWeiXin)];
        [imageWeiXin addGestureRecognizer:ger];
        [ger setNumberOfTouchesRequired:1];
        imageWeiXin.userInteractionEnabled=YES;
        
        UIImageView *imageWei=[[UIImageView alloc]initWithFrame:CGRectMake(250/2-75, 60, 150, 150)];
        imageWei.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:[[[DataPist shared].companyInfo objectAtIndex:0] objectForKey:@"company_wechat"]]];
        [imageWeiXin addSubview:imageWei];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 220, 200, 20)];
        label.text=[[[DataPist shared].companyInfo objectAtIndex:0] objectForKey:@"company_wechat_commet"];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:13];
        label.numberOfLines=0;
        [imageWeiXin addSubview:label];
        
        [UIView transitionWithView:imageWeiXin duration:0.3 options:0 animations:^{
            imageWeiXin.frame=CGRectMake(760, 55, 251, 267);
        }completion:NULL];
        isOpenWeiXin=YES;
        
    }else if (isOpenWeiXin==YES){
        [UIView transitionWithView:imageWeiXin duration:0.3 options:0 animations:^{
            imageWeiXin.frame=CGRectMake(760, -267, 251, 267);
        }completion:^(BOOL fisish){
            [imageWeiXin removeFromSuperview];
        }];
        isOpenWeiXin=NO;
    }
   
}
-(void)remoWeiXin{
    [UIView transitionWithView:imageWeiXin duration:0.3 options:0 animations:^{
        imageWeiXin.frame=CGRectMake(760, -267, 251, 267);
    }completion:^(BOOL fisish){
        [imageWeiXin removeFromSuperview];
    }];
    isOpenWeiXin=NO;
}
//页面跳转
-(void)click:(UIButton *)sender{
    [company removeFromSuperview];
    [imageWeiXin removeFromSuperview];
    isOpenWeiXin=NO;
    //移除掉添加在产品页面的单品View；
    if (sender.tag==0||sender.tag==2||sender.tag==3||sender.tag==4||sender.tag==5) {
        [videoView.MovieView pause];
        [DataPist shared].isCurrent=@"NO";
    }else if (sender.tag==1){
       [DataPist shared].isCurrent=@"YES";
        if ([isDown isEqualToString:@"1"]) {
            
        }else if([isDown isEqualToString:@"0"]){
             [videoView.MovieView play];
        }
        
    }
    
    if ((currentViewController == chooseView && sender.tag == 0)||(currentViewController == videoView && sender.tag == 1)||(currentViewController == jianBaoView && sender.tag == 2)||(currentViewController == newsView && sender.tag == 3)||(currentViewController == weiBoView && sender.tag == 4)||(currentViewController == dapeiView && sender.tag == 5)) {
        return;
    }
    
    UIViewController *oldViewController=currentViewController;
    switch (sender.tag) {
        case 0:{
            //产品推荐
            
//            [UIView transitionWithView:self.view duration:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
//                imagejiao.frame=CGRectMake(152, 58-8, 19, 8);
//            }completion:NULL];
            
            [chooseView.proView removeFromSuperview];
            
            [productBtn setTitleColor:[UIColor grayColor] forState:0];
            [videoBtn setTitleColor:[UIColor blackColor] forState:0];
            [newsBtn setTitleColor:[UIColor blackColor] forState:0];
            [jianBaoBtn setTitleColor:[UIColor blackColor] forState:0];
//            [weiBoBtn setTitleColor:[UIColor blackColor] forState:0];
            [dapei setTitleColor:[UIColor blackColor] forState:0];

            
            [self transitionFromViewController:currentViewController toViewController:chooseView duration:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            }  completion:^(BOOL finished) {
                if (finished) {
                    currentViewController=chooseView;
                }else{
                    currentViewController=oldViewController;
                }
            }];
            
        }
            
            break;
        case 1:{
            //流行趋势
            [productBtn setTitleColor:[UIColor blackColor] forState:0];
            [videoBtn setTitleColor:[UIColor grayColor] forState:0];
            [newsBtn setTitleColor:[UIColor blackColor] forState:0];
            [jianBaoBtn setTitleColor:[UIColor blackColor] forState:0];
            //            [weiBoBtn setTitleColor:[UIColor blackColor] forState:0];
            [dapei setTitleColor:[UIColor blackColor] forState:0];
            
            [self transitionFromViewController:currentViewController toViewController:videoView duration:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            }  completion:^(BOOL finished) {
                if (finished) {
                    currentViewController=videoView;
                }else{
                    currentViewController=oldViewController;
                }
            }];
        }
            
            break;
        case 2:{
            //jianbao
            [productBtn setTitleColor:[UIColor blackColor] forState:0];
            [videoBtn setTitleColor:[UIColor blackColor] forState:0];
            [newsBtn setTitleColor:[UIColor blackColor] forState:0];
            [jianBaoBtn setTitleColor:[UIColor grayColor] forState:0];
            //            [weiBoBtn setTitleColor:[UIColor blackColor] forState:0];
            [dapei setTitleColor:[UIColor blackColor] forState:0];
            
            [self transitionFromViewController:currentViewController toViewController:jianBaoView duration:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{} completion:^(BOOL finished){
                if (finished) {
                    currentViewController=jianBaoView;
                }else{
                    currentViewController=oldViewController;
                }
            }];
            
        }
            
            break;
        case 3:{
            //vip服务
            [productBtn setTitleColor:[UIColor blackColor] forState:0];
            [videoBtn setTitleColor:[UIColor blackColor] forState:0];
            [newsBtn setTitleColor:[UIColor grayColor] forState:0];
            [jianBaoBtn setTitleColor:[UIColor blackColor] forState:0];
            //            [weiBoBtn setTitleColor:[UIColor blackColor] forState:0];
            [dapei setTitleColor:[UIColor blackColor] forState:0];
            
            [self transitionFromViewController:currentViewController toViewController:newsView duration:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{} completion:^(BOOL finished){
                if (finished) {
                    currentViewController=newsView;
                }else{
                    currentViewController=oldViewController;
                }
            }];
            
            
        } break;
        case 4:{
            //vip服务
            [productBtn setTitleColor:[UIColor blackColor] forState:0];
            [videoBtn setTitleColor:[UIColor blackColor] forState:0];
            [newsBtn setTitleColor:[UIColor blackColor] forState:0];
            [jianBaoBtn setTitleColor:[UIColor blackColor] forState:0];
            //            [weiBoBtn setTitleColor:[UIColor blackColor] forState:0];
            [dapei setTitleColor:[UIColor blackColor] forState:0];
            
            [self transitionFromViewController:currentViewController toViewController:weiBoView duration:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{} completion:^(BOOL finished){
                if (finished) {
                    currentViewController=weiBoView;
                }else{
                    currentViewController=oldViewController;
                }
            }];
        } break;
            
        case 5:{
            //vip服务
            [productBtn setTitleColor:[UIColor blackColor] forState:0];
            [videoBtn setTitleColor:[UIColor blackColor] forState:0];
            [newsBtn setTitleColor:[UIColor blackColor] forState:0];
            [jianBaoBtn setTitleColor:[UIColor blackColor] forState:0];
            //            [weiBoBtn setTitleColor:[UIColor blackColor] forState:0];
            [dapei setTitleColor:[UIColor grayColor] forState:0];
            
            [self transitionFromViewController:currentViewController toViewController:dapeiView duration:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{} completion:^(BOOL finished){
                if (finished) {
                    currentViewController=dapeiView;
                }else{
                    currentViewController=oldViewController;
                }
            }];
        } break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
