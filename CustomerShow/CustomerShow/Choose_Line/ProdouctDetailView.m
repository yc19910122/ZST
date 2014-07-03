//
//  ProdouctDetailView.m
//  CustomerShow
//
//  Created by songbai on 13-11-18.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "ProdouctDetailView.h"

@implementation ProdouctDetailView
@synthesize scroll;
@synthesize line_detailInfo,season,line_name,dic_line,is_Clcik,arryImages,isXianLu;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)getCurrentNum:(NSNotification *)nonity{
    int n=[nonity.object intValue];
    int x;
    if (n<=9) {
        x=0;
    }
    if (n>9) {
        x=n/10;
    }
    
    [scroll setContentOffset:CGPointMake(1024*x, 0) animated:NO];
    [self initImage:x];
}

-(void)initUI{
    [scroll removeFromSuperview];
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 1024, 700)];
    scroll.backgroundColor=[UIColor whiteColor];
    scroll.showsVerticalScrollIndicator=NO;
    scroll.pagingEnabled=YES;
    scroll.delegate=self;
    scroll.showsVerticalScrollIndicator = FALSE;
    scroll.showsHorizontalScrollIndicator = FALSE;
    [self addSubview:scroll];
    
    if (arryImages.count==0) {
        
        arryImages=[[NSMutableArray alloc]init];
        for (int i=0; i<line_detailInfo.count; i++) {
            NSArray *arry=[[line_detailInfo objectAtIndex:i] objectForKey:@"commodity"];
            arryImages=[arryImages arrayByAddingObjectsFromArray:arry];
        }
    }
    
    if (arryImages.count==0) {
        NSLog(@"暂无数据");
    }
    
    int i = 0;
    if ([arryImages count]%10 != 0) {
        i = [arryImages count]/10+1;
    }
    else
    {
        i = [arryImages count]/10;
    }
    
    [scroll setContentSize:CGSizeMake(1024*i, 630)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCurrentNum:) name:@"currentNum" object:Nil];
    [self initImage:0];
    
    [self ceBianLan];
    //    [self.view addSubview:zheZhaoview]
    btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(26, 630, 79,33);
    [btn setBackgroundImage:[UIImage imageNamed:@"Move_back.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self noInfo];
    if (arryImages.count==0) {
        [UIView beginAnimations:NULL context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:1];
        [TanChuView setHidden:NO];
        [TanChuView setAlpha:1];
        [UIView setAnimationDidStopSelector:@selector(cancleView)];
        [UIView commitAnimations];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"currentNum" object:Nil];
}
-(void)goBack{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeDetailView" object:Nil];

}
- (void)loadView
{
    self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    //    [self initFrameTitle];
    //80  140
    
    [self initUI];
    //    [self ceBianLan];
//    UIButton *btnBack=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btnBack.frame=CGRectMake(26, 720, 79,33);
//    [btnBack setBackgroundImage:[UIImage imageNamed:@"Move_back.png"] forState:UIControlStateNormal];
//    [btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btnBack];
    
    
    
    
    
	// Do any additional setup after loading the view.
}
-(void)noInfo{
    [TanChuView removeFromSuperview];
    TanChuView=[[UIView alloc]initWithFrame:CGRectMake(517-100, 300, 200, 100)];
    TanChuView.backgroundColor=[UIColor colorWithRed:236 green:233 blue:228 alpha:1];
    TanChuView.alpha=0;
    TanChuView.layer.cornerRadius = 6;
    TanChuView.layer.masksToBounds = YES;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, 150, 30)];
    label.text=@"未搜索到结果";
    label.backgroundColor=[UIColor clearColor];
    [TanChuView addSubview:label];
    [TanChuView setHidden:YES];
    [self addSubview:TanChuView];
