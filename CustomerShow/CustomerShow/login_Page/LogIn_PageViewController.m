//
//  ViewController.m
//  Icicle
//
//  Created by User #⑨ on 13-5-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "LogIn_PageViewController.h"
#import "Setting_PageViewController.h"
#import "Choose_LineViewController.h"
#import "ASIHTTPRequest.h"
#import "PingBao_PageViewController.h"
#import "AppDelegate.h"
#import "Main_ViewController.h"
#import "SecurityUtil.h"
//#define MUSICFile [DocumentsDirectory stringByAppendingPathComponent:@"img.zip"]
@interface LogIn_PageViewController ()

@end

@implementation LogIn_PageViewController
@synthesize password,username,login,setting,saveBtn;
@synthesize progressLabel,progressView;
@synthesize arr,zip_name,networkQueue;


-(void)getVersion{
    //判断是否有新数据要更新
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/Public/getAppinfo",[DataPist shared].ipString]];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    NSError *error;
    NSURLResponse *urlResponce=nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponce error:&error];
    if (error){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法连接网络，请连接网络稍后再登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
        [alert show];
        return;
    }
    dicVersion = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSString *version=[NSString stringWithFormat:@"%@",[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    int verlocal=[version intValue];
    NSString *severVersion=[dicVersion  objectForKey:@"version"];
    int verServer=[severVersion intValue];
    //判断版本号是否更新
    if (verlocal<verServer)
    {
        //登陆[MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[dicVersion objectForKey:@"force"]isEqualToString:@"1"]) {
//            NSString *aa=[dicVersion objectForKey:@"content"];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[dicVersion objectForKey:@"content"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
            [alert show];
            alert.tag=3;
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[dicVersion objectForKey:@"content"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];
            alert.tag=2;
        }
        
    }else{
        
        
    }
}

- (void)viewDidLoad
{
    //218 120
    [super viewDidLoad];
    munberImage=0;
    isDown=@"0";
    update_flg=@"0";
    IsFail=NO;
    isSetLastDate=NO;
    connectNum=0;
   NSString *Ip=[[NSUserDefaults standardUserDefaults]objectForKey:@"getIP"];
    if (Ip==nil) {
        [DataPist shared].ipString=@"http://mg.ideer.cn";
    }else{
        [DataPist shared].ipString=Ip;
    }
    [self performSelector:@selector(getVersion) withObject:Nil afterDelay:2];//判断版本
    ret=NO;
    Flag = YES;
    Keys=[[NSArray alloc]initWithObjects:@"ClassifyTree",@"ClippingInfo",@"CommodityTree",@"CompanyInfo",@"NewsInfo",@"VideoInfo",@"customerUiname",@"ScreensaversInfo",@"FashionSuggestionInfo",@"InterestInfo",@"StoreInfo",nil];
    [DataPist shared].plistKeys=Keys;
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    scroll.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"quantu.png"]];
    scroll.userInteractionEnabled=YES;
    scroll.delegate=self;
    [scroll setCanCancelContentTouches:YES];
    [scroll setDelaysContentTouches:YES];
    [self.view addSubview:scroll];
    imageLogo=[[UIImageView alloc]initWithFrame:CGRectMake(410, 130, 218 ,120)];
    [scroll addSubview:imageLogo];

    NSString *logo=[DataPist getFilePath:@"logo.png"];
    imageLogo.image=[UIImage imageWithContentsOfFile:logo];
    
    if (Iphone>=7.0) {
        username = [[UITextField alloc]initWithFrame:CGRectMake(415, 275, 192, 50)];
        password = [[UITextField alloc]initWithFrame:CGRectMake(415, 323, 192, 50)];
        NSLog(@"----%f",Iphone);
    }else{
        username = [[UITextField alloc]initWithFrame:CGRectMake(415, 287, 192, 50)];
        password = [[UITextField alloc]initWithFrame:CGRectMake(415, 335, 192, 50)];
        
    }
    
    
    username.borderStyle = UITextBorderStyleNone;
    username.delegate=self;
    username.tag=998;
    username.autocapitalizationType=NO;
    username.keyboardType=UIKeyboardTypeDefault;
    username.placeholder = @"用户名";
    [scroll addSubview:username];

    password.borderStyle = UITextBorderStyleNone;
    password.delegate=self;
    password.tag=999;
    username.autocapitalizationType=NO;
    password.keyboardType=UIKeyboardTypeDefault;
    password.secureTextEntry = YES;
    password.placeholder = @"密码";
    [scroll addSubview:password];
    
    saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame=CGRectMake(335, 932/2, 102, 37);
    saveBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bcsz.png"]];
    saveBtn.tag=999;
    [saveBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:saveBtn];
    BOOL flat;
    flat=  [[NSUserDefaults standardUserDefaults]boolForKey:@"ret"];
    if (flat) {
        NSString *usernameString=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
        username.text=usernameString;
        saveBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"djh-bcsz.png"]];
    }

    login = [UIButton buttonWithType:UIButtonTypeSystem];
    [login setBackgroundImage:[UIImage imageNamed:@"denglu.png"]  forState:UIControlStateNormal];
    [login setFrame:CGRectMake(341, 396, 342, 46)];
    [login addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:login];

    setting = [UIButton buttonWithType:0];
    [setting setImage:[UIImage imageNamed:@"shezi.png"] forState:UIControlStateNormal];
    [setting setFrame:CGRectMake(632, 476, 51, 18)];
    [setting setTitle:@"设置" forState:UIControlStateNormal];
    [setting addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:setting];
        
    UITapGestureRecognizer *tapRecognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [scroll addGestureRecognizer:tapRecognizer];
    
    progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar] ;
    progressView.frame = CGRectMake(341, 550, 342, 20);
    [scroll addSubview:progressView];
    progressView.hidden=YES;
    
    progressLabel=[[UILabel alloc]init];
	progressLabel.frame=CGRectMake(670, 540, 100, 20);
    [progressLabel setTextColor:[UIColor blackColor]];
    progressLabel.backgroundColor=[UIColor clearColor];
    progressLabel.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:7];
    progressLabel.font=[UIFont systemFontOfSize:12];
    progressLabel.textAlignment=NSTextAlignmentCenter;
}
//是否保存密码的方法
-(void)changeBtn:(UIButton *)sender{
    if (saveBtn.tag==999) {
        saveBtn.backgroundColor=Nil;
        ret=YES;
        [[NSUserDefaults standardUserDefaults]setBool:ret forKey:@"ret"];
        [[NSUserDefaults standardUserDefaults]setValue:username.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        saveBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"djh-bcsz.png"]];
        saveBtn.tag=998;
    }else if (saveBtn.tag==998){
        saveBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bcsz.png"]];
        ret=NO;
        [[NSUserDefaults standardUserDefaults]setBool:ret forKey:@"ret"];
        [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"username"];
        [[NSUserDefaults standardUserDefaults]synchronize];
         saveBtn.tag=999;
    }
}

