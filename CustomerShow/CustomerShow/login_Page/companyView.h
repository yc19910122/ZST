//
//  companyView.h
//  CustomerShow
//
//  Created by 讯 鹿 on 13-12-11.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface companyView : UIView<UIScrollViewDelegate>{
    UIView *companyView;
    UIScrollView *scroll;
    UIPageControl *page;
    NSString *webString;
    NSMutableArray *arrys;
}
@property(nonatomic,strong)UIView *companyView;
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UIPageControl *page;
@property(nonatomic,strong)NSString *webString;
@property(nonatomic,strong)NSMutableArray *arrys;
-(void)companyInfo;
@end
