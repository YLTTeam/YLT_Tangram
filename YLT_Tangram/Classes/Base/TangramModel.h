//
// TangramModel.h 
//
// Created By 项普华 Version: 2.0
// Copyright (C) 2018/12/21  By AlexXiang  All rights reserved.
// email:// xiangpuhua@126.com  tel:// +86 13316987488 
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BaseCollection.h"
typedef NS_ENUM(NSUInteger, LayoutGravity) {
    LayoutGravity_Left = 1,
    LayoutGravity_Right = 2,
    LayoutGravity_Top = 4,
    LayoutGravity_Bottom = 8,
    LayoutGravity_V_center = 16,
    LayoutGravity_H_center = 32
};
typedef NS_ENUM(NSUInteger, DimDirection) {
    DimDirection_X = 1,
    DimDirection_Y = 2,
    DimDirection_NONE = 4
};
typedef NS_ENUM(NSUInteger, CornerLocation) {
    CornerLocation_TopLeft = 1,
    CornerLocation_TopRight = 2,
    CornerLocation_BottomLeft = 4,
    CornerLocation_BottomRight = 8,
    CornerLocation_ALL = 16,
};
typedef NS_ENUM(NSUInteger, TextStyle) {
    TextStyle_Normal = 1,
    TextStyle_Bold = 2,
    TextStyle_Italic = 4,
    TextStyle_Strike = 8,
    TextStyle_UnderLine = 16
};
typedef NS_ENUM(NSUInteger, ScaleType) {
    ScaleType_Fit_start = 1,
    ScaleType_Fit_xy = 2,
    ScaleType_Matrix = 4,
    ScaleType_Center = 8,
    ScaleType_Center_crop = 16,
    ScaleType_Center_inside = 32,
    ScaleType_Fit_center = 64,
    ScaleType_Fit_end = 128,
};
typedef NS_ENUM(NSUInteger, Orientation) {
    Orientation_H = 1,
    Orientation_V = 2
};


@class TangramView;
@class TangramLabel;
@class TangramImage;
@class TangramFrameLayout;
@class TangramVHLayout;
@class TangramRatioLayout;
@class TangramGridLayout;


@interface TangramView : YLT_BaseModel {
}
/** 组件id */
@property (readwrite, nonatomic, assign) NSInteger tangramId;
/** 组件的布局宽度，与Android里的概念类似，写绝对值的时候表示绝对宽高，match_parent 表示尽可能撑满父容器提供的宽高，wrap_content 表示根据自身内容的宽高来布局 */
@property (readwrite, nonatomic, strong) NSString *layoutWidth;
/** 组件的布局宽度，与Android里的概念类似，写绝对值的时候表示绝对宽高，match_parent 表示尽可能撑满父容器提供的宽高，wrap_content 表示根据自身内容的宽高来布局 */
@property (readwrite, nonatomic, strong) NSString *layoutHeight;
/** 描述组件在容器中的对齐方式，left(1)：靠左，right(2)：靠右，top(4)：靠上，bottom(8)：靠底，v_center(16)：垂直方向居中，h_center(32)：水平方向居中，可用或组合描述  比如：靠左+靠上  1+4 = 5 */
@property (readwrite, nonatomic, assign) LayoutGravity layoutGravity;
/** 组件宽高比计算的横向值 */
@property (readwrite, nonatomic, assign) CGFloat autoDimX;
/** 组件宽高比计算的竖向值 */
@property (readwrite, nonatomic, assign) CGFloat autoDimY;
/** X、Y、NONE  组件在布局中的基准方向，用于计算组件的宽高比，与 autoDimX、autoDimY 配合使用，设置了这三个属性时，在计算组件尺寸时具有更高的优先级。当 autoDimDirection=X 时，组件的宽度由 layoutWidth 和父容器决策决定，但高度 = width * (autoDimY  autoDimX)，当 autoDimDirection=Y 时，组件的高度由 layoutHeight 和父容器决策决定，但宽度 = height * (autoDimX  autoDimY) */
@property (readwrite, nonatomic, assign) DimDirection autoDimDirection;
/** 最小宽度 */
@property (readwrite, nonatomic, assign) CGFloat minWidth;
/** 最小高度 */
@property (readwrite, nonatomic, assign) CGFloat minHeight;
/** 同时设置 4 个内边距 */
@property (readwrite, nonatomic, assign) CGFloat padding;
/** 左内边距，优先级高于 padding */
@property (readwrite, nonatomic, assign) CGFloat paddingLeft;
/** 右内边距，优先级高于 padding */
@property (readwrite, nonatomic, assign) CGFloat paddingRight;
/** 上内边距，优先级高于 padding */
@property (readwrite, nonatomic, assign) CGFloat paddingTop;
/** 下内边距，优先级高于 padding */
@property (readwrite, nonatomic, assign) CGFloat paddingBottom;
/** 同时设置 4 个外边距 */
@property (readwrite, nonatomic, assign) CGFloat layoutMargin;
/** 左外边距，优先级高于 layoutMargin */
@property (readwrite, nonatomic, assign) CGFloat layoutMarginLeft;
/** 右外边距，优先级高于 layoutMargin */
@property (readwrite, nonatomic, assign) CGFloat layoutMarginRight;
/** 上外边距，优先级高于 layoutMargin */
@property (readwrite, nonatomic, assign) CGFloat layoutMarginTop;
/** 下外边距，优先级高于 layoutMargin */
@property (readwrite, nonatomic, assign) CGFloat layoutMarginBottom;
/** 背景色 ffffff  ffffff00 后两位表示alpha */
@property (readwrite, nonatomic, strong) NSString *background;
/** 边框宽度 */
@property (readwrite, nonatomic, assign) CGFloat borderWidth;
/** 边框颜色 */
@property (readwrite, nonatomic, strong) NSString *borderColor;
/** 边框四个角的圆角半径 */
@property (readwrite, nonatomic, assign) CGFloat borderRadius;
/**  */
@property (readwrite, nonatomic, assign) CornerLocation borderLocation;
/** 可见性 hidden 为YES 时隐藏显示 */
@property (readwrite, nonatomic, assign) BOOL hidden;
/** 数据 */
@property (readwrite, nonatomic, strong) id dataTag;
/** key path 路径 */
@property (readwrite, nonatomic, strong) NSString *keypath;
/** 当action部分有值的时候，给控件添加点击事件 */
@property (readwrite, nonatomic, strong) NSMutableArray<NSString *> *action;
/** 类名 */
@property (readwrite, nonatomic, strong) NSString *type;
/** 重新标记，没有值，则使用classname */
@property (readwrite, nonatomic, strong) NSString *identify;

