//
//  UmpayElements.h
//  QuickPay
//
//  Created by 王 on 13-11-27.
//  Copyright (c) 2013年 Umpay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UmpayElements : NSObject
//以下为最终支付时的支付要素
//电话
@property (nonatomic, retain) NSString* mobileId;
//身份证号
@property (nonatomic, retain) NSString* identityCode;
//姓名
@property (nonatomic, retain) NSString* cardHolder;
//传入的卡号
@property (nonatomic, retain) NSString* text_cardId;
//编辑标示位——商户传入使用
@property (nonatomic, retain) NSString* editFlag;

@end
