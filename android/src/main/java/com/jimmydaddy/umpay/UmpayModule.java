package com.jimmydaddy.umpay;

import android.app.Activity;
import android.content.Intent;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.umpay.quickpay.UmpPayInfoBean;
import com.umpay.quickpay.UmpayQuickPay;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

/**
 * Created by jimmydaddy on 2017/7/21.
 */

public class UmpayModule extends ReactContextBaseJavaModule {

    public static final int REQUEST_CODE = 10000;
    private Promise promise;

    public UmpayModule(ReactApplicationContext reactContext) {
        super(reactContext);
        EventBus.getDefault().register(this);

    }

    /**
     * 绑定银行卡
     * @param idententityCode 身份证
     * @param cardHolder 持证人
     * @param merCustId  ****
     * @param merId 商家ID
     * @param signInfo 签名信息
     * @param cardType 卡类型（借记卡，信用卡）
     * @param shortBankName 银行缩写
     * @param editFlag 是否可修改
     * @param promise 结果
     */
    @ReactMethod
    public void bindCard(String idententityCode, String cardHolder, String merCustId, String merId, String signInfo, String cardType, String shortBankName, String editFlag, Promise promise){
        UmpPayInfoBean infoBean = new UmpPayInfoBean();
        infoBean.setCardHolder(cardHolder);
        infoBean.setIdentityCode(idententityCode);
        infoBean.setEditFlag(editFlag);
        try {
            Boolean result = UmpayQuickPay.requestSign(getCurrentActivity(), merId, merCustId, cardType, shortBankName, signInfo, infoBean, REQUEST_CODE);
            if (!result){
                promise.reject("1002", "绑定失败!");
            }
        } catch (Exception e) {
            promise.reject("1002", "绑定失败!");
        }

        this.promise = promise;

    }

    /**
     * 支付
     * @param idententityCode
     * @param tradeNo
     * @param cardHolder
     * @param merCustId
     * @param cardType
     * @param shortBankName
     * @param editFlag
     * @param promise
     */
    @ReactMethod
    public void pay(String idententityCode, String tradeNo, String cardHolder, String merCustId, String cardType, String shortBankName, String editFlag, Promise promise){
        UmpPayInfoBean infoBean = new UmpPayInfoBean();
        infoBean.setCardHolder(cardHolder);
        infoBean.setIdentityCode(idententityCode);
        infoBean.setEditFlag(editFlag);
        try {
            Boolean result = UmpayQuickPay.requestPayWithBind(getCurrentActivity(),tradeNo, merCustId, cardType, shortBankName, infoBean, REQUEST_CODE);
            if (!result){
                promise.reject("1002", "支付失败!");
            }
        } catch (Exception e) {
            promise.reject("1002", "支付失败!");
        }

        this.promise = promise;

    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void opResult(Intent intent){
        if (intent != null && intent.hasExtra("umpResultCode")){
            String code = intent.getStringExtra("umpResultCode");
            if (code.equals("0000")){
                this.promise.resolve("0000");
            } else {
                this.promise.reject(intent.getStringExtra("umpResultCode"), intent.getStringExtra("umpResultMessage"));
            }

            this.promise = null;
        }
    }



    @Override
    public String getName() {
        return "Umpay";
    }

    @Override
    public void onCatalystInstanceDestroy() {
        EventBus.getDefault().unregister(this);
        super.onCatalystInstanceDestroy();

    }
}