@end


@interface TangramLabel : TangramView {
}
/** 文本内容 */
@property (readwrite, nonatomic, strong) NSString *text;
/** 字体颜色 */
@property (readwrite, nonatomic, strong) NSString *textColor;
/** 字号大小 */
@property (readwrite, nonatomic, assign) CGFloat fontSize;
/** normal：默认样式，bold：加粗，itlaic：斜体，strike：删除线，underline：下划线 */
@property (readwrite, nonatomic, assign) TextStyle textStyle;
/** 固定行数，设为0表示不固定行数 */
@property (readwrite, nonatomic, assign) NSInteger lines;
/** 最大行数，需要配合lines=0使用 */
@property (readwrite, nonatomic, assign) NSInteger maxLines;
/** 描述内容的对齐，比如文字在文本组件里的位置、原子组件在容器里的位置，left：靠左，right：靠右，top：靠上，bottom：靠底，v_center：垂直方向居中，h_center：水平方向居中，可用或组合描述(iOS暂只支持水平方向) */
@property (readwrite, nonatomic, assign) LayoutGravity gravity;

@end


@interface TangramImage : TangramView {
}
/** 图片资源，本地资源名或远程图片地址 */
@property (readwrite, nonatomic, strong) NSString *src;
/** 缩放模式(iOS仅支持部分模式，详见代码) */
@property (readwrite, nonatomic, assign) ScaleType scaleType;

@end


@interface TangramFrameLayout : TangramView {
}
/** 子控件 */
@property (readwrite, nonatomic, strong) NSMutableArray<TangramView *> *subTangrams;

@end


@interface TangramVHLayout : TangramFrameLayout {
}
/** 1:水平布局 2:竖直布局 */
@property (readwrite, nonatomic, assign) Orientation orientation;

@end


@interface TangramRatioLayout : TangramFrameLayout {
}
/**  */
@property (readwrite, nonatomic, assign) Orientation orientation;
/** 布局占比 */
@property (readwrite, nonatomic, assign) CGFloat layoutRatio;

@end


@interface TangramGridLayout : TangramFrameLayout {
}
/** 列数 */
@property (readwrite, nonatomic, assign) NSInteger column;
/** 元素高度 */
@property (readwrite, nonatomic, assign) CGFloat itemHeight;
/** 垂直间距 行之间的距离 */
@property (readwrite, nonatomic, assign) CGFloat itemVerticalMargin;
/** 水平间距 列之间的距离 */
@property (readwrite, nonatomic, assign) CGFloat itemHorizontalMargin;
/** 每个Item对应的布局 */
@property (readwrite, nonatomic, strong) TangramView *itemName;

@end
