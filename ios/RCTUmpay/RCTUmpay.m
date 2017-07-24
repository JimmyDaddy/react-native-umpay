//
//  RCTUmpay.m
//  RCTUmpay
//
//  Created by JimmyDaddy on 2017/7/21.
//  Copyright © 2017年 JimmyDaddy. All rights reserved.
//

#import "RCTUmpay.h"
#import <React/RCTEventDispatcher.h>
#import "Umpay.h"
#import "UmpayElements.h"
#import <React/RCTBridgeModule.h>


@implementation RCTUmpay


//static int sharedObj = 0;
//static RCTPromiseResolveBlock umpayBindCardCallback;

@synthesize bridge = _bridge;
@synthesize myResolve = _myResolve;
@synthesize myReject = _myReject;

RCT_EXPORT_MODULE();


- (id) init {
    self = [super init];
    return self;
}

RCT_EXPORT_METHOD(bindCard: (NSString *)idententityCode_key
                  cardHolder:(NSString *)cardHolder_key
                  merCustId:(NSString *)merCustId_key
                  merId:(NSString *)merId_key
                  signInfo:(NSString *)signInfo_key
                  cardType:(NSString *)cardType_key
                  shortBankName:(NSString *)shortBankName_key
                  editFlag:(NSString *)editFlag_key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject
                  ){
    //将promise代理到成员变量
    _myResolve = resolve;
    _myReject = reject;
    UIViewController *rootViewController =[UIApplication sharedApplication].delegate.window.rootViewController;
    
    UmpayElements* inPayInfo = [[UmpayElements alloc]init];
    [inPayInfo setIdentityCode:idententityCode_key];
    [inPayInfo setEditFlag:editFlag_key];
    [inPayInfo setCardHolder:cardHolder_key];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payResult:) name:@"payResult" object: nil];
    
    if([Umpay sign:merId_key
                merCustId:merCustId_key
                signInfo:signInfo_key
                shortBankName:shortBankName_key
                cardType:cardType_key
                payDic:inPayInfo
                rootViewController:rootViewController
        ] == NO) {
        _myReject(@"1002", @"绑定失败", nil);
    }
}

RCT_EXPORT_METHOD(pay:(NSString *)idententityCode_key
                  tradeNo:(NSString *)tradeNo_key
                  cardHolder:(NSString *)cardHolder_key
                  merCustId:(NSString *)merCustId_key
                  cardType:(NSString *)cardType_key
                  shortBankName:(NSString *)shortBankName_key
                  editFlag:(NSString *)editFlag_key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    //将promise代理到成员变量
    _myResolve = resolve;
    _myReject = reject;
    UIViewController *rootViewController =[UIApplication sharedApplication].delegate.window.rootViewController;

    UmpayElements* inPayInfo = [[UmpayElements alloc]init];
    [inPayInfo setIdentityCode:idententityCode_key];
    [inPayInfo setEditFlag:editFlag_key];
    [inPayInfo setCardHolder:cardHolder_key];
    
    if([Umpay pay:tradeNo_key
          merCustId:merCustId_key
        shortBankName:shortBankName_key
        cardType:cardType_key
        payDic:inPayInfo
        rootViewController:rootViewController] == NO) {
        _myReject(@"1002", @"绑定失败", nil);
    }
    
}


//获取通知结果
-(void)payResult:(NSNotification*)notification{
    //  取消监听的通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSDictionary* info = notification.userInfo;
    NSLog(@"NSNotificationCenter defaultCenter)%@ %@ %@",[info valueForKey:@"orderId"],[info valueForKey:@"retCode"],[info valueForKey:@"retMsg"]);
    if([info valueForKey:@"retCode"] == @"1001"){
        _myReject([info valueForKey:@"retCode"], [info valueForKey:@"retMsg"], nil);
    } else {
        _myResolve(info);
    }
}

@end
