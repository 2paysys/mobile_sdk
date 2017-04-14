//
//  AppDelegate.m
//  2PayDemoSdk
//
//  Created by Sviluppo 3 on 17/02/16.
//  Copyright © 2016 i-contact. All rights reserved.
//

#import "AppDelegate.h"
#import "StartViewController.h"
#import "TwoPaySdk.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    StartViewController *controller = [[StartViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    
    
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //URL String
    NSString *urlString = [NSString stringWithFormat:@"%@",url];
    
    if([urlString hasPrefix:TWOPAY_URL_PREFIX]){
        
        NSDictionary *paymentValues = [TwoPaySdk processPaymentCallbackWithURL:urlString];
        
        NSString *status = [paymentValues valueForKey:@"status"];
        
        if([status isEqualToString:@"paid"]){
            
            NSString *number = [paymentValues valueForKey:@"ref"];
            NSString *amount = [paymentValues valueForKey:@"payment"];
            NSString *transactionId = [paymentValues valueForKey:@"trans_id"];
            NSString *currency = [paymentValues valueForKey:@"currency"];
            NSString *cbPurchase = [paymentValues valueForKey:@"purchase_cashback"];
            NSString *cbSocial = [paymentValues valueForKey:@"social_cashback"];
            
            NSString *message = [NSString stringWithFormat:@"Pagamento eseguito!\n\n%@ ha pagato %@ %@\n\n",number,amount,currency];
            
            if(cbPurchase){
                message = [NSString stringWithFormat:@"%@cashback: %@ %@\n",message,cbPurchase,currency];
            }
            if(cbSocial){
                message = [NSString stringWithFormat:@"%@social cashback: %@ %@",message,cbSocial,currency];
            }
            
            message = [message stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PAGATO"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.tag = 1;
            [alert show];
            
            
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pagamento Annullato"
                                                            message:@"Il pagamento con 2Pay NON è stato completato"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        
        
    }
    
    return YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 1){
        [(UINavigationController*)self.window.rootViewController popViewControllerAnimated:YES];
    }
    
}


@end
