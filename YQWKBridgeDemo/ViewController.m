//
//  ViewController.m
//  YQWKBridgeDemo
//
//  Created by GYQ on 2020/4/9.
//  Copyright © 2020 YQWKBridgeDemoGYQ.com. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "YQWKBridge.h"

@interface ViewController ()<WKNavigationDelegate, WKUIDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) YQWKBridge *bridge; /**<<#brief#>*/
@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubUI];
    [self configJSBridge];
}

- (void)configSubUI
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    NSString *js = @"function myAlert() {\
        alert('这就是js啊');\
    }";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserScript *alertScript = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [wkUController addUserScript:wkUScript];
    [wkUController addUserScript:alertScript];
    configuration.userContentController = wkUController;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"callJS" style:UIBarButtonItemStyleDone target:self action:@selector(callJSEvent:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

/*
 交互事件统一管理
 */
/// 交互事件 管理
- (void)configJSBridge
{
    _bridge = [[YQWKBridge alloc] initWith:self.webView];
    [_bridge registerHandler:@"location" handler:^(YQMsgObject * _Nonnull msg) {
        NSLog(@"%@", msg.handler);
        [msg callback:@{@"lat": @"31.00", @"log":@"120"}];
    }];
    [_bridge registerHandler:@"scanQR" handler:^(YQMsgObject * _Nonnull msg) {
        NSLog(@"msg.handler = %@ 交互成功", msg.handler);
    }];
}
///native调用js方法
- (void)callJSEvent:(UIBarButtonItem *)bar
{
    //OC 调用 js
    [_bridge injectMessageFuction:@"showAlert" withActionId:@"" withParams:@{@"name" : @"Native成功调起JS方法"}];
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end