//    [self bringSubviewToFront:TanChuView];
}
-(void)initImage:(int)number
{
    int num = arryImages.count - number*10;
    //num11 判断行数
    int num11 = 0;
    //num22 判断列数
    int num22 = 0;
    
    if (num > 5) {
        num11 = 2;
    }else if(num <= 5 ){
        num11 = 1;
    }
    for (int M=0; M < num11; M++) {
        if (num >= 5) {
            num22 = 5;
        }else if(num < 5){
            num22 = num%5;
        }
        for (int i=0; i < num22; i++) {
            UIButton *btns = [UIButton buttonWithType:0];
            NSDictionary *str;
            if (M == 0) {
                str  = [arryImages objectAtIndex:i+number*10];
            }else if (M == 1){
                str  = [arryImages objectAtIndex:i+number*10+5];
                NSLog(@"-strstrstrstrstr---%@",str);
            }
            NSString *imgPaths = [NSString stringWithFormat:@"s_%@",[str objectForKey:@"img"]];
            [btns setImage:[UIImage imageWithContentsOfFile:[DataPist getFilePath:imgPaths]] forState:UIControlStateNormal];
            NSLog(@"--imgPaths--%@",[DataPist getFilePath:imgPaths]);
            if (M == 0) {
                btns.tag = i+number*10+100;
            }else if (M == 1){
                btns.tag = i+number*10+5+100;
            }
            [btns addTarget:self action:@selector(goNext:) forControlEvents:UIControlEventTouchUpInside];
            btns.frame = CGRectMake(1024*number+40+i*150+i*45,M*230+41*M+70, 160,214);
            [scroll addSubview:btns];
        }
        num = num - 5;
    }
    
}


-(void)goNext:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"weixinView" object:Nil];

    [DataPist showLoading];
    
//    NSDictionary  *image_info=[arryImages objectAtIndex:sender.tag-100];
//    NSString *stringname=[NSString stringWithFormat:@"l_%@",[[arryImages objectAtIndex:sender.tag-100] objectForKey:@"img"]];
//    NSArray *arry=arryImages;
    int current=sender.tag-100;
    NSString *stringNum=[NSString stringWithFormat:@"%d",current];
//    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"arrImage",arryImages,nil];
//    int *cuttent=sender.tag-100;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"infoIMage" object:stringNum userInfo:(NSDictionary *)arryImages];
    
//    prdouct_ImagePageViewController *pro=[[prdouct_ImagePageViewController alloc]init];
//    pro.image_info=[arryImages objectAtIndex:sender.tag-100];
//    pro.image_Name=[NSString stringWithFormat:@"l_%@",[[arryImages objectAtIndex:sender.tag-100] objectForKey:@"img"]];
//    pro.imageArrys=arryImages;
//    pro.currentNum=sender.tag-100;
    [DataPist hideLoading];
//    [self presentViewController:pro animated:YES completion:NULL];
}

-(void)ceBianLan{
    yet = YES;
    [view removeFromSuperview];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(1024-29 ,  -70, 152, 768)];
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"chehua.png"]]] ;
    [self addSubview:view];
    
	tbView = [[UITableView alloc] initWithFrame:CGRectMake(10+30, 70, 152, 748-70) style:UITableViewStylePlain];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tbView.delegate = self;
	tbView.dataSource = self;
    tbView.backgroundColor=[UIColor clearColor];
	[view addSubview:tbView];
    
    
    //    NSString *str = [[NSBundle mainBundle]pathForResource:@"Typeselection" ofType:@"plist"];
    //    data = [[NSMutableArray alloc]initWithContentsOfFile:str];
    
    NSString *path=[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:0]];
    data = [DataPist readPlist:path];
    //    NSLog(@"%@",data);
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 352,40, 40)];
    [btn addTarget:self action:@selector(OpenCe) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    //移动的手势
    
    UISwipeGestureRecognizer  *panRcognizeAGgain=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnTandleSwipeFrom:)];
    panRcognizeAGgain.delegate=self;
    [panRcognizeAGgain setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [view addGestureRecognizer:panRcognizeAGgain];
    
    
    [zheZhaoview removeFromSuperview];
    zheZhaoview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024-152, 768)];
    zheZhaoview.backgroundColor=[UIColor clearColor];
    zheZhaoview.hidden=YES;
    [self addSubview:zheZhaoview];
    
    
    //    UIImageView *clundyImageleft=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 280, 225, 225)];
    //    clundyImageleft.image=[UIImage imageNamed:@"z-yunduo.png"];
    //    [self.view addSubview:clundyImageleft];
    //
    //    UIImageView *clundyImageRight=[[UIImageView alloc]initWithFrame:CGRectMake(824, 280, 225, 225)];
    //    clundyImageRight.image=[UIImage imageNamed:@"y-yunduo.png"];
    //    [self.view addSubview:clundyImageRight];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    m=scrollView.contentOffset.x/1024;
    //    [self initImage:m];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int  n=scrollView.contentOffset.x/1024;
    if (n >= scor) {
        scor = n;
        [self initImage:n];
        [DataPist hideLoading];
    }
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    int  n=scrollView.contentOffset.x/1024;
    if (n >= scor) {
        [DataPist showLoading];
    }
    
}

