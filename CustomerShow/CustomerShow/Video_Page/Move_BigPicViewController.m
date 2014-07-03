//
//  Move_BigPicViewController.m
//  Icicle
//
//  Created by 讯 鹿 on 13-5-23.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "Move_BigPicViewController.h"
@interface Move_BigPicViewController ()

@end

@implementation Move_BigPicViewController
@synthesize MovieView,isDown;
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
-(void)dealloc{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   dicBtnIS=[[NSMutableDictionary alloc]init];

    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
//    [self initFrameTitle];
    scrollLeft=[[UIScrollView alloc]initWithFrame:CGRectMake(9, 0, 132, 651)];
    scrollLeft.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scrollLeft];
    arryImageInfo=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:5]]];
    for (int i=0; i<arryImageInfo.count; i++) {
        UIButton *btn=[UIButton buttonWithType:0];
        btn.frame=CGRectMake(0, 0+99*i+5*i, 132, 99);
        NSString *path=[NSString stringWithFormat:@"l_%@",[[arryImageInfo objectAtIndex:i] objectForKey:@"img"]];
        [btn setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",[DataPist getFilePath:path]]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startVideo:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        btn.showsTouchWhenHighlighted = YES;
        NSString *tagSring=[NSString stringWithFormat:@"%d",btn.tag];
        [dicBtnIS setValue:@"YES" forKey:tagSring];
        [scrollLeft addSubview:btn];
    }
    [scrollLeft setContentSize:CGSizeMake(0, 110*8)];
    isDown=@"1";
    [self initMovie];
}
-(void)setDown:(NSNotification *)nocity{
    isDown=nocity.object;
}
//-(UIImage *)videoThumbnail:(NSString *)movieFullPath
//{
//    UIImage *thumbnail = nil;
//    NSURL *url = [NSURL fileURLWithPath:movieFullPath];
//    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
//    //Player autoplays audio on init
//    [player stop];
//    return thumbnail;
//}
-(void)initMovie{
    DataAll=[[NSMutableData alloc]init];
    [MovieView.view removeFromSuperview];
    MovieView = [[MPMoviePlayerController alloc]init];
    [MovieView.view setFrame:CGRectMake(145, 0, 1024-145, 651)];
    [MovieView setControlStyle:MPMovieControlModeVolumeOnly];
    [MovieView setFullscreen:YES animated:YES];
    MovieView.repeatMode = MPMovieRepeatModeOne;
    [MovieView setInitialPlaybackTime:0.0];
    MovieView.movieSourceType = MPMovieSourceTypeFile;
    MovieView.scalingMode = MPMovieScalingModeAspectFit;
    [self.view addSubview:MovieView.view];
    NSURL *playerFileURL;
    if ([[[arryImageInfo objectAtIndex:0] objectForKey:@"outlink"]isEqualToString:@""]) {
        playerFileURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[DataPist shared].ipString,[[arryImageInfo objectAtIndex:0] objectForKey:@"video"]]];
    }else
    {
        playerFileURL =[NSURL URLWithString:[[arryImageInfo objectAtIndex:0] objectForKey:@"outlink"]];
    }
    
    NSString *movieNames=[NSString stringWithFormat:@"%@.mp4",[[arryImageInfo objectAtIndex:0] objectForKey:@"name"]];
    if ([[NSFileManager defaultManager]fileExistsAtPath:[DataPist getFilePath:movieNames]]) {
        NSString *moviePath=[NSString stringWithFormat:@"%@",[DataPist getFilePath:movieNames]];
        NSURL *url=[[NSURL alloc]initFileURLWithPath:moviePath];
        [MovieView setContentURL:url];
        [MovieView.view setHidden:NO];
//        [MovieView thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        [MovieView play];
        
    }else
    {
        for ( int i=0; i<arryImageInfo.count; i++) {
            UIButton *btn=(UIButton *)[self.view viewWithTag:i];
            btn.userInteractionEnabled=NO;
        }
            [self waitView];
            dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(concurrentQueue, ^{
                dispatch_sync(concurrentQueue, ^{
                    /* Download the image here */
                    [self download:playerFileURL tag:0];
                });
                dispatch_sync(dispatch_get_main_queue(), ^{
                    /* Show the image to the user here on the main queue*/
                    
                });
            });
    }
}
-(void)waitView{
    [TanChuView removeFromSuperview];
    TanChuView=[[UIView alloc]initWithFrame:CGRectMake(300, 250, 200, 50)];
    NSLog(@"-----%@",NSStringFromCGRect(TanChuView.frame));
    TanChuView.backgroundColor=[UIColor whiteColor];
    TanChuView.alpha=0.5;
    TanChuView.layer.cornerRadius = 6;
    TanChuView.layer.masksToBounds = YES;
    LoadLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 150, 30)];
