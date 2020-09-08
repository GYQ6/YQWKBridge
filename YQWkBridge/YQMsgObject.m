//
//  YQMsgObject.m
//  002---WKWebView
//
//  Created by GYQ on 2020/3/24.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import "YQMsgObject.h"

@implementation YQMsgObject

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if ([super init]) {
        self.handler = dict[@"handler"];
        self.callbackID = dict[@"callbackID"];
        self.callbackFunction = dict[@"callbackFunction"];
    }
    return self;
}


- (void)callback:(NSDictionary *)result
{
    self.callback(result);
}

@end