#pragma mark -UITextField -method
-(void)textFieldDidBeginEditing:(UITextField *)textField{
        [scroll setContentOffset:CGPointMake(scroll.contentOffset.x, 130) animated:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [scroll setContentOffset:CGPointMake(scroll.contentOffset.x, 0) animated:YES];
    BOOL flat;
    flat=  [[NSUserDefaults standardUserDefaults]boolForKey:@"ret"];
    if (flat) {
        [[NSUserDefaults standardUserDefaults]setBool:flat forKey:@"ret"];
        [[NSUserDefaults standardUserDefaults]setValue:username.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag==998) {
    [password becomeFirstResponder];
    }
    if (textField.tag==999) {
        [password resignFirstResponder];
        [self performSelector:@selector(login:) withObject:Nil afterDelay:0];
    }
    
    
    return  YES;
}
//手势点击事件
- (void)tapAction:(UITapGestureRecognizer*)sender{
    [username resignFirstResponder];
    [password resignFirstResponder];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stopClick" object:@"loginInfo"];

}
-(void)jianpan{
    [username resignFirstResponder];
    [password resignFirstResponder];
}
//登录接口
-(void)setLastDate:(NSNotification *)nocity{
    lastupdate=Nil;
    isSetLastDate=YES;
}
- (void)login:(id)sender
{
    [username resignFirstResponder];
    [password resignFirstResponder];
        if (username.text.length == 0) {
            username.text = @"用户名不能为空";
            username.text = Nil;
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            return;
        }
    if (password.text.length == 0) {
        password.text = @"密码不能为空";
        password.text = Nil;
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
        }
    [self waiting];
    Flag=YES;
    IsFail=NO;
    [self creatUserInfo];
    [self performSelector:@selector(getInfo) withObject:self afterDelay:0.5];

  }
//创建当前日期
-(NSString *)creatDate{
    NSDate *dateNow=[NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    format.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    format.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSString *dateString=[format stringFromDate:dateNow];
    return dateString;
}

//创建用户信息的plist
-(void)creatUserInfo{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        dicUserInfo=[[NSMutableDictionary alloc]initWithContentsOfFile:[self dataFilePath]];
        
    }else{
        NSFileManager *fileManger=[NSFileManager defaultManager];
        [fileManger createFileAtPath:[self dataFilePath] contents:Nil attributes:Nil];
        dicUserInfo=[[NSMutableDictionary alloc]init];
    }
}
-(void)loading{
    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
}

-(void)getInfo{
     [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        if (isSetLastDate==YES) {
            NSLog(@"---------------%d",isSetLastDate);
            lastupdate=Nil;
        }else{
            lastupdate=[[dicUserInfo objectForKey:username.text] objectForKey:@"lastDate"];
        }
        //post发送数据
        NSString *post;
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/Login/login/",[DataPist shared].ipString]];
        if (lastupdate==Nil) {
            post=[NSString stringWithFormat:@"username=%@&password=%@&lastupdate=",username.text,password.text];
        }else{
            post=[NSString stringWithFormat:@"username=%@&password=%@&lastupdate=%@",username.text,password.text,lastupdate];
        }
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        NSURLResponse *urlResponce=nil;
        NSError *error=nil;
        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponce error:&error];
        if (error)
        {

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (connectNum==10||connectNum==0) {
            if ([[dicUserInfo objectForKey:username.text]objectForKey:@"username"]==Nil)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法连接网络，请连接网络稍后再登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
                [alert show];
            }else
            {
                if ([[[dicUserInfo objectForKey:username.text]objectForKey:@"username"]isEqualToString:username.text]&&[[SecurityUtil decryptAESData:[[dicUserInfo objectForKey:username.text]objectForKey:@"password"]]    isEqualToString:password.text]) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有网络，无法获取更新,将进入离线浏览" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
                    [alert show];
                    alert.tag=1;
            }else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
                    [alert show];
                }
            }
                connectNum=0;
            }
            
            return;
        }
        weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *flag = [NSString stringWithFormat:@"%@",[weatherDic objectForKey:@"status"]];
        //登陆判断
        if ([flag isEqualToString:@"1"])
        {
            NSString *severDateString=[weatherDic objectForKey:@"datetime"];
            NSDateFormatter *formter=[[NSDateFormatter alloc]init];
            [formter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *SeverDate=[formter dateFromString:severDateString];
            NSTimeInterval late=[SeverDate timeIntervalSince1970]*1;
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now=[dat timeIntervalSince1970]*1;
            NSTimeInterval cha=now-late;
            if(cha/80000>=1)//登陆时间和系统时间判断
            {
                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"ipad当前时间和系统时间不相符，请调整后再登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                return;
            }else{
                //判断是否有新数据要更新
//                NSString *version=[NSString stringWithFormat:@"%@",[[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
//                int verlocal=[version intValue];
//                NSString *severVersion=[[weatherDic objectForKey:@"appInfo"] objectForKey:@"version"];
//                int verServer=[severVersion intValue];
//                //判断版本号是否更新
//                if (verlocal<=verServer)
//                {
                    [self updateInfo];//更新信息
//                }else{
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                
//                    if ([[[weatherDic objectForKey:@"appInfo"]objectForKey:@"force"]isEqualToString:@"1"]) {
//                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[[weatherDic objectForKey:@"appInfo"]objectForKey:@"content"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
//                        [alert show];
//                        alert.tag=3;
//                    }else{
//                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[[weatherDic objectForKey:@"appInfo"]objectForKey:@"content"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//                        [alert show];
//                        alert.tag=2;
//                    }
//                }
            }
        }
        else
        {
            NSString *msg = [NSString stringWithFormat:@"%@",[weatherDic objectForKey:@"info"]];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
            [alert show];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            return;
        }
    
}
-(void)updateInfo{
    NSDictionary  *update=[weatherDic objectForKey:@"update"];
    NSLog(@"----%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"succeed"]);//判断网络断开后，重新连接图片全部下载是否成功，成功
    if (update.count==0  && [[[NSUserDefaults standardUserDefaults] objectForKey:@"succeed"] isEqualToString:@"1"])
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [DataPist shared].plistInfo=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",username.text,[[DataPist shared].plistKeys objectAtIndex:2]]];
        [DataPist shared].username=username.text;
        Main_ViewController *choose_Line = [[Main_ViewController alloc]init];
        [self presentViewController:choose_Line animated:YES completion:Nil];
    }
    else
    {   //判断断网重新连接后，服务器端显示更新，客户端判断图片是否下载完成
        NSArray *tempArry=[weatherDic objectForKey:@"image"];
        if (tempArry.count==0) {
            ImageInfoArrys=[DataPist readPlist:@"images.plist"];
            
        }else{
            ImageInfoArrys=[weatherDic objectForKey:@"image"];
            NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
//            NSLog(@"-----%@",path);
            NSString *fileNamepath=[path stringByAppendingPathComponent:@"images.plist"];
            [ImageInfoArrys writeToFile:fileNamepath atomically:YES];//当下载的时候有更新的话把数据写到images。plist，后面断网后使用
            
            
        }
        
        NSDictionary *tempDic=[weatherDic objectForKey:@"update"];
        if (tempDic.count==0) {
            NSString *string=@"updateInfo.plist";
            NSString *stringName=[NSString stringWithFormat:@"Library/%@",string];
            NSString *filePath=[NSHomeDirectory() stringByAppendingPathComponent:stringName];
            plistDicInfo=[[NSDictionary alloc]initWithContentsOfFile:filePath];

        }else{
            plistDicInfo=[weatherDic objectForKey:@"update"];
            NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
//            NSLog(@"-----%@",path);
            NSString *fileNamepath=[path stringByAppendingPathComponent:@"updateInfo.plist"];//当下载的时候有更新的话把数据写到updateInfo。plist，后面断网后使用
            [plistDicInfo writeToFile:fileNamepath atomically:YES];
        }
        arrykeys=[[NSMutableArray alloc]init];
        for (id key in plistDicInfo) {
            [arrykeys addObject:key];
        }
        [self download];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:username.text forKey:@"username"];
        [dic setObject:[SecurityUtil encryptAESData:password.text] forKey:@"password"];//密码用AES加密
        [dic setObject:[self creatDate] forKey:@"lastDate"];
        [dicUserInfo setObject:dic forKey:username.text];
        [dicUserInfo writeToFile:[self dataFilePath] atomically:YES];
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    //判断没有网络的时候
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            [DataPist shared].plistInfo=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",username.text,[[DataPist shared].plistKeys objectAtIndex:2]]];
            [DataPist shared].username=username.text;
            Main_ViewController *choose_Line = [[Main_ViewController alloc]init];
            [self presentViewController:choose_Line animated:YES completion:Nil];
        }else if (buttonIndex==1)
        {
        }
    }
    //判断软件版本更新
    if (alertView.tag==2) {
        if (buttonIndex==0)
        {
            NSString *sss=[NSString stringWithFormat:@"%@",[dicVersion objectForKey:@"url"]];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:sss]];
        }else if (buttonIndex==1)
        {
        }
  
    }
    //判断软件强制更新
    if (alertView.tag==3) {
        if (buttonIndex==0)
        {
            NSString *sss=[NSString stringWithFormat:@"%@",[dicVersion objectForKey:@"url"]];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:sss]];
        }
    }
}

