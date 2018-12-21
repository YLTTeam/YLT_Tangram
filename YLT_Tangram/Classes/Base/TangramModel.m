//
// TangramModel.m 
//
// Created By 项普华 Version: 2.0
// Copyright (C) 2018/12/20  By AlexXiang  All rights reserved.
// email:// xiangpuhua@126.com  tel:// +86 13316987488 
//
//

#import "TangramModel.h"
#import <MJExtension/MJExtension.h>
#import <YLT_BaseLib/YLT_BaseLib.h>


@implementation TangramView

- (id)init {
	self = [super init];
	if (self) {
		self.tangramId = 0;
		self.layoutWidth = @"";
		self.layoutHeight = @"";
		self.layoutGravity = 48;
		self.autoDimX = 0;
		self.autoDimY = 0;
		self.autoDimDirection = 0;
		self.minWidth = 0;
		self.minHeight = 0;
		self.padding = 0;
		self.paddingLeft = 0;
		self.paddingRight = 0;
		self.paddingTop = 0;
		self.paddingBottom = 0;
		self.layoutMargin = 0;
		self.layoutMarginLeft = 0;
		self.layoutMarginRight = 0;
		self.layoutMarginTop = 0;
		self.layoutMarginBottom = 0;
		self.background = @"clearColor";
		self.borderWidth = 0;
		self.borderColor = @"clearColor";
		self.borderRadius = 0;
		self.borderLocation = 0;
		self.hidden = NO;
		self.dataTag = nil;
		self.keypath = @"";
		self.action = [[NSMutableArray alloc] init];
		self.classname = @"";
		self.identify = @"";
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	return @{
			@"tangramId":@[@"id"],
				};
}

+ (NSDictionary *)ylt_classInArray {
	return @{
			@"action":@"string",
				};
}

@end


@implementation TangramLabel

- (id)init {
	self = [super init];
	if (self) {
		self.text = @"";
		self.textColor = @"666666";
		self.fontSize = 16;
		self.textStyle = 0;
		self.lines = 1;
		self.maxLines = 0;
		self.gravity = 0;
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	return @{
				};
}

+ (NSDictionary *)ylt_classInArray {
	return @{
				};
}

@end


@implementation TangramImage

- (id)init {
	self = [super init];
	if (self) {
		self.src = @"";
		self.scaleType = 0;
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	return @{
				};
}

+ (NSDictionary *)ylt_classInArray {
	return @{
				};
}

@end


@implementation TangramFrameLayout

- (id)init {
	self = [super init];
	if (self) {
		self.subTangrams = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	return @{
				};
}

+ (NSDictionary *)ylt_classInArray {
	return @{
			@"subTangrams":@"TangramView",
				};
}

@end


@implementation TangramVHLayout

- (id)init {
	self = [super init];
	if (self) {
		self.orientation = 1;
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	return @{
				};
}

+ (NSDictionary *)ylt_classInArray {
	return @{
				};
}

@end


@implementation TangramRatioLayout

- (id)init {
	self = [super init];
	if (self) {
		self.orientation = 0;
		self.layoutRatio = 1;
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	return @{
				};
}

+ (NSDictionary *)ylt_classInArray {
	return @{
				};
}

@end


@implementation TangramGridLayout

- (id)init {
	self = [super init];
	if (self) {
		self.colCount = 1;
		self.itemHeight = 0;
		self.itemVerticalMargin = 0;
		self.itemHorizontalMargin = 0;
		self.itemName = @"";
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	return @{
				};
}

+ (NSDictionary *)ylt_classInArray {
	return @{
				};
}

@end
