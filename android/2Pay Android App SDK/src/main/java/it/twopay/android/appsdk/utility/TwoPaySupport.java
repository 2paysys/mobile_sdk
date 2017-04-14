/*
 * Copyright (c) 2016. 2pay.it
 */

package it.twopay.android.appsdk.utility;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;

import it.twopay.android.appsdk.beans.TwoPayAppResponse;

/**
 * Created by 2pay.it on 21/01/16.
 */
public class TwoPaySupport {

    private static final String TAG = TwoPaySupport.class.getSimpleName();

    public static int REQUEST_PAY = 0x2941;
    private static String PAR_STATUS = "status";
    private static String PAR_TRANSID = "trans_id";
    private static String PAR_DATE = "date";
    private static String PAR_CODE = "code";
    private static String PAR_REF = "ref";
    private static String PAR_CURRENCY = "currency";
    private static String PAR_CASHBACK_PURCHASE = "cashback_purchase";
    private static String PAR_CASHBACK_SOCIAL = "cashback_social";
    private static String PAR_PAYMENT = "payment";
    private static String PAR_NETAMOUNT = "net_amount";

    private Activity a;
    private String ref, appId;
    private Double amount;

    public TwoPaySupport(Activity a, String ref, String appId, Double amount) {
        this.a = a;
        this.ref = ref;
        this.appId = appId;
        this.amount = amount;
    }

    public Intent buildRequest() {
        String req = Globals.SCHEME_DEFAULT+"://payment/request/"+appId+"?ref="+ref+"&amount="+amount;
        return new Intent("android.intent.action.VIEW", Uri.parse(req));
    }

    public TwoPayAppResponse parseResponse(int requestCode, int resultCode, Intent data) {
        // Intent { data=twopayEQGMoyKo_ghqEe0_wS9k-tGbBbHJpz5qb9gsUfNroAo=://cb?status=paid&currency=EUR&cashback_purchase=0.1&cashback_social=0.025&payment=-1.0&net_amount=-0.875&ref=0009999938&code=IT&date=2016-03-08T11:50:47Z&trans_id=MzgyNQ==

        TwoPayAppResponse toReturn = new TwoPayAppResponse();
        if (requestCode == REQUEST_PAY && resultCode == Activity.RESULT_OK) {
            Uri uri = data.getData();
            toReturn.setAppId(uri.getScheme().replace(Globals.SCHEME_DEFAULT, ""));

            TwoPayAppResponse.Status status = TwoPayAppResponse.Status.ERROR;
            String transId = null, date = null, code = null, ref = null, currency = null;
            double cashbackPurchase = 0, cashbackSocial = 0, payment = 0, netAmount= 0;

            try {
                status = TwoPayAppResponse.Status.valueOf(uri.getQueryParameter(PAR_STATUS).toUpperCase());
            } catch (IllegalArgumentException e) {
                Log.e(TAG, "Error parsing Response, status '" + uri.getQueryParameter(PAR_STATUS) + "' is invalid");
            }

            transId = uri.getQueryParameter(PAR_TRANSID);
            date = uri.getQueryParameter(PAR_DATE);
            code = uri.getQueryParameter(PAR_CODE);
            ref = uri.getQueryParameter(PAR_REF);
            currency = uri.getQueryParameter(PAR_CURRENCY);
            String p = uri.getQueryParameter(PAR_PAYMENT);
            String a = uri.getQueryParameter(PAR_NETAMOUNT);
            payment = TextUtils.isEmpty(p)?0:Double.valueOf(p);
            netAmount = TextUtils.isEmpty(a)?0:Double.valueOf(a);
            try {
                cashbackPurchase = Double.valueOf(uri.getQueryParameter(PAR_CASHBACK_PURCHASE));
            } catch (Exception e) {
                Log.e(TAG, "No Purchase Cashback", e);
            }
            try {
                cashbackSocial = Double.valueOf(uri.getQueryParameter(PAR_CASHBACK_SOCIAL));
            } catch (Exception e) {
                Log.e(TAG, "No Social Cashback", e);
            }

            toReturn.setStatus(status);
            toReturn.setTransId(transId);
            toReturn.setDate(date);
            toReturn.setCode(code);
            toReturn.setRef(ref);
            toReturn.setCurrency(currency);
            toReturn.setCashbackPurchase(cashbackPurchase);
            toReturn.setCashbackSocial(cashbackSocial);
            toReturn.setPayment(payment);
            toReturn.setNetAmount(netAmount);

        } else {
            toReturn.setStatus(TwoPayAppResponse.Status.ERROR);
            toReturn.setAppId(null);
        }
        return toReturn;
    }

}