-(void)waiting{
    mb=   [ MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.labelText=@"正在登陆";
}

-(void)download{
    
    mb.labelText=@"正在下载";
    // 初始化队列
	if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
        // 设置最大并发数 默认为-1 无限制
        [networkQueue setMaxConcurrentOperationCount:-1];
	}
    // 重制队列
    [networkQueue cancelAllOperations];
	[networkQueue reset];
    // 设置队列的进度条
	[networkQueue setDownloadProgressDelegate:progressView];
    // 设置完成方法
	[networkQueue setRequestDidFailSelector:@selector(Failed:)];
    [networkQueue setQueueDidFinishSelector:@selector(Succeed:)];
    [networkQueue setRequestDidFinishSelector:@selector(Finished:)];
	// 显示精确进度
    
//    [networkQueue setShowAccurateProgress:YES];
	[networkQueue setDelegate:self];
        
    ASIHTTPRequest *requestone;
    for (int i=0; i<arrykeys.count; i++) {
        NSString *key=[NSString stringWithFormat:@"%@",[arrykeys objectAtIndex:i]];
        NSString *URlString=[NSString stringWithFormat:@"%@%@/username/%@/password/%@",[DataPist shared].ipString,[plistDicInfo objectForKey:key],username.text,password.text];
        NSString *encodedValue = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,(CFStringRef)URlString, nil,
                                            (CFStringRef)@"!*'();@&=+$,?%#[]", kCFStringEncodingUTF8));
        
        NSURL *urlssss=[NSURL URLWithString:encodedValue];
        requestone=[ASIHTTPRequest requestWithURL:urlssss];
        NSString *plist=[NSString stringWithFormat:@"%@_%@.plist",username.text,key];
        NSString *pathName=[[NSHomeDirectory() stringByAppendingString:@"/Library"] stringByAppendingPathComponent:plist];
        [requestone setDownloadDestinationPath:pathName];
      
        
        
        NSString *imageNameTemp=[NSString stringWithFormat:@"%@.temp",plist];
        NSString *pathNameTemp=[[NSHomeDirectory() stringByAppendingString:@"/Library"] stringByAppendingPathComponent:imageNameTemp];
        [requestone setTemporaryFileDownloadPath:pathNameTemp];
        [requestone setAllowResumeForFileDownloads:YES];

        
        [networkQueue addOperation:requestone];

    }
    
    ASIHTTPRequest *request;
    for (int i=0; i<[ImageInfoArrys count]; i++) {
//        NSString *pathss=[DataPist getFilePath:[ImageInfoArrys objectAtIndex:i]];
        NSString *sting=[NSString stringWithFormat:@"%@",[ImageInfoArrys objectAtIndex:i]];
        NSArray *strings=[[NSArray alloc]initWithArray:[sting componentsSeparatedByString:@"/"]];
        NSString *stringName=[NSString stringWithFormat:@"%@",[strings objectAtIndex:strings.count-1]];
         NSString *pathName=[[NSHomeDirectory() stringByAppendingString:@"/Documents"] stringByAppendingPathComponent:stringName];
        BOOL ishave=[[NSFileManager defaultManager] fileExistsAtPath:pathName];
        if (!ishave) {
            NSLog(@"存在");
            NSString *name=[ImageInfoArrys objectAtIndex:i];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[DataPist shared].ipString,name]];
            request = [ASIHTTPRequest requestWithURL:url];
            [request setDownloadDestinationPath:pathName];
            NSString *imageNameTemp=[NSString stringWithFormat:@"%@.temp",stringName];
            NSString *pathNameTemp=[[NSHomeDirectory() stringByAppendingString:@"/Documents"] stringByAppendingPathComponent:imageNameTemp];
            [request setTemporaryFileDownloadPath:pathNameTemp];
            [request setAllowResumeForFileDownloads:YES];
            [networkQueue addOperation:request];
        }
    }
    [networkQueue go];
}
//设置logo图片
-(void)setLogo{
        NSString *logn=[NSString stringWithFormat:@"%@",[DataPist getFilePath:@"logo.png"]];
        imageLogo.image=[UIImage imageWithContentsOfFile:logn];
}
//下载全部成功
-(void)Succeed:(ASINetworkQueue *)request{
   
    if (Flag != NO) {
        [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"succeed"];//判断图片全部下载是否成功，成功写入1
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self performSelector:@selector(changeloading) withObject:self afterDelay:0];
        Main_ViewController *choose_Line = [[Main_ViewController alloc]init];
        [DataPist shared].plistInfo=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",username.text,[[DataPist shared].plistKeys objectAtIndex:2]]];
        [DataPist shared].username=username.text;
        
        [self presentViewController:choose_Line animated:YES completion:Nil];
    }
}
//一张图片下载成功
-(void)Finished:(ASIHTTPRequest *)request{
    if (munberImage==[ImageInfoArrys count]+[arrykeys count]) {
        
}else{
        NSLog(@"--正在下载%d",munberImage++);
            mb.labelText=[NSString stringWithFormat:@"共%d张，正在下载第%d张",ImageInfoArrys.count+arrykeys.count,munberImage++];
    }
    [NSThread detachNewThreadSelector:@selector(setLogo) toTarget:self withObject:Nil];
}

