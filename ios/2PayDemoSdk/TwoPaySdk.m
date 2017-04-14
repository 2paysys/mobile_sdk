//
//  2PaySdk.m
//  2PayDemoSdk
//
//  Created by Sviluppo 3 on 10/03/16.
//  Copyright © 2016 i-contact. All rights reserved.
//

#import "TwoPaySdk.h"

@implementation TwoPaySdk

+ (NSDictionary*)sendPaymentRequestWithAppId:(NSString*)appId andAmount:(double)amount andPayeeNumber:(NSString*)payeeNumber{
    
    NSString *error = @"";
    NSMutableDictionary *result = nil;
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",TWOPAY_APPID]]]) {
        if(appId && appId.length>0){
            if(amount>0.0){
                if(payeeNumber&&payeeNumber.length>0){
                    
                    NSString *url = [NSString stringWithFormat:@"%@://payment/request/%@?ref=%@&amount=%.2f&validate-hash=RVlK5m12fVk3BDTC_VQyhud8Y90&transaction-id=abc123",TWOPAY_APPID,appId,payeeNumber,amount];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
                    
                    result = [NSMutableDictionary dictionary];
                    [result setObject:@"true" forKey:@"is_valid"];
                    
                }
                else{
                    error = @"Payee Number is required";
                }
            }
            else{
                error = @"Amount must be greater than 0";
            }
        }
        else{
            error = @"AppId is required";
        }
    }
    else{
        error = @"2Pay App not installed";
    }
    
    if(error&&error.length>0){
        error = [NSString stringWithFormat:@"2PaySdkError: %@",error];
        NSLog(@"%@",error);
        
        result = [NSMutableDictionary dictionary];
        [result setObject:@"false" forKey:@"is_valid"];
        [result setObject:error forKey:@"error_message"];
        
    }
    
    return result;
}

+ (NSDictionary *)processPaymentCallbackWithURL:(NSString*)url{
    
    NSMutableDictionary *urlValues = [[NSMutableDictionary alloc] init];
    
    NSArray *comp1 = [url componentsSeparatedByString:@"?"];
    
    NSString *query = [comp1 lastObject];
    NSArray *queryElements = [query componentsSeparatedByString:@"&"];
    for (NSString *element in queryElements) {
        NSArray *keyVal = [element componentsSeparatedByString:@"="];
        if (keyVal.count > 0) {
            NSString *variableKey = [keyVal objectAtIndex:0];
            NSString *value = (keyVal.count >= 2) ? [keyVal objectAtIndex:1] : nil;
            if(value){
                [urlValues setObject:value forKey:variableKey];
            }
        }
    }
    
    if(![urlValues valueForKey:@"status"]){
        [urlValues setObject:@"failed" forKey:@"status"];
    }
    
    return urlValues;
    
}

@end