- (void)btnTandleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    
    if (recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [view setFrame:CGRectMake(1024-152,  -70, 152, 768)];
            [scroll setContentOffset:CGPointMake(80+1024*m, 0) animated:NO];
            recognizer.direction=UISwipeGestureRecognizerDirectionRight;
            zheZhaoview.hidden=NO;
        } completion:nil];
    }else if (recognizer.direction==UISwipeGestureRecognizerDirectionRight){
        [UIView animateWithDuration:0.5 delay:0. options:UIViewAnimationOptionCurveEaseOut animations:^{
            [view setFrame:CGRectMake(1024-29,  -70, 152, 768)];
            [scroll setContentOffset:CGPointMake(0+1024*m, 0) animated:NO];
            recognizer.direction=UISwipeGestureRecognizerDirectionLeft;
            zheZhaoview.hidden=YES;
            
        } completion:nil];
    }
    yet = !yet;
    
}


- (void)OpenCe
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"weixinView" object:Nil];

    [UIView beginAnimations:NULL context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.6];
    if (yet) {
        [view setFrame:CGRectMake(1024-152,  -70, 152, 768)];
        [scroll setContentOffset:CGPointMake(80+1024*m, 0) animated:NO];
        zheZhaoview.hidden=NO;
    }else
    {
        [view setFrame:CGRectMake(1024-29,  -70, 158, 768)];
        [scroll setContentOffset:CGPointMake(0+1024*m, 0) animated:NO];
        zheZhaoview.hidden=YES;
    }
    yet = !yet;
    
    [UIView commitAnimations];
    
    //    UISwipeGestureRecognizer  *panRcognizeAGgain=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnTandleSwipeFrom:)];
    //    panRcognizeAGgain.delegate=self;
    //    [panRcognizeAGgain setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    //    [view addGestureRecognizer:panRcognizeAGgain];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView beginAnimations:NULL context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.6];
    zheZhaoview.hidden=YES;
    [view setFrame:CGRectMake(1024-29, -70, 152, 768)];
    [scroll setContentOffset:CGPointMake(0+1024*m, 0) animated:NO];
    [UIView commitAnimations];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stopClick" object:@"otherView"];
    yet = !yet;
}

#pragma mark -
#pragma mark Table view data source


//对指定的节进行“展开/折叠”操作
-(void)collapseOrExpand:(int)section{
	Boolean expanded = NO;
	//Boolean searched = NO;
	NSMutableDictionary* d=[data objectAtIndex:section];
	
	//若本节model中的“expanded”属性不为空，则取出来
	if([d objectForKey:@"expanded"]!=nil)
		expanded=[[d objectForKey:@"expanded"]intValue];
	
	//若原来是折叠的则展开，若原来是展开的则折叠
	[d setObject:[NSNumber numberWithBool:!expanded] forKey:@"expanded"];
    
}


