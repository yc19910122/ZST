//
//  companyView.m
//  CustomerShow
//
//  Created by 讯 鹿 on 13-12-11.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "companyView.h"

@implementation companyView
@synthesize scroll,page,companyView,webString,arrys;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
    }
    return self;
}
-(void)companyInfo{
    
    UILabel *textTitle=[[UILabel alloc]initWithFrame:CGRectMake(480, 30, 100, 30)];
    textTitle.backgroundColor=[UIColor whiteColor];
    textTitle.font=[UIFont boldSystemFontOfSize:18];
    textTitle.text=@"品牌介绍";
    [self addSubview:textTitle];
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(212, 80, 600, 300)];
    //下面两行协助 UIWebView 背景透明化，这两属性可以在 xib 中进行设置
    webview.backgroundColor = [UIColor clearColor];  //但是这个属性必须用代码设置，光 xib 设置不行
    webview.opaque = NO;
    
    //这行能在模拟器下明下加快 loadHTMLString 后显示的速度，其实在真机上没有下句也感觉不到加载过程
    webview.dataDetectorTypes = UIDataDetectorTypeNone;
    //下面的 backgroud-color:transparent 结合最前面的两行代码指定的属性就真正使得 WebView 的背景透明了
    //而后的 font:16px/18px 就是设置字体大小为 16px, 行间距为 18px，也可用  line-height: 18px 单独设置行间距
    //最后的 Custom-Font-Name 就是前面在项目中加上的字体文件所对应的字体名称了
    NSString *webviewText = @"<style>body{margin:0;background-color:transparent;text-indent:2em;font:16px/30px 方正兰亭黑}</style>";
    NSString *htmlString = [webviewText stringByAppendingFormat:@"%@", webString];
    [webview loadHTMLString:htmlString baseURL:nil]; //在 WebView 中显示本地的字符串
    [self addSubview:webview];
    
    //去掉阴影
    for (UIView *aView in [webview subviews])
    {
        if ([aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条 （水平的类似）
            for (UIView *shadowView in aView.subviews)
            {
                if ([shadowView isKindOfClass:[UIImageView class]])
                {
                    shadowView.hidden = YES;  //上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }
    
    
    UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake(200, 390, 600, 1)];
    viewLine.backgroundColor=[UIColor grayColor];
    [self addSubview:viewLine];
    
    UILabel *textbottom=[[UILabel alloc]initWithFrame:CGRectMake(480, 410, 100, 30)];
    textbottom.backgroundColor=[UIColor whiteColor];
    textbottom.font=[UIFont boldSystemFontOfSize:18];
    textbottom.text=@"门店地址";
    [self addSubview:textbottom];
    [self initAddress];
    
}
-(void)initAddress{
    
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(212, 450, 600, 170)];
    scroll.backgroundColor=[UIColor whiteColor];
    scroll.delegate=self;
    scroll.pagingEnabled=YES;
    scroll.showsVerticalScrollIndicator=NO;
    scroll.showsHorizontalScrollIndicator=NO;
    [self addSubview:scroll];
    
    
    for (int i=0; i<arrys.count; i++) {
       
        UIView *nView = [[UIView alloc] initWithFrame:CGRectMake(0+300*i+20*i,0, 300, 170)];
        nView.backgroundColor=[UIColor whiteColor];
        [scroll addSubview:nView];
        
        UILabel *label1=[[UILabel alloc]init];
        label1.frame=CGRectMake(0,30, 300, 20);
        label1.text=[[arrys objectAtIndex:i] objectForKey:@"name"];
        label1.textColor=[UIColor grayColor];
        label1.font=[UIFont systemFontOfSize:14];
        [nView addSubview:label1];
        
        UILabel *label2=[[UILabel alloc]init];
        label2.frame=CGRectMake(0,70, 300, 20);
        label2.text=[[arrys objectAtIndex:i] objectForKey:@"address"];
        label2.textColor=[UIColor grayColor];
        label2.numberOfLines=0;
        label2.font=[UIFont systemFontOfSize:14];
        [nView addSubview:label2];
        
        UILabel *label3=[[UILabel alloc]init];
        label3.frame=CGRectMake(0,110, 300, 20);
        label3.text=[[arrys objectAtIndex:i] objectForKey:@"contact_phone"];
        label3.textColor=[UIColor grayColor];
        label3.font=[UIFont systemFontOfSize:14];
        [nView addSubview:label3];

        
        [scroll addSubview:nView];
        
        //        NSLog(@"-=t=%d==--%@",t,NSStringFromCGRect(scroll.frame));
    }
    int number;
    if (arrys.count%2==0) {
        number=arrys.count/2;
        
    }else {
        number=arrys.count/2+1;
    }
    [scroll setContentSize:CGSizeMake(600*number,170)];
    page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 600, 1024, 20)];
    page.backgroundColor=[UIColor clearColor];
    page.currentPage=0;
    page.pageIndicatorTintColor=[UIColor grayColor];
    page.currentPageIndicatorTintColor=[UIColor blackColor];
    NSLog(@"%d",arrys.count);
//    if (arrys.count%2==0) {
        page.numberOfPages=number;
        
//    }else if(arrys.count%2==1){
//        page.numberOfPages=arrys.count/2+1;
//    }
    [self addSubview:page];
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int n=scrollView.contentOffset.x/600;
    page.currentPage=n;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
