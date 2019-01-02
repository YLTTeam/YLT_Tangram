//
//  YLT_TestVC.m
//  YLT_Tangram_Example
//
//  Created by 项普华 on 2019/1/2.
//  Copyright © 2019 xphaijj0305@126.com. All rights reserved.
//

#import "YLT_TestVC.h"
#import "YLT_TangramVC.h"

@interface YLT_TestVC ()

@end

@implementation YLT_TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"下单" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(240, 240));
    }];
    @weakify(self);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSDictionary *map = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"realPage" ofType:@"geojson"]] options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *urls = [map objectForKey:@"url"];
        NSArray<NSDictionary *> *pages = map[@"layout"];
        
        YLT_TangramVC *vc = [YLT_TangramVC tangramWithPages:pages requests:urls withDatas:nil];
        vc.itemLayouts = map[@"itemLayout"];
        vc.title = map[@"title"];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    self.view.backgroundColor = UIColor.redColor;
    
    NSLog(@"%@", self.ylt_params);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