//    LoadLabel.text=@"正在下载";
    LoadLabel.font=[UIFont systemFontOfSize:12];
    LoadLabel.backgroundColor=[UIColor clearColor];
    [TanChuView addSubview:LoadLabel];
    [MovieView.view addSubview:TanChuView];
}
-(void)download:(NSURL *)url tag:(int )tag{
        ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        movieName=[NSString stringWithFormat:@"%@.mp4",[[arryImageInfo objectAtIndex:tag] objectForKey:@"name"]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:movieName];
        NSLog(@"%@",documentsDirectory);
        [request setAllowResumeForFileDownloads:YES];
        [request setDownloadDestinationPath:documentsDirectory];
        [request setDidReceiveResponseHeadersSelector:@selector(didReceiveResponseHeadersSelector:)];
        [request setDidReceiveDataSelector:@selector(request:didReceiveData:)];
        [request setDidFailSelector:@selector(Failed:)];
        [request setDidFinishSelector:@selector(Finished:)];
        [request startAsynchronous];
}
-(void)didReceiveResponseHeadersSelector:(ASIHTTPRequest *)request{
    NSString  *string=[[NSString alloc]initWithFormat:@"%@",[request.responseHeaders valueForKey:@"Content-Length"]];
    byteall=[string integerValue];
    NSLog(@"byteall=%i M",byteall/1024/1024);
}
-(void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)Data{
    [DataAll appendData:Data];
    [TanChuView setHidden:NO];
    NSLog(@"%lli M",(long long)[DataAll length]/1024/1024);
    LoadLabel.text=[NSString stringWithFormat:@"共%i M,正在下载%lli M",byteall/1024/1024,(long long)[DataAll length]/1024/1024];
}
-(void)Finished:(ASIHTTPRequest *)request{
    NSLog(@"下载完成");
    LoadLabel.text=@"下载完成，开始播放";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:movieName];
    NSLog(@"%@",documentsDirectory);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [DataAll writeToFile:documentsDirectory atomically:YES];
//    sleep(1);
    NSURL *url=[[NSURL alloc]initFileURLWithPath:documentsDirectory];
    [MovieView setContentURL:url];
    [MovieView.view setHidden:NO];
    if ([[DataPist shared].isCurrent isEqualToString:@"YES"]) {
         [MovieView play];
    }else if([[DataPist shared].isCurrent isEqualToString:@"NO"]){
        [MovieView pause];
    }
   
    [TanChuView removeFromSuperview];
    
    
//    NSDictionary *dic=[[NSDictionary alloc]init];
    [dicBtnIS setValue:@"NO" forKey:@"0"];
//    if ([[dicBtnIS objectForKey:@"0"]isEqualToString:@"NO"]) {
//        UIButton *btn=(UIButton *)[self.view viewWithTag:0];
//        btn.userInteractionEnabled=YES;
//    }
    
    for ( int i=0; i<arryImageInfo.count; i++) {
//        if ([[dicBtnIS objectForKey:[NSString stringWithFormat:@"%d",i]]isEqualToString:@"NO"]) {
            UIButton *btn=(UIButton *)[self.view viewWithTag:i];
            btn.userInteractionEnabled=YES;
//        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"downLing" object:@"0"];

    
}

-(void)Failed:(ASIHTTPRequest *)Failed{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"播放失败，请查看网络是否连接" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
    [alter show];
    [TanChuView removeFromSuperview];
    
    for ( int i=0; i<arryImageInfo.count; i++) {
        //        if ([[dicBtnIS objectForKey:[NSString stringWithFormat:@"%d",i]]isEqualToString:@"NO"]) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:i];
        btn.userInteractionEnabled=YES;
        //        }
    }
}

-(void)startVideo:(UIButton *)sender{
    
    [dicBtnIS setValue:@"YES" forKey:[NSString stringWithFormat:@"%d",sender.tag]];
    [MovieView stop];
    DataAll=[[NSMutableData alloc]init];
    byteall=0;
    NSURL *playerFileURL;
    if ([[[arryImageInfo objectAtIndex:sender.tag] objectForKey:@"outlink"]isEqualToString:@""]) {
        playerFileURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[DataPist shared].ipString,[[arryImageInfo objectAtIndex:sender.tag] objectForKey:@"video"]]];
    }else
    {
        playerFileURL =[NSURL URLWithString:[[arryImageInfo objectAtIndex:sender.tag] objectForKey:@"outlink"]];
    }
    
    movieName=[NSString stringWithFormat:@"%@.mp4",[[arryImageInfo objectAtIndex:sender.tag] objectForKey:@"name"]];
    if ([[NSFileManager defaultManager]fileExistsAtPath:[DataPist getFilePath:movieName]]) {
        
        UIButton *btn=(UIButton *)[self.view viewWithTag:sender.tag];
        btn.userInteractionEnabled=YES;
        [TanChuView setHidden:YES];
        NSString *moviePath=[DataPist getFilePath:movieName];
        NSURL *url=[[NSURL alloc]initFileURLWithPath:moviePath];
        [MovieView setContentURL:url];
        [MovieView.view setHidden:NO];
        [MovieView play];
    }else{
      
        for (int i=0; i<arryImageInfo.count; i++) {
            UIButton *btn=(UIButton *)[self.view viewWithTag:i];
                btn.userInteractionEnabled=NO;
        }

        [self waitView];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"downLing" object:@"1"];

        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(concurrentQueue, ^{
            dispatch_sync(concurrentQueue, ^{
                /* Download the image here */
                [self download:playerFileURL tag:sender.tag];
            });
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                /* Show the image to the user here on the main queue*/
            }); 
        });
    }
  
    
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
//-(void)goBack
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