-(void)changeloading{
    mb.labelText=@"正在初始化数据";
}
//下载失败
-(void)Failed:(ASIHTTPRequest *)request{
   
    isSetLastDate=YES;
    Flag = NO;
    
    if (connectNum==10) {
        if (IsFail==NO) {
            isSetLastDate=YES;
            [ MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络更新失败，请重新下载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
            [alert show];
            IsFail=YES;
            lastupdate=Nil;
            [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"succeed"];//判断图片全部下载是否成功，失败写入0
            [[NSUserDefaults standardUserDefaults]synchronize];
            ;
        }

    }else{
        connectNum++;
        NSLog(@"---正在重新连接第%d次",connectNum);
        Flag=YES;
        IsFail=NO;
        sleep(2);
        [self performSelector:@selector(download) withObject:nil afterDelay:0];
    }
        progressView.hidden=YES;
     [ MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (NSString *)dataFilePath {
    //写入library
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSLog(@"-----%@",path);
    NSString *fileNamepath=[path stringByAppendingPathComponent:@"userInfo.plist"];
    return fileNamepath;
}

- (void)setting:(id)sender
{
    Setting_PageViewController *setting_page = [[Setting_PageViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:setting_page];
    nav.modalPresentationStyle=UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:NULL];
}

- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