//返回指定节的“expanded”值
-(Boolean)isExpanded:(int)section{
	Boolean expanded = NO;
	NSMutableDictionary* d=[data objectAtIndex:section];
	
	//若本节model中的“expanded”属性不为空，则取出来
	if([d objectForKey:@"expanded"]!=nil)
		expanded=[[d objectForKey:@"expanded"]intValue];
	
	return expanded;
}


//按钮被点击时触发
-(void)expandButtonClicked:(id)sender{
	
	UIButton* btns= (UIButton*)sender;
	int section= btns.tag; //取得tag知道点击对应哪个块
	
	//	NSLog(@"click %d", section);
	[self collapseOrExpand:section];
	
	//刷新tableview
	[tbView reloadData];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return [data count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	
	//对指定节进行“展开”判断
	if (![self isExpanded:section]) {
		
		//若本节是“折叠”的，其行数返回为0
		return 0;
	}
	
	NSDictionary* d=[data objectAtIndex:section];
	return [[d objectForKey:@"list"] count];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSDictionary* mm= (NSDictionary*)[data objectAtIndex: indexPath.section];
        NSArray *d = (NSArray*)[mm objectForKey:@"list"];
        
        if (d == nil) {
            return cell;
        }
        
        //显示联系人名称
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 100, 20)];
        label.font=[UIFont systemFontOfSize:14];
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor grayColor];
        
        label.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:13];
        label.font=[UIFont systemFontOfSize:14];
        [cell addSubview:label];
        label.text = [d objectAtIndex: indexPath.row];
    }
    
    
    //	cell.textLabel.backgroundColor = [UIColor clearColor];
	
	//UIColor *newColor = [[UIColor alloc] initWithRed:(float) green:(float) blue:(float) alpha:(float)];
    //	cell.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_listbg.png"]];
    //	cell.imageView.image = [UIImage imageNamed:@"mod_user.png"];
    
	
	//选中行时灰色
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    //	[cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    
    
    switch (indexPath.section) {
        case 0:{
            
            switch (indexPath.row) {
                case 0:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+500;
                    [cell addSubview:image];
                }break;
                case 1:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+500;
                    [cell addSubview:image];
                }break;
                case 2:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+500;
                    [cell addSubview:image];
                }break;
                case 3:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+500;
                    [cell addSubview:image];
                }break;
                case 4:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+500;
                    [cell addSubview:image];
                }break;
                case 5:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+500;
                    [cell addSubview:image];
                }break;
                case 6:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+500;
                    [cell addSubview:image];
                }break;
                case 7:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+500;
                    [cell addSubview:image];
                }break;
                case 8:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+500;
                    [cell addSubview:image];
                }break;
                default:
                    break;
            }
        }break;
            
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+510;
                    [cell addSubview:image];
                }
                    
                    break;
                case 1:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+510;
                    [cell addSubview:image];
                }
                    break;
                case 2:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+510;
                    [cell addSubview:image];
                }
                    break;
                case 3:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+510;
                    [cell addSubview:image];
                }
                    break;
                case 4:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+510;
                    [cell addSubview:image];
                }
                    break;
                case 5:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+510;
                    [cell addSubview:image];
                }
                    break;
                case 6:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+510;
                    [cell addSubview:image];
                }
                    break;
                case 7:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+510;
                    [cell addSubview:image];
                }
                    break;
                case 8:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,11, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+510;
                    [cell addSubview:image];
                }
                    break;
            }
        } break;
            
            
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+520;
                    [cell addSubview:image];
                }
                    //
                    break;
                case 1:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+520;
                    [cell addSubview:image];
                    
                }
                    
                    break;
                case 2:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+520;
                    [cell addSubview:image];
                    
                }
                    
                    break;
                case 3:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+520;
                    [cell addSubview:image];
                    
                }
                    
                    break;
                case 4:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+520;
                    [cell addSubview:image];
                    
                }
                    
                    break;
                case 5:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+520;
                    [cell addSubview:image];
                    
                }
                    
                    break;
                case 6:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+520;
                    [cell addSubview:image];
                    
                }
                    
                    break;
                    
            }
        }break;
            
        case 3:{
            switch (indexPath.row) {
                case 0:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+530;
                    [cell addSubview:image];
                    
                }
                    break;
                case 1:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+530;
                    [cell addSubview:image];
                    
                    
                }break;
                case 2:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+530;
                    [cell addSubview:image];
                    
                    
                }
                    break;
                case 3:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+530;
                    [cell addSubview:image];
                    
                    //
                }
                    break;
                case 4:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+530;
                    [cell addSubview:image];
                    
                    
                }
                    break;
                case 5:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+530;
                    [cell addSubview:image];
                    
                }    break;
                case 6:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+530;
                    [cell addSubview:image];
                    
                }    break;
                default:
                    break;
            }
        }break;
            
        case 4:{
            switch (indexPath.row) {
                case 0:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+540;
                    [cell addSubview:image];
                }
                    break;
                case 1:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+540;
                    [cell addSubview:image];
                }
                    break;
                case 2:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+540;
                    [cell addSubview:image];
                }
                    break;
                case 3:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+540;
                    [cell addSubview:image];
                }
                    break;
                case 4:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+540;
                    [cell addSubview:image];
                }
                    break;
                case 5:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+540;
                    [cell addSubview:image];
                }
                    break;
                case 6:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+540;
                    [cell addSubview:image];
                }
                    break;
                default:
                    break;
            }
        }break;
            
        case 5:{
            switch (indexPath.row) {
                case 0:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+550;
                    [cell addSubview:image];
                }
                    break;
                case 1:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+550;
                    [cell addSubview:image];
                }
                    break;
                case 2:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+550;
                    [cell addSubview:image];
                }
                    break;
                case 3:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+550;
                    [cell addSubview:image];
                }
                    break;
                case 4:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+550;
                    [cell addSubview:image];
                }
                    break;
                case 5:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+550;
                    [cell addSubview:image];
                }
                    break;
                    
                default:
                    break;
            }
        }break;
            
        case 6:{
            switch (indexPath.row) {
                case 0:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+560;
                    [cell addSubview:image];
                }
                    break;
                case 1:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+560;
                    [cell addSubview:image];
                }
                    break;
                case 2:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+560;
                    [cell addSubview:image];
                }
                    break;
                case 3:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+560;
                    [cell addSubview:image];
                }
                    break;
                case 4:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+560;
                    [cell addSubview:image];
                }
                    break;
                case 5:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+560;
                    [cell addSubview:image];
                }
                    break;
                case 6:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+560;
                    [cell addSubview:image];
                }
                    break;
                default:
                    break;
            }
        }break;
            
            
        case 7:{
            switch (indexPath.row) {
                case 0:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+570;
                    [cell addSubview:image];
                }
                    break;
                case 1:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+570;
                    [cell addSubview:image];
                }
                    break;
                case 2:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+570;
                    [cell addSubview:image];
                }
                    break;
                case 3:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+570;
                    [cell addSubview:image];
                }
                    break;
                case 4:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+570;
                    [cell addSubview:image];
                }
                    break;
                case 5:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+570;
                    [cell addSubview:image];
                }
                    break;
                default:
                    break;
            }
        }break;
            
            
        case 8:{
            switch (indexPath.row) {
                case 0:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+580;
                    [cell addSubview:image];
                }
                    break;
                case 1:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+580;
                    [cell addSubview:image];
                }
                    break;
                case 2:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+580;
                    [cell addSubview:image];
                }
                    break;
                case 3:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+580;
                    [cell addSubview:image];
                }
                    break;
                case 4:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+580;
                    [cell addSubview:image];
                }
                    break;
                case 5:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+580;
                    [cell addSubview:image];
                }
                    break;
                case 6:{
                    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(18,12, 5, 5)];
                    image.image=[UIImage imageNamed:@"xuanzhong.png"];
                    image.hidden=YES;
                    image.tag=indexPath.row+580;
                    [cell addSubview:image];
                }
                    break;
                default:
                    break;
            }
        }break;
            
            
            
        default:
            break;
    }

    
    //	}
    return cell;
}

