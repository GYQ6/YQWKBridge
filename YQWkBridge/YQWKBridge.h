//
//  YQWKBridge.h
//  002---WKWebView
//
//  Created by GYQ on 2020/3/24.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "YQMsgObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HandlerBlock)(YQMsgObject *msg);

@interface YQWKBridge : NSObject

/// 初始化交互管理类
/// @param webView 传入webView
- (id)initWith:(WKWebView *)webView;

/// 注册native 和 JS 交互方法
/// @param handlerName JS 调 native 的方法名
/// @param handler 回调block
- (void)registerHandler:(NSString *)handlerName handler:(HandlerBlock)handler;

/// 注入
/// @param name 注入方法名
/// @param actionId 方法标识
/// @param params 注入相关参数
- (void)injectMessageFuction:(NSString *)name withActionId:(NSString *)actionId withParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
