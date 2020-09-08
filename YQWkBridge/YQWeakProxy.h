//
//  YQWeakProxy.h
//  YQWKBridgeDemo
//
//  Created by GYQ on 2020/4/9.
//  Copyright © 2020 YQWKBridgeDemoGYQ.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/**方式二 NSProxy中间代理*/
@interface YQWeakProxy : NSProxy<WKScriptMessageHandler>
- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