// 设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
	return 50;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
	
    
	UIView *hView;
	if (UIInterfaceOrientationLandscapeRight == [[UIDevice currentDevice] orientation] ||
        UIInterfaceOrientationLandscapeLeft == [[UIDevice currentDevice] orientation])
	{
		hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 40)];
	}
	else
	{
		hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        //self.tableView.tableHeaderView.frame = CGRectMake(0.f, 0.f, 320.f, 44.f);
	}
    //UIView *hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    
	UIButton* eButton = [[UIButton alloc] init];
    
	//按钮填充整个视图
	eButton.frame = hView.frame;
	[eButton addTarget:self action:@selector(expandButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
	eButton.tag = section;//把节号保存到按钮tag，以便传递到expandButtonClicked方法
    
	//根据是否展开，切换按钮显示图片
	if ([self isExpanded:section])
		[eButton setImage: [ UIImage imageNamed: @"dakai.png" ] forState:UIControlStateNormal];
	else
		[eButton setImage: [ UIImage imageNamed: @"weidakai.png" ] forState:UIControlStateNormal];
    
    
	//由于按钮的标题，
	//4个参数是上边界，左边界，下边界，右边界。
	eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[eButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 0)];
	[eButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    
    
	//设置按钮显示颜色
    //	eButton.backgroundColor = [UIColor lightGrayColor];
    eButton.titleLabel.font=  [UIFont fontWithName:@"FZLTHJW--GB1-0" size:14];
    eButton.titleLabel.textColor=[UIColor colorWithRed:35 green:24 blue:21 alpha:1];
    
	[eButton setTitle:[[data objectAtIndex:section] objectForKey:@"title"] forState:UIControlStateNormal];
	[eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	
    //	[eButton setBackgroundImage: [ UIImage imageNamed: @"btn_listbg.png" ] forState:UIControlStateNormal];//btn_line.png"
	//[eButton setTitleShadowColor:[UIColor colorWithWhite:0.1 alpha:1] forState:UIControlStateNormal];
	//[eButton.titleLabel setShadowOffset:CGSizeMake(1, 1)];
    hView.BackgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"z.png"] ];
	[hView addSubview: eButton];
    
	return hView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"---%d",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [DataPist showLoading];
    [self nextTag:indexPath];
    
    [tableView reloadData];
    
    int n=[indexPath indexAtPosition:0];
    int number_code = indexPath.row;
    code = [[[data objectAtIndex:n] objectForKey:@"code"] objectAtIndex:number_code];
    
    [self performSelector:@selector(setectinfos) withObject:nil afterDelay:0];
}

