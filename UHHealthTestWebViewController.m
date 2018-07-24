//
//  UHHealthTestWebViewController.m
//  Uhealth
//
//  Created by Biao Geng on 2018/4/20.
//  Copyright © 2018年 Peng Zhou. All rights reserved.
//

#import "UHHealthTestWebViewController.h"
#import "UHUserModel.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface UHHealthTestWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NJKWebViewProgress *webViewProgress;
@property (nonatomic,strong) NJKWebViewProgressView *webViewProgressView;
@end

@implementation UHHealthTestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.title = @"健康自测";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [UIWebView new];
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/#/healthySelfTest/dailyTestIndexIos",ZPBaseUrl]]]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://wapyyk.39.net/page/html5/quest/questlist_uhealth.jsp"]]]];
    self.webView.delegate = self;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    UIBarButtonItem *popItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    popItem.imageInsets = UIEdgeInsetsMake(0, -45, 0, 0);
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.rightBarButtonItem = popItem;
    
    [self initProgressView];
}

- (void)back {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self close];
    }
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('app-top-byq')[0].hidden = true"];
}

- (void)initProgressView {
    self.webViewProgress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.webViewProgress;
    self.webViewProgress.webViewProxyDelegate = self;
    self.webViewProgress.progressDelegate = self;
    
    self.webViewProgressView = [[NJKWebViewProgressView alloc] init];
    self.webViewProgressView.frame = CGRectMake(0, kSafeAreaTopHeight, SCREEN_WIDTH, 2);
    self.webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.webViewProgressView setProgress:0 animated:YES];
    [self.view addSubview:self.webViewProgressView];
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.webViewProgressView setProgress:progress animated:NO];
}

@end
