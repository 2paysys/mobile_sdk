CONFIGURATIONS
==============

Add following parameters to your info.plist configuration file:
---------------------------------------------------------------

#This parameter is required to check if the 2Pay application is installed on device.

```XML

<key>LSApplicationQueriesSchemes</key>
<array>
<string>twopay</string>
</array>

```

#This parameter is required to receive the payment callback.

```XML

<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleURLSchemes</key>
<array>
<string>INSERT_YOUR_2PAY_APPID</string>
</array>
</dict>
</array>

```

USAGE
=====

Send payment request
--------------------

#In your Objective-C class

```Objective-C

//Import
#import "TwoPaySdk.h"

```

```Objective-C

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

```


Receive 2Pay callback
---------------------

#In AppDelegate.m

```Objective-C

//Import
#import "TwoPaySdk.h"

```

```Objective-C

//URL String
NSString *urlString = [NSString stringWithFormat:@"%@",url];

//Check if callback is from 2Pay app
if([urlString hasPrefix:TWOPAY_URL_PREFIX]){

NSDictionary *paymentValues = [TwoPaySdk processPaymentCallbackWithURL:urlString];

//Payment Status
NSString *status = [paymentValues valueForKey:@"status"];

if([status isEqualToString:@"paid"]){
//Payment Success

//Payment Callback values
NSString *number = [paymentValues valueForKey:@"ref"];
NSString *amount = [paymentValues valueForKey:@"payment"];
NSString *transactionId = [paymentValues valueForKey:@"trans_id"];
NSString *currency = [paymentValues valueForKey:@"currency"];
NSString *cbPurchase = [paymentValues valueForKey:@"purchase_cashback"];
NSString *cbSocial = [paymentValues valueForKey:@"social_cashback"];

//Do what you want
}
else{
//Payment Failed

//Do what you want
}


}

```