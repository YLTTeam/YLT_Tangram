//
//  YLTViewController.m
//  YLT_Tangram
//
//  Created by xphaijj0305@126.com on 12/19/2018.
//  Copyright (c) 2018 xphaijj0305@126.com. All rights reserved.
//

#import "YLTViewController.h"
#import "YLT_Tangram.h"
#import <YLT_Kit/YLT_Kit.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <AFNetworking/AFNetworking.h>
#import <RegexKitLite/RegexKitLite.h>
#import <YLT_Crypto/YLT_Crypto.h>

@interface YLTViewController ()

@property (nonatomic, strong) YLT_TangramView *tangramView;

@property (nonatomic, strong) id pageData;

@end

@implementation YLTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [YLT_TangramManager shareInstance].tangramKey = @"woBLXnIJakCTnqyU";
//    uint8_t iv[16] = {0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08, 0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08}; //直接影响加密结果!
//    NSData *ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
//    [YLT_TangramManager shareInstance].tangramIv = ivData;
//
//    NSData *data = [@"123" dataUsingEncoding:NSUTF8StringEncoding];
//    data = [YLT_AESCrypto encryptData:data keyString:[YLT_TangramManager shareInstance].tangramKey iv:[YLT_TangramManager shareInstance].tangramIv];
//
////    uint8_t origin[] = {0x01, 0x02, };
////    NSData *data = [NSData dataWithBytes:origin length:sizeof(origin)];
//    data = [YLT_AESCrypto dencryptData:data keyString:[YLT_TangramManager shareInstance].tangramKey iv:[YLT_TangramManager shareInstance].tangramIv];
//    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [YLT_TangramManager shareInstance].tangramKey = @"woBLXnIJakCTnqyU";
    uint8_t iv[16] = {0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08, 0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08}; //直接影响加密结果!
    NSData *ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    [YLT_TangramManager shareInstance].tangramIv = ivData;
    
    [YLT_TangramManager shareInstance].tangramImageURLString = ^NSString *(NSString *path) {
        path = [NSString stringWithFormat:@"https://img2.ultimavip.cn/%@?imageView2/2/w/153/h/153&imageslim", path];
        return path;
    };
    [YLT_TangramManager shareInstance].tangramRequest = ^(NSArray<TangramRequest *> *requests, void (^success)(NSDictionary *result)) {
        //做对应的网络请求
        static AFHTTPSessionManager *sessionManager = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://gw-dev.ultimablack.cn"]];
            sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
            sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", nil];
        });
        __block NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        dispatch_group_t group = dispatch_group_create();
        [requests enumerateObjectsUsingBlock:^(TangramRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_group_enter(group);
            [sessionManager POST:obj.path parameters:obj.params progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]] && [((NSDictionary *) responseObject).allKeys containsObject:@"data"]) {
                    [data setObject:responseObject[@"data"] forKey:obj.keyname];
                } else {
                    [data setObject:responseObject forKey:obj.keyname];
                }
                dispatch_group_leave(group);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [data setObject:error forKey:obj.keyname];
                dispatch_group_leave(group);
            }];
        }];
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            if (success) {
                success(data);
            }
        });
    };
    
    [YLT_TangramManager shareInstance].tangramViewFromPageModel = ^UIView *(NSDictionary *data) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColor.blueColor;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = UIColor.greenColor;
        [view addSubview:imageView];
        imageView.frame = CGRectMake(0, 0, 120, 120);
        return view;
    };
    
    
    
    
    UIViewController *target = [self ylt_routerToURL:@"ylt://YLT_TangramVC/tangramWithRequestParams:?path=http://img2.ultimavip.cn/vv/c609a6509dca64d3" isClassMethod:YES arg:nil completion:^(NSError *error, id response) {
    }];
    [self.navigationController pushViewController:target animated:YES];

    return;
    
    
    
//    NSDictionary *map = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"realPage" ofType:@"geojson"]] options:NSJSONReadingAllowFragments error:nil];
//    NSDictionary *urls = [map objectForKey:@"url"];
//    NSArray<NSDictionary *> *pages = map[@"layout"];
//
//    YLT_TangramVC *vc = [YLT_TangramVC tangramWithPages:pages requests:urls withDatas:nil];
//    vc.itemLayouts = map[@"itemLayout"];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
