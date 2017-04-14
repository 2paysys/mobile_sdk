
Include 2pay SDK library in you project:
```java
2Pay_Android_SDK_x_y.aar
```

Detect if 2Pay app are installed:
```java
TwoPayUtils.is2PayAppInstalled(MyActivity.this);
```

Launch 2Pay app to make a payment:
```java
support = new TwoPaySupport(MyActivity.this, ref, "2PMy_App_ID", amount);
                    
startActivityForResult(support.buildRequest(), TwoPaySupport.REQUEST_PAY);
```
- `ref` is the phone number of 
- `amount` is a `double` value of amount that user must pay.

Check payment result:
```java
@Override
public void onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == TwoPaySupport.REQUEST_PAY) {
        TwoPayAppResponse response 
        	= support.parseResponse(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            // show response
        } else {
            // show error
        }
    }

}
```
twopay://payment/request?app-id=twopayRVlK5m12fVk3BDTCVQyhud8Y90