-(void)setectinfos{
    
    NSArray *arryAll=[[NSArray alloc]init];
    NSDictionary *dicInfo=[[NSDictionary alloc]init];
    if (isXianLu==Nil) {
        if ([season isEqualToString:@"left"])
        {
            dicInfo=[[DataPist shared].plistInfo objectAtIndex:0];
        }else if ([season isEqualToString:@"right"])
        {
            dicInfo=[[DataPist shared].plistInfo objectAtIndex:1];
        }
        NSArray *arryLines=[dicInfo objectForKey:@"lines"];
        for (int i=0; i<[arryLines count]; i++)
        {
            NSDictionary *dic_One=[arryLines objectAtIndex:i];
            NSArray *arry_One=[dic_One objectForKey:@"classify"];
            for (int j=0; j<[arry_One count]; j++)
            {
                NSDictionary *dic_Two=[arry_One objectAtIndex:i];
                NSString *idString=[dic_Two objectForKey:@"id"];
                if ([idString isEqualToString:code])
                {
                    NSArray *arry_Two=[dic_Two objectForKey:@"commodity"];
                    arryAll=[arryAll arrayByAddingObjectsFromArray:arry_Two];
                }
            }
        }
    }else
    {
        NSArray *arry_One=line_detailInfo;
        for (int j=0; j<[arry_One count]; j++)
        {
            NSDictionary *dic_Two=[arry_One objectAtIndex:j];
            NSString *idString=[dic_Two objectForKey:@"id"];
            if ([idString isEqualToString:code])
            {
                NSArray *arry_Two=[dic_Two objectForKey:@"commodity"];
                arryAll=[arryAll arrayByAddingObjectsFromArray:arry_Two];
            }
        }
    }
    if (arryAll.count==0) {
        [UIView beginAnimations:NULL context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:1];
        [TanChuView setHidden:NO];
        [TanChuView setAlpha:1];
        [UIView setAnimationDidStopSelector:@selector(cancleView)];
        [UIView commitAnimations];
        
        [DataPist hideLoading];
        return;
    }
    arryImages=arryAll;
    [self initUI];
    [DataPist hideLoading];
}
-(void)cancleView{
    timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(noHide) userInfo:nil repeats:NO];
}
-(void)noHide{
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:1];
    [TanChuView setAlpha:0];
    [UIView setAnimationDidStopSelector:@selector(hideView)];
    [UIView commitAnimations];
    [timer invalidate];
    timer=nil;
    
}
-(void)hideView{
    [TanChuView setHidden:YES];
}


