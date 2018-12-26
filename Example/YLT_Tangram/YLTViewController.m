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
    NSArray<NSDictionary *> *pages = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TangramMenuPage" ofType:@"geojson"]] options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *pageDatas = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TangramMenuData" ofType:@"geojson"]] options:NSJSONReadingAllowFragments error:nil];
//    [YLT_TangramManager shareInstance].splitImageURLString = ^NSString *(NSString *path) {
//        path = [NSString stringWithFormat:@"https://img2.ultimavip.cn/%@?imageView2/2/w/153/h/153&imageslim", path];
//        return path;
//    };
//
    YLT_TangramVC *vc = [YLT_TangramVC tangramWithPages:pages withDatas:pageDatas];

    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
