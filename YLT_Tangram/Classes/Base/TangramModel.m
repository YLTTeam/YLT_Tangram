//
// TangramModel.m 
//
// Created By 项普华 Version: 2.0
// Copyright (C) 2018/12/27  By AlexXiang  All rights reserved.
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
		self.layoutWidth = -1;
		self.layoutHeight = -1;
		self.layoutRation = 0;
		self.layoutGravity = 48;
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
		self.action = @"";
		self.type = @"";
		self.identify = @"";
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
			@"tangramId":@[@"id"],
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

@end


@implementation TangramLabel

- (id)init {
	self = [super init];
	if (self) {
		self.text = @"";
		self.textColor = @"666666";
		self.fontSize = 16;
		self.textStyle = 1;
		self.lines = 1;
		self.maxLines = 0;
		self.gravity = 0;
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
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
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

@end


@implementation TangramFrameLayout

- (id)init {
	self = [super init];
	if (self) {
		self.orientation = 1;
		self.subTangrams = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
			@"subTangrams":@"TangramView",
				}];
	return result;
}

@end


@implementation TangramGridLayout

- (id)init {
	self = [super init];
	if (self) {
		self.column = 1;
		self.itemHeight = 0;
		self.itemVerticalMargin = 0;
		self.itemHorizontalMargin = 0;
		self.itemName = @"";
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

@end


@implementation TangramBannerLayout

- (id)init {
	self = [super init];
	if (self) {
		self.duration = 0;
		self.normalColor = @"666666";
		self.selectedColor = @"ffffff";
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

@end
