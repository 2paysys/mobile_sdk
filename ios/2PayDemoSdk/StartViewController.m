//
//  StartViewController.m
//  2PayDemoSdk
//
//  Created by Sviluppo 3 on 17/02/16.
//  Copyright © 2016 i-contact. All rights reserved.
//

#import "StartViewController.h"
#import "PayViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0/255 green:243.0/255 blue:245.0/255 alpha:1.0]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self printView];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)printView{
    
    for(UIView *v in self.view.subviews){
        [v removeFromSuperview];
    }
    
    int h = 0;
    
    UIView *topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, h, self.view.frame.size.width, 64)];
    [topBarView setBackgroundColor:[UIColor colorWithRed:43.0/255 green:112.0/255 blue:240.0/255 alpha:1.0]];
    UIView *topBarContent = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    
    UIButton *topPayButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, 44, 44)];
    [topPayButton setImage:[UIImage imageNamed:@"pay_icon.png"] forState:UIControlStateNormal];
    [topBarContent addSubview:topPayButton];
    [topPayButton setUserInteractionEnabled:NO];
    
    UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, topBarContent.frame.size.width-120, topBarContent.frame.size.height)];
    [payLabel setText:@"PAGA"];
    [payLabel setTextAlignment:NSTextAlignmentCenter];
    [payLabel setTextColor:[UIColor whiteColor]];
    [payLabel setFont:[UIFont systemFontOfSize:26 weight:1.5]];
    [topBarContent addSubview:payLabel];
    
    
    [topBarView addSubview:topBarContent];
    [self.view addSubview:topBarView];
    h+=64;
    
    h+=30;
    
    UILabel *pay2payLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, h, topBarContent.frame.size.width-120, 40)];
    [pay2payLabel setBackgroundColor:[UIColor clearColor]];
    [pay2payLabel setText:@"Paga con 2Pay"];
    [pay2payLabel setTextAlignment:NSTextAlignmentCenter];
    [pay2payLabel setFont:[UIFont systemFontOfSize:25 weight:0.1]];
    [self.view addSubview:pay2payLabel];
    h+=40;
    
    UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-75, h, 150, 87)];
    payButton.backgroundColor = [UIColor colorWithRed:255.0/255 green:79.0/255 blue:18.0/255 alpha:1.0];
    payButton.layer.cornerRadius = 10;
    [payButton setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [payButton setImage:[UIImage imageNamed:@"2pay_white_logo.png"] forState:UIControlStateNormal];
    [payButton setContentMode:UIViewContentModeScaleToFill];
    [payButton addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
    
    
}

- (void)goToPay{
    PayViewController *controller = [[PayViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
