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
#import <RegexKitLite/RegexKitLite.h>

@interface YLTViewController ()

@property (nonatomic, strong) YLT_TangramView *tangramView;

@property (nonatomic, strong) id pageData;

@end

@implementation YLTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSDictionary *map = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"realPage" ofType:@"geojson"]] options:NSJSONReadingAllowFragments error:nil];
    NSArray<NSDictionary *> *pages = map[@"layout"];
    NSDictionary *pageDatas = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"real" ofType:@"geojson"]] options:NSJSONReadingAllowFragments error:nil];
    [YLT_TangramManager shareInstance].tangramImageURLString = ^NSString *(NSString *path) {
        path = [NSString stringWithFormat:@"https://img2.ultimavip.cn/%@?imageView2/2/w/153/h/153&imageslim", path];
        return path;
    };

    [YLT_TangramManager shareInstance].tangramViewFromPageModel = ^UIView *(NSDictionary *data) {
        NSLog(@"%@", data);
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColor.blueColor;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = UIColor.greenColor;
        [view addSubview:imageView];
        imageView.frame = CGRectMake(0, 0, 120, 120);
        return view;
    };
    
    YLT_TangramVC *vc = [YLT_TangramVC tangramWithPages:pages withDatas:pageDatas.mutableCopy];

    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
