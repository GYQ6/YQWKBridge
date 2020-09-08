//
//  YQScriptMessageHandler.h
//  002---WKWebView
//
//  Created by GYQ on 2020/3/25.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


NS_ASSUME_NONNULL_BEGIN

/**方式一 通过协议的方式*/

@protocol YQScriptMessageHandlerDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface YQScriptMessageHandler : NSObject <WKScriptMessageHandler>

@property (assign, nonatomic, readonly) id <YQScriptMessageHandlerDelegate> delegate; /**<<#brief#>*/

- (instancetype)initWithDelegate:(id<YQScriptMessageHandlerDelegate>)delegate;
 
@end
NS_ASSUME_NONNULL_END
