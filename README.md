# YQWKBridge

## 基于MKScriptMessageHandler封装YQWKBridge 处理Native和JavaScript交互的一套框架<br>
### 主要解决两个问题
1. controller和ScriptMessageHandler:<调用者> 循环引用问题; <br>解决该问题提供两种方案(1.使用代理 如:YQScriptMessageHandlerDelegate 2.使用中间调用者 如: YQWeakProxy);
2. 解决分散调用问题 集中处理交互的相关逻辑;

使用案例

    导入#import "YQWKBridge.h"<br>
    
    _bridge = [[YQWKBridge alloc] initWith:self.webView];  
    
    //js调用native
    [_bridge registerHandler:@"location" handler:^(YQMsgObject * _Nonnull msg) {  
        NSLog(@"%@", msg.handler);  
        [msg callback:@{@"lat": @"31.00", @"log":@"120"}];  
    }];  
    
    [_bridge registerHandler:@"scanQR" handler:^(YQMsgObject * _Nonnull msg) {  
        NSLog(@"msg.handler = %@ 交互成功", msg.handler);
    }];
    
    //OC 调用 js
    [_bridge injectMessageFuction:@"showAlert" withActionId:@"" withParams:@{@"name" : @"Native成功调起JS方法"}];
    
框架非常简单易用 如果使用过程中遇到问题请及时反馈: 18738193980@163.com
    
    
