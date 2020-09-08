//
//  YQWKBridge.m
//  002---WKWebView
//
//  Created by GYQ on 2020/3/24.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import "YQWKBridge.h"
#import "YQWeakProxy.h"

@interface YQWKBridge ()
@property (weak, nonatomic) WKWebView *webView; /**<<#brief#>*/
@property (strong, nonatomic) NSMutableDictionary *handlerMap; /**<<#brief#>*/
@property (strong, nonatomic) YQWeakProxy *proxy; /**<<#brief#>*/
@end

@implementation YQWKBridge

- (id)initWith:(WKWebView *)webView
{
    if ([super init]) {
        self.webView = webView;
        self.handlerMap = [NSMutableDictionary dictionary];
        //通过中间调度者 解决循环引用问题
        self.proxy = [[YQWeakProxy alloc] initWithTarget:self];
        [self configJSBridge];
    }
    return self;
}

- (void)configJSBridge
{
    [self.webView.configuration.userContentController addScriptMessageHandler:self.proxy name:NSStringFromClass([self class])];
}

- (void)registerHandler:(NSString *)handlerName handler:(HandlerBlock)handler
{
    if (handlerName && handler) {
        [self.handlerMap setObject:handler forKey:handlerName];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSDictionary *msgBody = message.body;
    if (msgBody) {
        YQMsgObject *msg = [[YQMsgObject alloc] initWithDictionary:msgBody];
        HandlerBlock handler = [self.handlerMap objectForKey:msg.handler];
        //处理回调
        if (msg.callbackID && msg.callbackID.length > 0) {
            //进行回调
            JSResponseCallback callback = ^(NSDictionary *responseData)
            {
                [self injectMessageFuction:msg.callbackFunction withActionId:msg.callbackID withParams:responseData];
            };
            [msg setCallback:callback];
        };
        if (handler) {
            handler(msg);
        }
    }
}

// 字典JSON化
- (NSString *)_serializeMessageData:(id)message{
    if (message) {
        return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:message options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (void)injectMessageFuction:(NSString *)name withActionId:(NSString *)actionId withParams:(NSDictionary *)params{
    if (!params) params = @{};
    NSString *paramsString = [self _serializeMessageData:params];
    NSString* javascriptCommand = [NSString stringWithFormat:@"%@('%@', %@);", name, actionId, paramsString];
    if ([[NSThread currentThread] isMainThread]) {
        [self.webView evaluateJavaScript:javascriptCommand completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            
        }];
    } else {
        __strong typeof(self)strongSelf = self;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [strongSelf.webView evaluateJavaScript:javascriptCommand completionHandler:nil];
        });
    }
}

- (void)dealloc
{
    NSLog(@"YQWKBridge:%@", NSStringFromSelector(_cmd));
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:NSStringFromClass([self class])];
    
}

@end
