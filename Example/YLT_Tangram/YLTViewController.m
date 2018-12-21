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
    NSArray<NSString *> *list = @[@"TangramMenu", @"TangramMenuPage"];
    [list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [YLT_TangramManager loadTemplateKeyname:obj path:[[NSBundle mainBundle] pathForResource:obj ofType:@"geojson"] classname:obj];
    }];
    
    
    self.pageData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TangramMenuData" ofType:@"geojson"]] options:NSJSONReadingAllowFragments error:nil];
    self.tangramView = [[YLT_TangramGridLayout alloc] init];
    [self.view addSubview:self.tangramView];
    [self.tangramView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.tangramView.pageData = self.pageData;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
