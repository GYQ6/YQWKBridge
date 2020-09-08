//
//  YQScriptMessageHandler.m
//  002---WKWebView
//
//  Created by GYQ on 2020/3/25.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import "YQScriptMessageHandler.h"

@interface YQScriptMessageHandler ()

@property (assign, nonatomic, readwrite) id <YQScriptMessageHandlerDelegate> delegate; /**<<#brief#>*/

@end

@implementation YQScriptMessageHandler

- (instancetype)initWithDelegate:(id<YQScriptMessageHandlerDelegate>)delegate
{
    if ([super init]) {
        _delegate = delegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

- (void)dealloc
{
    
}

@end
