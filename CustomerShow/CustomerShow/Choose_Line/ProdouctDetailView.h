//
//  ProdouctDetailView.h
//  CustomerShow
//
//  Created by songbai on 13-11-18.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProdouctDetailView : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    UITableView *tbView;
	NSMutableArray *data;
    UIButton *btn;
    UIView *view;
    BOOL yet;
    int  m;
    int scor;
    UIView *zheZhaoview;
    NSString *code;
    NSDictionary *dic_line;
    BOOL is_Clcik;
    UIView *TanChuView;
    NSTimer *timer;
    
    
    
    NSArray *arryImages;
}
@property(strong,nonatomic)UIScrollView *scroll;
@property (nonatomic, retain)UITableView *tableData;
@property (nonatomic, retain)NSString *titleName;
@property (nonatomic, strong)NSArray *line_detailInfo;
@property (nonatomic, retain)NSString *season;
@property (nonatomic, strong)NSDictionary *line_name;
@property (nonatomic, strong)NSDictionary *dic_line;

@property (nonatomic, strong)NSArray *arryImages;
@property (nonatomic, strong)NSString *isXianLu;

@property(nonatomic)BOOL is_Clcik;
- (void)loadView;

@end
