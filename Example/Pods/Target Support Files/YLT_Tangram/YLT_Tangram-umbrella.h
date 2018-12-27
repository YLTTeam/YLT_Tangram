#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BaseCollection.h"
#import "TangramModel+Calculate.h"
#import "TangramModel.h"
#import "YLT_TangramManager.h"
#import "YLT_TangramUtils.h"
#import "YLT_TangramCell.h"
#import "YLT_TangramFrameLayout.h"
#import "YLT_TangramGridLayout+Delegate.h"
#import "YLT_TangramGridLayout.h"
#import "YLT_TangramView+layout.h"
#import "YLT_TangramVC+Delegate.h"
#import "YLT_TangramVC.h"
#import "YLT_TangramImage.h"
#import "YLT_TangramLabel.h"
#import "YLT_TangramView+TangramData.h"
#import "YLT_TangramView+TangramPage.h"
#import "YLT_TangramView.h"
#import "YLT_Tangram.h"

FOUNDATION_EXPORT double YLT_TangramVersionNumber;
FOUNDATION_EXPORT const unsigned char YLT_TangramVersionString[];

