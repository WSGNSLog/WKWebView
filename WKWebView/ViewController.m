//
//  ViewController.m
//  WKWebView
//
//  Created by wuxue on 2016/12/30.
//  Copyright © 2016年 wsg. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "AFNetworkReachabilityManager.h"
#import "MBProgressHUD+MJ.h"
#import "AFHTTPRequestOperationManager.h"


#define MainColor     UIColorFromRGB(0x1FB5EC)  //主色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define WebViewNav_TintColor ([UIColor orangeColor])
#define Width self.view.bounds.size.width
#define Height self.view.bounds.size.height
@interface ViewController ()
@property (assign,nonatomic) NSUInteger loadCount;
@property (assign,nonatomic) UIProgressView *progressView;
@property (assign,nonatomic) WKWebView *wkWebView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIProgressView *progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0.1, Width, 0)];
    progress.tintColor = MainColor;
    progress.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progress];
    self.progressView = progress;
    
    WKWebView *wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - 44)];
    wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view insertSubview:wkWebView belowSubview:progress];
    self.wkWebView = wkWebView;
    
    [self loadData];
}

- (void)loadData{
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestUrl];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"请检查网络"];
        
    }];
    [operation1 start];
    
}
- (void)requestUrl{
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:req];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else{
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //  在发送请求之前，决定是否跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    
    
}



- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    // 页面开始加载时调用
    
    
}


- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    // 接收到服务器跳转请求之后调用
    
    
}





- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler{
    
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling ,nil);
    
    
}


//以下三个是连续调用




- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    // 在收到响应后，决定是否跳转和发送请求之前那个允许配套使用
    decisionHandler(WKNavigationResponsePolicyAllow);
    
    
}



- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
    // 当内容开始返回时调用
    
    
    
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    // 页面加载完成之后调用
    
    
    
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}
-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end
