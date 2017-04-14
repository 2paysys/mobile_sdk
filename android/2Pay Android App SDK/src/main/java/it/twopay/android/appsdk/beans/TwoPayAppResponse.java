/*
 * Copyright (c) 2016. 2pay.it
 */

package it.twopay.android.appsdk.beans;

/**
 * Created by 2pay.it on 21/01/16.
 */
public class TwoPayAppResponse {

    /**
     * Payment status
     */
    public enum Status {
        /**
         * Valid Payment status.
         */
        PAID,
        /**
         * Unpaid status.
         */
        UNPAID,
        /**
         * Error status.
         */
        ERROR;
    }

    private Status status;
    private String appId;
    private String transId;
    private String date;
    private String code;
    private String ref;
    private String currency;
    private double cashbackPurchase;
    private double cashbackSocial;
    private double payment;
    private double netAmount;


    /**
     * Gets payment status.
     *
     * @return the status
     */
    public Status getStatus() {
        return status;
    }

    /**
     * Sets payment status.
     *
     * @param status the status
     */
    public void setStatus(Status status) {
        this.status = status;
    }

    /**
     * Gets app id.
     *
     * @return the app id
     */
    public String getAppId() {
        return appId;
    }

    /**
     * Sets app id.
     *
     * @param appId the app id
     */
    public void setAppId(String appId) {
        this.appId = appId;
    }

    /**
     * Gets transaction id.
     *
     * @return the trans id
     */
    public String getTransId() {
        return transId;
    }

    /**
     * Sets transaction id.
     *
     * @param transId the trans id
     */
    public void setTransId(String transId) {
        this.transId = transId;
    }

    /**
     * Gets date of payment.
     *
     * @return the date
     */
    public String getDate() {
        return date;
    }

    /**
     * Sets date.
     *
     * @param date the date
     */
    public void setDate(String date) {
        this.date = date;
    }

    /**
     * Gets payment code.
     *
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * Sets payment code.
     *
     * @param code the code
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * Gets who has pay the trasaction.
     *
     * @return the ref
     */
    public String getRef() {
        return ref;
    }

    /**
     * Sets who has pay transaction.
     *
     * @param ref the ref
     */
    public void setRef(String ref) {
        this.ref = ref;
    }

    /**
     * Gets transaction currency.
     *
     * @return the currency
     */
    public String getCurrency() {
        return currency;
    }

    /**
     * Sets transaction currency.
     *
     * @param currency the currency
     */
    public void setCurrency(String currency) {
        this.currency = currency;
    }

    /**
     * Gets payment.
     *
     * @return the payment
     */
    public double getPayment() {
        return payment;
    }

    /**
     * Sets payment.
     *
     * @param payment the payment
     */
    public void setPayment(double payment) {
        this.payment = payment;
    }

    /**
     * Gets net amount.
     *
     * @return the net amount
     */
    public double getNetAmount() {
        return netAmount;
    }

    /**
     * Sets net amount.
     *
     * @param netAmount the net amount
     */
    public void setNetAmount(double netAmount) {
        this.netAmount = netAmount;
    }

    /**
     * Gets cashback purchase.
     *
     * @return the cashback purchase
     */
    public double getCashbackPurchase() {
        return cashbackPurchase;
    }

    /**
     * Sets cashback purchase.
     *
     * @param cashbackPurchase the cashback purchase
     */
    public void setCashbackPurchase(double cashbackPurchase) {
        this.cashbackPurchase = cashbackPurchase;
    }

    /**
     * Gets social cashback.
     *
     * @return the social cashback
     */
    public double getCashbackSocial() {
        return cashbackSocial;
    }

    /**
     * Sets social cashback.
     *
     * @param cashbackSocial the cashback social
     */
    public void setCashbackSocial(double cashbackSocial) {
        this.cashbackSocial = cashbackSocial;
    }

    @Override
    public String toString() {
        return "Payment: "+status+" | "+appId+" | "+transId+" | "+date+" | "+code+" | "+ref+" | "+currency+" | "+cashbackPurchase+" | "+cashbackSocial+" | "+payment+" | "+netAmount;
    }
}
