//
//  Setting_PageViewController.m
//  Icicle
//
//  Created by User #⑨ on 13-5-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "Setting_PageViewController.h"
#import "DataPist.h"
#import "Ip_ViewController.h"
@interface Setting_PageViewController ()

@end

@implementation Setting_PageViewController
@synthesize screenSaveAnimationLabel,screenSaveTypeLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScreenSaveAnimation" object:Nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScreenSaveType" object:Nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"IPSet" object:Nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:213/255.0 green:216/255.0 blue:221/255.0 alpha:1];

    table=[[UITableView alloc]initWithFrame:CGRectMake(40, 30, 480, 400)style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;
    table.backgroundView=Nil;
    table.backgroundColor=[UIColor clearColor];
    [self.view addSubview:table];
    [self creatUserInfo];
    NSString *ip=@"http://mg.ideer.cn";
    NSLog(@"-IpList--%@",IpList);
    if (IpList.count==0) {
         [IpList addObject:ip];
        [IpList writeToFile:[self dataFilePath] atomically:YES];
    }
    
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc]init];
    backItem.title=@"返回";
    backItem.tintColor=[UIColor blackColor];
    self.navigationItem.backBarButtonItem=backItem;
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 30)];
    label.text=@"设置";
    label.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:16];
    self.navigationItem.titleView=label;
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn  setBackgroundImage:[UIImage imageNamed:@"queren.png"] forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 0, 60, 29);
    barButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [btn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=barButton;
    
    
    NSString *version=[NSString stringWithFormat:@"%@",[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    
//    UILabel *labelText=[[UILabel alloc]initWithFrame:CGRectMake(200, 600, 50, 50)];
//    labelText.text=@"";
//    [self.view addSubview:labelText];
//    
    UILabel *labelVerSion=[[UILabel alloc]initWithFrame:CGRectMake(210, 500, 150, 50)];
    labelVerSion.text=[NSString stringWithFormat:@"版本号为：%@",version];
    labelVerSion.font=[UIFont systemFontOfSize:15];
    labelVerSion.backgroundColor=[UIColor clearColor];
    [self.view addSubview:labelVerSion];

    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:201 green:199 blue:188 alpha:1]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getScreenAnimationTime:)
                                                name:@"ScreenSaveAnimation" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getScreenTypeTime:)
                                                name:@"ScreenSaveType" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getIPSet:)
                                                name:@"IPSet" object:nil];
    
}

