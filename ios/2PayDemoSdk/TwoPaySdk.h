//
//  2PaySdk.h
//  2PayDemoSdk
//
//  Created by Sviluppo 3 on 10/03/16.
//  Copyright © 2016 i-contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TWOPAY_URL_PREFIX @"twopay"
#define TWOPAY_APPID @"twopay"

@interface TwoPaySdk : NSObject

+ (NSDictionary*)sendPaymentRequestWithAppId:(NSString*)appId andAmount:(double)amount andPayeeNumber:(NSString*)payeeNumber;
+ (NSDictionary *)processPaymentCallbackWithURL:(NSString*)url;

@end
