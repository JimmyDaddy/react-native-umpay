//
//  RCTUmpay.h
//  RCTUmpay
//
//  Created by JimmyDaddy on 2017/7/21.
//  Copyright © 2017年 JimmyDaddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>
#import <UIKit/UIViewController.h>


@interface RCTUmpay : NSObject <RCTBridgeModule>

@property RCTPromiseRejectBlock myReject; // reject function
@property RCTPromiseResolveBlock myResolve;//resolve function

@end
