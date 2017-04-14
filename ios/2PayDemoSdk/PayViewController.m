

#import "PayViewController.h"
#import "TwoPaySdk.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0/255 green:243.0/255 blue:245.0/255 alpha:1.0]];
    [self.navigationController setNavigationBarHidden:YES];

    
    importo = [[UITextField alloc] init];
    [importo setTextAlignment:NSTextAlignmentCenter];
    [importo setPlaceholder:@" importo"];
    [importo setKeyboardType:UIKeyboardTypeDecimalPad];
    [importo setAutocorrectionType:UITextAutocorrectionTypeNo];
    importo.layer.borderWidth = 1;
    [importo setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0]];
    
    numero = [[UITextField alloc] init];
    [numero setTextAlignment:NSTextAlignmentCenter];
    [numero setPlaceholder:@" numero"];
    [numero setKeyboardType:UIKeyboardTypeDecimalPad];
    [numero setAutocorrectionType:UITextAutocorrectionTypeNo];
    numero.layer.borderWidth = 1;
    [numero setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self printView];
}


- (void)printView{
    
    int h = 0;
    
    UIView *topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, h, self.view.frame.size.width, 64)];
    [topBarView setBackgroundColor:[UIColor colorWithRed:43.0/255 green:112.0/255 blue:240.0/255 alpha:1.0]];
    UIView *topBarContent = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    
    UIButton *topPayButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, 44, 44)];
    [topPayButton setTitle:@"<" forState:UIControlStateNormal];
    [topPayButton.titleLabel setFont:[UIFont systemFontOfSize:30 weight:1.5]];
    [topPayButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [topBarContent addSubview:topPayButton];
    
    UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, topBarContent.frame.size.width-120, topBarContent.frame.size.height)];
    [payLabel setText:@"PAGA"];
    [payLabel setTextAlignment:NSTextAlignmentCenter];
    [payLabel setBackgroundColor:[UIColor clearColor]];
    [payLabel setTextColor:[UIColor whiteColor]];
    [payLabel setFont:[UIFont systemFontOfSize:26 weight:1.5]];
    [topBarContent addSubview:payLabel];
    
    
    [topBarView addSubview:topBarContent];
    [self.view addSubview:topBarView];
    h+=64;
    
    h+=30;
    
    UILabel *pay2payLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, h, topBarContent.frame.size.width-40, 40)];
    [pay2payLabel setBackgroundColor:[UIColor clearColor]];
    [pay2payLabel setText:@"Inserisici i dati del pagamento"];
    [pay2payLabel setTextAlignment:NSTextAlignmentCenter];
    [pay2payLabel setFont:[UIFont systemFontOfSize:20 weight:0.1]];
    [self.view addSubview:pay2payLabel];
    h+=40;
    
    [importo setFrame:CGRectMake(self.view.frame.size.width/2-100, h, 200, 38)];
    importo.layer.cornerRadius = 5;
    [self.view addSubview:importo];
    h+=45;
    
    [numero setFrame:CGRectMake(self.view.frame.size.width/2-100, h, 200, 38)];
    numero.layer.cornerRadius = 5;
    [self.view addSubview:numero];
    h+=45;
    
    h+=10;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, h, 200, 50)];
    [button setBackgroundColor:[UIColor colorWithRed:235.0/255 green:77.0/255 blue:28.0/255 alpha:1.0]];
    [button setImageEdgeInsets:UIEdgeInsetsMake(5, 200-74, 5, 5)];
    [button setImage:[UIImage imageNamed:@"2pay_white_logo.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(payWith2Pay) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    [self.view addSubview:button];
    h+=60;
    
    UILabel *payWithLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, button.frame.size.width-79, 40)];
    [payWithLabel setBackgroundColor:[UIColor clearColor]];
    [payWithLabel setText:@"paga con"];
    [payWithLabel setTextAlignment:NSTextAlignmentCenter];
    [payWithLabel setTextColor:[UIColor whiteColor]];
    [payWithLabel setFont:[UIFont systemFontOfSize:24 weight:0.3]];
    [button addSubview:payWithLabel];
    h+=40;
    
    
    
}

- (void)payWith2Pay{
    
    //Check if 2Pay App is Installed
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",TWOPAY_APPID]]]) {
        
        double importoDouble = [[importo.text stringByReplacingOccurrencesOfString:@"," withString:@"."] doubleValue];
        
        NSDictionary *result = [TwoPaySdk sendPaymentRequestWithAppId:@"twopayRVlK5m12fVk3BDTCVQyhud8Y90" andAmount:importoDouble andPayeeNumber:numero.text];
        
        if([[result valueForKey:@"is_valid"] isEqualToString:@"false"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"2Pay SDK Error"
                                                            message:[result valueForKey:@"error_message"]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You can't pay with 2Pay"
                                                        message:@"2Pay App is not installed on your device"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)payWithTwoPay{
    
    //Check if 2Pay App is Installed
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",TWOPAY_APPID]]]) {
        
        double importoDouble = [[importo.text stringByReplacingOccurrencesOfString:@"," withString:@"."] doubleValue];
        
        //send payment request - Return NSDictionary with payment request info and possible errors
        NSDictionary *result = [TwoPaySdk sendPaymentRequestWithAppId:@"twopayRVlK5m12fVk3BDTCVQyhud8Y90" andAmount:importoDouble andPayeeNumber:numero.text];
        
        //if payment request are not valid
        if([[result valueForKey:@"is_valid"] isEqualToString:@"false"]){
            
            //error message
            NSString *errorMessage = [result valueForKey:@"error_message"];
            
            //Do what you want
            
        }
    }
    else{
        //2Pay App not Installed on device - You can not pay
        //Do what you want
    }
    
}



@end