-(void)nextTag:(NSIndexPath *)indexPath{
    
    UIImageView *image;
    
    int n=[indexPath indexAtPosition:0];
    if (n==0) {
        for (int i=500; i<590; i++) {
            image=(UIImageView *)[self viewWithTag:i];
            [image setHidden:YES];
        }
        image=(UIImageView *)[self viewWithTag:indexPath.row+500];
        image.hidden=NO;
        
    }else if (n==1){
        
        for (int i=500; i<590; i++) {
            image=(UIImageView *)[self viewWithTag:i];
            [image setHidden:YES];
        }
        image=(UIImageView *)[self viewWithTag:indexPath.row+510];
        image.hidden=NO;
        
    }else if (n==2){
        
        for (int i=500; i<590; i++) {
            image=(UIImageView *)[self viewWithTag:i];
            [image setHidden:YES];
        }
        image=(UIImageView *)[self viewWithTag:indexPath.row+520];
        image.hidden=NO;
        
    }else if (n==3){
        
        for (int i=500; i<590; i++) {
            image=(UIImageView *)[self viewWithTag:i];
            [image setHidden:YES];
        }
        
        image=(UIImageView *)[self viewWithTag:indexPath.row+530];
        image.hidden=NO;
    }else if (n==4){
        
        for (int i=500; i<590; i++) {
            image=(UIImageView *)[self viewWithTag:i];
            [image setHidden:YES];
        }
        
        image=(UIImageView *)[self viewWithTag:indexPath.row+540];
        image.hidden=NO;
    }else if (n==5){
        
        for (int i=500; i<590; i++) {
            image=(UIImageView *)[self viewWithTag:i];
            [image setHidden:YES];
        }
        
        image=(UIImageView *)[self viewWithTag:indexPath.row+550];
        image.hidden=NO;
    }else if (n==6){
        
        for (int i=500; i<590; i++) {
            image=(UIImageView *)[self viewWithTag:i];
            [image setHidden:YES];
        }
        
        image=(UIImageView *)[self viewWithTag:indexPath.row+560];
        image.hidden=NO;
    }else if (n==7){
        
        for (int i=500; i<590; i++) {
            image=(UIImageView *)[self viewWithTag:i];
            [image setHidden:YES];
        }
        
        image=(UIImageView *)[self viewWithTag:indexPath.row+570];
        image.hidden=NO;
    }else if (n==8){
        
        for (int i=500; i<590; i++) {
            image=(UIImageView *)[self viewWithTag:i];
            [image setHidden:YES];
        }
        
        image=(UIImageView *)[self viewWithTag:indexPath.row+580];
        image.hidden=NO;
    }
    
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