-(void)addIP{
     alterView=[[UIView alloc]initWithFrame:CGRectMake(120, 230,320,150)];
    alterView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tankuang.png"]];
    [self.view addSubview:alterView];
    
    textIP=[[UITextField alloc]initWithFrame:CGRectMake(15, 50, 300,50)];
    textIP.borderStyle=0;
    textIP.backgroundColor=[UIColor clearColor];
    textIP.textColor=[UIColor blackColor];
    [alterView addSubview:textIP];
    textIP.keyboardType=UIKeyboardTypeAlphabet;
    [textIP becomeFirstResponder];
    
    UIButton *btnOK=[UIButton buttonWithType:UIButtonTypeSystem];
    [btnOK  setBackgroundImage:[UIImage imageNamed:@"quxiao.png"] forState:UIControlStateNormal];
    btnOK.frame=CGRectMake(50, 100, 60, 29);
    btnOK.tag=0;
    [btnOK addTarget:self action:@selector(setIP:) forControlEvents:UIControlEventTouchUpInside];
    [alterView addSubview:btnOK];
    
    UIButton *btnCacel=[UIButton buttonWithType:UIButtonTypeSystem];
    btnCacel.tag=1;
    [btnCacel  setBackgroundImage:[UIImage imageNamed:@"queren.png"] forState:UIControlStateNormal];
    [btnCacel addTarget:self action:@selector(setIP:) forControlEvents:UIControlEventTouchUpInside];
    btnCacel.frame=CGRectMake(200, 100, 60, 29);
    [alterView addSubview:btnCacel];
    [self exChangeOut:alterView dur:0.5];
}
-(void)creatUserInfo{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        IpList=[[NSMutableArray alloc]initWithContentsOfFile:[self dataFilePath]];
        
    }else{
        NSFileManager *fileManger=[NSFileManager defaultManager];
        [fileManger createFileAtPath:[self dataFilePath] contents:Nil attributes:Nil];
        IpList=[[NSMutableArray alloc]init];
    }
}
- (NSString *)dataFilePath {
    //写入library
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSLog(@"-----%@",path);
    NSString *fileNamepath=[path stringByAppendingPathComponent:@"set.plist"];
    return fileNamepath;
}
-(void)setIP:(UIButton *)sender{
    
    [textIP resignFirstResponder];
    if (sender.tag==0) {
        
    }else if (sender.tag==1){
        if (textIP.text.length==0) {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入合法的服务器地址" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
            [alter show];
            return;
        }
        addIPText.text=textIP.text;
        [IpList addObject:addIPText.text];
        [IpList writeToFile:[self dataFilePath] atomically:YES];

    }
    [alterView removeFromSuperview];
    
}
- (void)resignKeyBoardInView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        if ([v.subviews count] > 0) {
            [self resignKeyBoardInView:v];
        }
        if ([v isKindOfClass:[UITextView class]] || [v isKindOfClass:[UITextField class]]) {
            [v resignFirstResponder];
        }
    }
}
-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
        [DataPist shared].ipString=textField.text;
    [[NSUserDefaults standardUserDefaults]setObject:textField.text forKey:@"getIP"];
}
-(void)getScreenAnimationTime:(NSNotification *)AnimationTime{
    screenSaveAnimationLabel.text=AnimationTime.object;
    [table reloadData];
    [[NSUserDefaults standardUserDefaults]setObject:screenSaveAnimationLabel.text forKey:@"AnimationTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}
-(void)getIPSet:(NSNotification *)getIP{
    addIPText.text=getIP.object;
      [table reloadData];
    [[NSUserDefaults standardUserDefaults]setObject:addIPText.text forKey:@"getIP"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)getScreenTypeTime:(NSNotification *)TypeTime{
    screenSaveTypeLabel.text=TypeTime.object;
    [table reloadData];
    [[NSUserDefaults standardUserDefaults]setObject:screenSaveTypeLabel.text forKey:@"TypeTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"---%@",screenSaveTypeLabel.text);

}
-(void)didDismissModalView{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)dismissView{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark UITableView -methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int n;
    if (section==0) {
        n=2;
    }
    
    if (section==1){
        n=1;
    }

    return n;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identy=[NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identy];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellAccessoryNone;
        
        if (indexPath.section==0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text=@"屏保动画";
                    screenSaveAnimationLabel=[[UILabel alloc]initWithFrame:CGRectMake(350, 15, 80, 20)];
                    screenSaveAnimationLabel.backgroundColor=[UIColor clearColor];
                    [cell addSubview:screenSaveAnimationLabel];
                    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"AnimationTime"]==nil) {
                        screenSaveAnimationLabel.text=@"5分钟";
                    }else{
                        screenSaveAnimationLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"AnimationTime"];
                    }
                    break;
                case 1:
                    cell.textLabel.text=@"屏保类型";
                    screenSaveTypeLabel=[[UILabel alloc]initWithFrame:CGRectMake(350, 15, 80, 20)];
                    screenSaveTypeLabel.backgroundColor=[UIColor clearColor];
                    [cell addSubview:screenSaveTypeLabel];
                    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"TypeTime"]==nil) {
                        screenSaveTypeLabel.text=@"图片";
                    }else{
                        screenSaveTypeLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"TypeTime"];
                    }
                    break;
                
                default:
                    break;
            }
        }
        if (indexPath.section==1) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

            if (indexPath.row==0) {
                cell.textLabel.text=@"服务器地址";
                addIPText=[[UILabel alloc]initWithFrame:CGRectMake(110, 8, 300, 30)];
                addIPText.tag=999;
                addIPText.backgroundColor=[UIColor whiteColor];
                [cell addSubview:addIPText];
                if ([[NSUserDefaults standardUserDefaults]objectForKey:@"getIP"]==nil) {
                    addIPText.text=[IpList objectAtIndex:0];
                }else{
                    addIPText.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"getIP"];
                }
                UIButton *addIPBtn=[UIButton buttonWithType:0];
//                [addIPBtn setBackgroundColor:[UIColor redColor]];
                [addIPBtn setImage:[UIImage imageNamed:@"add.png"] forState:0];
                addIPBtn.frame=CGRectMake(380, 10,30,30);
                addIPBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
                [addIPBtn addTarget:self action:@selector(addIP) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:addIPBtn];
            }
            
        }

          }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                ScreenSaveAnimation_ViewController *SV=[[ScreenSaveAnimation_ViewController alloc]init];
                [self.navigationController pushViewController:SV animated:YES];
            }
                break;
            case 1:{
                ScreenSaveType_ViewController *ST=[[ScreenSaveType_ViewController alloc]init];
//                ST.modalPresentationStyle=UIModalPresentationCurrentContext;
                [self.navigationController pushViewController:ST animated:YES];
                
            }break;
                
            default:
                break;
        }

    }else if (indexPath.section==1){
        Ip_ViewController *IP=[[Ip_ViewController alloc]init];
        [self creatUserInfo];
        IP.array=IpList;
        [self.navigationController pushViewController:IP animated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
      
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
