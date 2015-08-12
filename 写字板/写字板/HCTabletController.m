//
//  HCTabletController.m
//  写字板
//
//  Created by MAC on 15/8/11.
//  Copyright (c) 2015年 hczsiOS. All rights reserved.
//

#import "HCTabletController.h"
#import "MyView.h"
#define Screenwith [UIScreen mainScreen].bounds.size.width
#define Screenheight [UIScreen mainScreen].bounds.size.height

@interface HCTabletController ()

@property (nonatomic,strong) MyView *drawView;

@property (nonatomic,strong)NSMutableArray *colorsArr;

@property (nonatomic,strong)NSMutableArray *colorsTitArr;

@property (nonatomic,assign)BOOL buttonHidden;

@property (nonatomic,assign)BOOL widthHidden;

@property (nonatomic,strong)UIButton *colorBtn;


@end

@implementation HCTabletController

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorsArr = [NSMutableArray arrayWithObjects:[UIColor greenColor],[UIColor blueColor],[UIColor redColor],[UIColor blackColor],[UIColor yellowColor], nil];
    self.colorsTitArr = [NSMutableArray arrayWithObjects:@"绿色",@"蓝色",@"红色",@"黑色",@"黄色", nil];
    self.buttonHidden = YES;
    self.widthHidden = YES;
    self.drawView = [[MyView alloc]initWithFrame:self.view.frame];
    self.drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.drawView];
    [self.view sendSubviewToBack:self.drawView];
    
    //前进
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screenwith - 100, 22, 40, 40)];
    backBtn.tag = 504;
    [backBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    backBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:backBtn];
    
    //后退
    UIButton *forwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screenwith - 40, 22, 40, 40)];
    forwardBtn.tag = 505;
    [forwardBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    forwardBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:forwardBtn];
    
    //设置笔的大小
    NSArray *writingArr = @[@"10",@"20",@"30",@"40"];
    for (int i = 0; i < 4; i ++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(Screenwith - 40,200 + i * 45, 40, 40)];
        button.tag = 506 + i;
        button.backgroundColor = [UIColor yellowColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:writingArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        
        
    }
    
    
    //设置详细的颜色
    for (int i = 0; i < 5; i++) {
        
        UIButton *bttn = [[UIButton alloc]initWithFrame:CGRectMake(0, 200 + i * 45, 40, 40)];
        
        bttn.tag = 600 + i;
        bttn.backgroundColor = self.colorsArr[i];
        [bttn setTitle:self.colorsTitArr[i] forState:UIControlStateNormal];
        [bttn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bttn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self.view addSubview:bttn];
        
    }
        
    
    
    //设置下面的几个功能按钮
    NSArray *btnArr = @[[UIColor greenColor],[UIColor whiteColor],[UIColor yellowColor],[UIColor redColor]];
    NSArray *titleArr = @[@"clear",@"color",@"截屏",@"width"];
    
    CGFloat butW = (Screenwith - 50)/4;
    for (int i = 0 ; i < 4; i ++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10 + (butW + 10) * i, Screenheight - 40, butW, 40)];
        button.tag = 500 + i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.backgroundColor = btnArr[i];
        button.layer.cornerRadius = 4;
        button.layer.masksToBounds = YES;
        [self.view addSubview:button];
        if (i == 1) {
            self.colorBtn = button;
        }
    
    }
    
}

- (void)btnClick:(UIButton*)btn{

    switch (btn.tag) {
        case 500:
        {
        
            [self.drawView clear];
            break;
        }
        case 501:
        {
            if (self.buttonHidden==YES) {
                for (int i=1; i<6; i++) {
                    UIButton *button=(UIButton *)[self.view viewWithTag:i];
                    button.hidden=NO;
                    self.buttonHidden=NO;
                }
            }else{
                for (int i=1; i<6; i++) {
                    UIButton *button=(UIButton *)[self.view viewWithTag:i];
                    button.hidden=YES;
                    self.buttonHidden=YES;
                }
                
            }
            

            break;
        }
        case 502:
        {
            for (int i=1; i<16;i++) {
                UIView *view=[self.view viewWithTag:i];
                if ((i>=1&&i<=5)||(i>=10&&i<=15)) {
                    if (view.hidden==YES) {
                        continue;
                    }
                }
                view.hidden=YES;
                if(i>=1&&i<=5){
                    self.buttonHidden=YES;
                }
                if(i>=10&&i<=15){
                    self.widthHidden=YES;
                }
            }
            UIGraphicsBeginImageContext(self.view.bounds.size);
            [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
            
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
            [self.view addSubview:imgview];
            
            imgview.image = image;
            
            
            UIGraphicsEndImageContext();
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
            for (int i=1;i<16;i++) {
                if ((i>=1&&i<=5)||(i>=11&&i<=14)) {
                    continue;
                }
                UIView *view=[self.view viewWithTag:i];
                view.hidden=NO;
            }
            //截屏成功
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Save OK" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            [alertView show];
            
            break;
        }
        case 503:
        {
            if (self.widthHidden==YES) {
                for (int i=11; i<15; i++) {
                    UIButton *button=(UIButton *)[self.view viewWithTag:i];
                    button.hidden=NO;
                    self.widthHidden=NO;
                }
            }else{
                for (int i=11; i<15; i++) {
                    UIButton *button=(UIButton *)[self.view viewWithTag:i];
                    button.hidden=YES;
                    self.widthHidden=YES;
                }
                
            }
            
            break;
        }
            
        case 504:
        {
            
            [self.drawView revocation];
            break;
        }
            
        case 505:
        {
            
            [ self.drawView refrom];
            break;
        }
        case 506:
        {
            [self.drawView setlineWidth:0];
            NSLog(@"506");
            break;
        }
        case 507:
        {
            [self.drawView setlineWidth:1];
            NSLog(@"507");
            break;
        }
        case 508:
        {
            [self.drawView setlineWidth:2];
            NSLog(@"508");
            break;
        }
        case 509:
        {
            [self.drawView setlineWidth:3];
            NSLog(@"509");
            break;
        }
            
        case 600:
        {
            [self.drawView setLineColor:0];
            self.colorBtn.backgroundColor=[self.colorsArr objectAtIndex:0];
            break;
        }
        case 601:
        {
            [self.drawView setLineColor:1];
            self.colorBtn.backgroundColor=[self.colorsArr objectAtIndex:1];
            NSLog(@"509");
            break;
        }
        case 602:
        {
            [self.drawView setLineColor:2];
            self.colorBtn.backgroundColor=[self.colorsArr objectAtIndex:2];            NSLog(@"509");
            break;
        }
        case 603:
        {
            [self.drawView setLineColor:3];
            self.colorBtn.backgroundColor=[self.colorsArr objectAtIndex:3];            NSLog(@"509");
            break;
        }
        case 604:
        {
            [self.drawView setLineColor:4];
            self.colorBtn.backgroundColor=[self.colorsArr objectAtIndex:4];            NSLog(@"509");
            break;
        }
            
        default:
            break;
    }






}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
