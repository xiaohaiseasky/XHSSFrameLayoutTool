//
//  UIView+XHSSLayoutTool.h
//  XiaoHaiLayoutFramework
//
//  Created by Apple on 2017/10/28.
//  Copyright © 2017年 XiaoHai. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "UIView+XHSSFrameTool.h"

// =============================================
//      UIView+XHSSLayoutTool
// =============================================
@interface UIView (XHSSLayoutTool)

#pragma mark - SETTER & GETTER
// 模拟栈结构
@property (nonatomic, strong) NSMutableArray *stack;
// 可存储的四种数据类型
@property (nonatomic, assign) CGFloat xhssFloatValue;
@property (nonatomic, assign) CGPoint xhssPointValue;
@property (nonatomic, assign) CGSize xhssSizeValue;
@property (nonatomic, assign) CGRect xhssRectValue;

// 设置适配比率
@property (nonatomic, assign) CGFloat adaptationRate;
// 设置完全适配情况下的基础屏幕尺寸, 如果不设置则当前适配为固定坐标适配
@property (nonatomic, assign) CGFloat baseScreenWidth;
- (UIView*(^)(CGFloat baseScreenWidth))laBaseScreenWidth;


//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - ==============参考视图===============
#pragma mark - top
/**
 保存 self 的 top 以备后续使用
 */
- (UIView*(^)(CGFloat topDistance))topDistance;

/**
 设置上边距时，上侧的参考视图
 */
- (UIView*(^)(UIView *topRefView))toTopRefView;             // 固定像素适配
- (UIView*(^)(UIView *topRefView))toTopRefViewScreenFit;    // 按屏幕比例适配

#pragma mark - left
/**
 保存 self 的 left 以备后续使用
 */
- (UIView*(^)(CGFloat leftDistance))leftDistance;

/**
 设置左边距时，左侧的参考视图
 */
- (UIView*(^)(UIView *leftRefView))toLeftRefView;             // 固定像素适配
- (UIView*(^)(UIView *leftRefView))toLeftRefViewScreenFit;    // 按屏幕比例适配

#pragma mark - bottom
/**
 保存 self 的 bottom 以备后续使用
 */
- (UIView*(^)(CGFloat bottomDistance))bottomDistance;

/**
 设置下边距时，下侧的参考视图
 */
- (UIView*(^)(UIView *bottomRefView))toBottomRefView;             // 固定像素适配
- (UIView*(^)(UIView *bottomRefView))toBottomRefViewScreenFit;    // 按屏幕比例适配

#pragma mark - right
/**
 保存 self 的 right 以备后续使用
 */
- (UIView*(^)(CGFloat rightDistance))rightDistance;

/**
 设置右边距时，右侧的参考视图
 */
- (UIView*(^)(UIView *rightRefView))toRightRefView;             // 固定像素适配
- (UIView*(^)(UIView *rightRefView))toRightRefViewScreenFit;    // 按屏幕比例适配

#pragma mark - width
/**
 保存 self 的 width 以备后续使用
 */
- (UIView*(^)(CGFloat widthValue))widthValue;

/**
 设置 width 时的参考视图
 */
- (UIView*(^)(UIView *refView))equalToRefViewWidth;             // 固定像素适配
                                                                // 无需按比例进行适配

#pragma mark - height
/**
 保存 self 的 height 以备后续使用
 */
- (UIView*(^)(CGFloat heightValue))heightValue;

/**
 设置 height 时的参考视图
 */
- (UIView*(^)(UIView *refView))equalToRefViewHeight;            // 固定像素适配
                                                                // 无需按比例进行适配

#pragma mark - center
/**
 保存 self 的 center 以备后续使用
 */
- (UIView*(^)(CGPoint centerValue))centerValue;

/**
 设置 center 时的参考视图
 */
- (UIView*(^)(UIView *refView))equalToRefViewCenter;            // 固定像素适配
                                                                // 无需按比例进行适配


#pragma mark - origin
/**
 保存 self 的 origin 以备后续使用
 */
//- (UIView*(^)(CGPoint orignValue))originValue;

/**
 设置 origin 时的参考视图
 */
//- (UIView*(^)(UIView *refView))equalToRefViewOrigin;            // 固定像素适配
                                                                // 无需按比例进行适配

#pragma mark - bounds
/**
 保存 self 的 bounds 以备后续使用
 */
//- (UIView*(^)(CGSize boundsValue))boundsValue;

/**
 设置 bounds 时的参考视图
 */
//- (UIView*(^)(UIView *refView))equalToRefViewBounds;            // 固定像素适配
                                                                // 无需按比例进行适配

#pragma mark - ==============固定数值===============
// => equalToNum().equalToNumScreenFit()
/**
 left
 默认只适配 左边到父视图的距离
 */
- (UIView*(^)(CGFloat leftValue))leftEqualToNum;                // 固定像素适配
- (UIView*(^)(CGFloat leftValue))leftEqualToNumScreenFit;       // 按屏幕比例适配

/**
 right
 默认只适配 右边到父视图的距离
 */
- (UIView*(^)(CGFloat rightValue))rightEqualToNum;              // 固定像素适配
- (UIView*(^)(CGFloat rightValue))rightEqualToNumScreenFit;     // 按屏幕比例适配

/**
 top
 默认只适配 上边到父视图的距离
 */
- (UIView*(^)(CGFloat topValue))topEqualToNum;                  // 固定像素适配
- (UIView*(^)(CGFloat topValue))topEqualToNumScreenFit;         // 按屏幕比例适配

/**
 bottom
 默认只适配 底边到父视图的距离
 */
- (UIView*(^)(CGFloat bottomValue))bottomEqualToNum;            // 固定像素适配
- (UIView*(^)(CGFloat bottomValue))bottomEqualToNumScreenFit;   // 按屏幕比例适配

/**
 width
 适配宽度到具体数值
 */
- (UIView*(^)(CGFloat widthValue))widthEqualToNum;              // 固定像素适配
- (UIView*(^)(CGFloat widthValue))widthEqualToNumScreenFit;     // 按屏幕比例适配

/**
 height
 适配高度到具体数值
 */
- (UIView*(^)(CGFloat heightValue))heightEqualToNum;            // 固定像素适配
- (UIView*(^)(CGFloat heightValue))heightEqualToNumScreenFit;   // 按屏幕比例适配

/**
 center
 适配中心点到具体位置
 */
- (UIView*(^)(CGPoint centerValue))centerEqualToNum;            // 固定像素适配
//- (UIView*(^)(CGPoint centerValue))centerEqualToNumScreenFit;   // 按屏幕比例适配

/**
 origin
 适配原点到具体位置
 */
//- (UIView*(^)(CGPoint originValue))originEqualToNum;            // 固定像素适配
//- (UIView*(^)(CGPoint originValue))originEqualToNumScreenFit;   // 按屏幕比例适配

/**
 bounds
  适配边框到具体尺寸
 */
//- (UIView*(^)(CGSize sizeValue))sizeEqualToNum;                 // 固定像素适配
//- (UIView*(^)(CGSize sizeValue))sizeEqualToNumScreenFit;        // 按屏幕比例适配

#pragma mark - ==============视图相等==============
// => equalToView()/centerEqualToViewCenterPoint()
/**
 top
 */
- (UIView*(^)(UIView  *refView))topEqualToView;                     // 固定像素适配
                                                                    // 无需按比例进行适配
#if 1
/// ***  
- (UIView*(^)(UIView  *refView))topEqualToViewTop;
/// ***
- (UIView*(^)(UIView  *refView))topEqualToViewCenter;
/// ***
- (UIView*(^)(UIView  *refView))topEqualToViewBottom;
#endif

/**
 left
 */
- (UIView*(^)(UIView  *refView))leftEqualToView;                    // 固定像素适配
                                                                    // 无需按比例进行适配
#if 1
/// ***
- (UIView*(^)(UIView  *refView))leftEqualToViewLeft;
/// ***
- (UIView*(^)(UIView  *refView))leftEqualToViewCenter;
/// ***
- (UIView*(^)(UIView  *refView))leftEqualToViewRight;
#endif

/**
 bottom
 */
- (UIView*(^)(UIView  *refView))bottomEqualToView;                  // 固定像素适配
                                                                    // 无需按比例进行适配
#if 1
/// ***
- (UIView*(^)(UIView  *refView))bottomEqualToViewTop;
/// ***
- (UIView*(^)(UIView  *refView))bottomEqualToViewCenter;
/// ***  
- (UIView*(^)(UIView  *refView))bottomEqualToViewBottom;
#endif

/**
 right
 */
- (UIView*(^)(UIView  *refView))rightEqualToView;                   // 固定像素适配
                                                                    // 无需按比例进行适配
#if 1
/// ***
- (UIView*(^)(UIView  *refView))rightEqualToViewLeft;
/// ***
- (UIView*(^)(UIView  *refView))rightEqualToViewCenter;
/// ***
- (UIView*(^)(UIView  *refView))rightEqualToViewRight;
#endif

/**
 width
 */
- (UIView*(^)(UIView  *refView))widthEqualToView;                   // 固定像素适配
                                                                    // 无需按比例进行适配

/**
 height
 */
- (UIView*(^)(UIView  *refView))heightEqualToView;                  // 固定像素适配
                                                                    // 无需按比例进行适配

/**
 center
 */
- (UIView*(^)(UIView  *refView))centerEqualToView;                  // 固定像素适配
                                                                    // 无需按比例进行适配

/**
 center point
 */
- (UIView*(^)(UIView  *refView))centerEqualToViewCenterPoint;       // 固定像素适配
                                                                    // 无需按比例进行适配

/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerX))centerXEqualToNum;
/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerX))centerXEqualToNumScreenFit;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView  *refView))centerXEqualToView;

/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerY))centerYEqualToNum;
/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerY))centerYEqualToNumScreenFit;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView  *refView))centerYEqualToView;


/**
 origin
 */
- (UIView*(^)(UIView  *refView))originEqualToView;                  // 固定像素适配
                                                                    // 无需按比例进行适配

/**
 size
 */
- (UIView*(^)(UIView  *refView))sizeEqualToView;                    // 固定像素适配
                                                                    // 无需按比例进行适配

#pragma mark - ==============对齐===============
// => alignmentTo[by]Num().alignmentTo[by]NumScreenFit().alignmentToView[top/left/bottom/right]()
/**
 top
 */
/// ***
- (UIView*(^)(CGFloat  bottomValue))topAligmentToNum;               // 固定像素适配
/// ***
- (UIView*(^)(CGFloat  bottomValue))topAligmentToNumScreenFit;      // 按屏幕比例适配

/// ***
- (UIView*(^)(UIView  *refView))topAligmentToView;                  // 固定像素适配
                                                                    // 无需按比例进行适配
/// ***
- (UIView*(^)(UIView  *refView))topAligmentToViewTop;
/// ***
- (UIView*(^)(UIView  *refView))topAligmentToViewCenter;
/// ***
- (UIView*(^)(UIView  *refView))topAligmentToViewBotton;

/**
 left
 */
/// ***
- (UIView*(^)(CGFloat  bottomValue))leftAligmentToNum;              // 固定像素适配
/// ***
- (UIView*(^)(CGFloat  bottomValue))leftAligmentToNumScreenFit;     // 按屏幕比例适配

/// ***
- (UIView*(^)(UIView  *refView))leftAligmentToView;                 // 固定像素适配
                                                                    // 无需按比例进行适配
/// ***
- (UIView*(^)(UIView  *refView))leftAligmentToViewLeft;
/// ***
- (UIView*(^)(UIView  *refView))leftAligmentToViewCenter;
/// ***
- (UIView*(^)(UIView  *refView))leftAligmentToViewRight;

/**
 bottom
 */
- (UIView*(^)(CGFloat  bottomValue))bottomAligmentToNum;            // 固定像素适配
- (UIView*(^)(CGFloat  bottomValue))bottomAligmentToNumScreenFit;   // 按屏幕比例适配

- (UIView*(^)(UIView  *refView))bottomAligmentToView;               // 固定像素适配
                                                                    // 无需按比例进行适配
/// ***
- (UIView*(^)(UIView  *refView))bottomAligmentToViewTop;
/// ***
- (UIView*(^)(UIView  *refView))bottomAligmentToViewCenter;
/// ***
- (UIView*(^)(UIView  *refView))bottomAligmentToViewBotton;

/**
 right
 */
- (UIView*(^)(CGFloat  rightValue))rightAligmentToNum;              // 固定像素适配
- (UIView*(^)(CGFloat  rightValue))rightAligmentToNumScreenFit;     // 按屏幕比例适配

- (UIView*(^)(UIView  *refView))rightAligmentToView;                // 固定像素适配
                                                                    // 无需按比例进行适配
/// ***
- (UIView*(^)(UIView  *refView))rightAligmentToViewLeft;
/// ***
- (UIView*(^)(UIView  *refView))rightAligmentToViewCenter;
/// ***
- (UIView*(^)(UIView  *refView))rightAligmentToViewRight;


/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerXValue))centerXAligmentToNum;
/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerXValue))centerXAligmentToNumScreenFit;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerXAligmentToView;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerXAligmentToViewLeft;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerXAligmentToViewCenterX;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerXAligmentToViewRight;

/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerYValue))centerYAligmentToNum;
/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerYValue))centerYAligmentToNumScreenFit;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerYAligmentToView;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerYAligmentToViewTop;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerYAligmentToViewCenterY;
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerYAligmentToViewBottom;

#pragma mark - ==============平移===============
// => moveBY[to]Num().moveBY[to]NumScreenFit()[top/left/bottom/right].
/**
 up
 */
- (UIView*(^)(CGFloat  topValue))moveUpByNum;
- (UIView*(^)(CGFloat  topValue))moveUpByNumScreenFit;

/// ***
- (UIView*(^)(CGFloat  topValue))moveUpToNum;
/// ***
- (UIView*(^)(CGFloat  topValue))moveUpToNumScreenFit;

/**
 left
 */
- (UIView*(^)(CGFloat  leftValue))moveLeftByNum;
- (UIView*(^)(CGFloat  leftValue))moveLeftByNumScreenFit;

/// ***
- (UIView*(^)(CGFloat  leftValue))moveLeftToNum;
/// ***
- (UIView*(^)(CGFloat  leftValue))moveLeftToNumScreenFit;

/**
 dwon
 */
- (UIView*(^)(CGFloat  dwonValue))moveDwonByNum;
- (UIView*(^)(CGFloat  dwonValue))moveDwonByNumScreenFit;

/// ***
- (UIView*(^)(CGFloat  dwonValue))moveDwonToNum;
/// ***
- (UIView*(^)(CGFloat  dwonValue))moveDwonToNumScreenFit;

/**
 right
 */
- (UIView*(^)(CGFloat  rightValue))moveRightByNum;
- (UIView*(^)(CGFloat  rightValue))moveRightByNumScreenFit;

/// ***
- (UIView*(^)(CGFloat  rightValue))moveRightToNum;
/// ***
- (UIView*(^)(CGFloat  rightValue))moveRightToNumScreenFit;

#pragma mark - ==============增长===============
#warning ------- should add method : topAddBy() / topAddTo() , topSubBy() / topSubTo()  ... ; then add these method to protocol -------

/**
 Top
 */
- (UIView*(^)(CGFloat  topAddValue))topAddByNum;
- (UIView*(^)(CGFloat  topAddValue))topAddByNumScreenFit;

- (UIView*(^)(CGFloat  topAddValue))topAddToNum;
- (UIView*(^)(CGFloat  topAddValue))topAddToNumScreenFit;

- (UIView*(^)(CGFloat  topAddValue))topSubByNum;
- (UIView*(^)(CGFloat  topAddValue))topSubByNumScreenFit;

- (UIView*(^)(CGFloat  topAddValue))topSubToNum;
- (UIView*(^)(CGFloat  topAddValue))topSubToNumScreenFit;


/**
 Left
 */
- (UIView*(^)(CGFloat  leftAddValue))leftAddByNum;
- (UIView*(^)(CGFloat  leftAddValue))leftAddByNumScreenFit;

- (UIView*(^)(CGFloat  leftAddValue))leftAddToNum;
- (UIView*(^)(CGFloat  leftAddValue))leftAddToNumScreenFit;

- (UIView*(^)(CGFloat  leftAddValue))leftSubByNum;
- (UIView*(^)(CGFloat  leftAddValue))leftSubByNumScreenFit;

- (UIView*(^)(CGFloat  leftAddValue))leftSubToNum;
- (UIView*(^)(CGFloat  leftAddValue))leftSubToNumScreenFit;

/**
 Bottom
 */
- (UIView*(^)(CGFloat  bottomAddValue))bottomAddByNum;
- (UIView*(^)(CGFloat  bottomAddValue))bottomAddByNumScreenFit;

- (UIView*(^)(CGFloat  bottomAddValue))bottomAddToNum;
- (UIView*(^)(CGFloat  bottomAddValue))bottomAddToNumScreenFit;

- (UIView*(^)(CGFloat  bottomAddValue))bottomSubByNum;
- (UIView*(^)(CGFloat  bottomAddValue))bottomSubByNumScreenFit;

- (UIView*(^)(CGFloat  bottomAddValue))bottomSubToNum;
- (UIView*(^)(CGFloat  bottomAddValue))bottomSubToNumScreenFit;

/**
 Right
 */
- (UIView*(^)(CGFloat  rightAddValue))rightAddByNum;
- (UIView*(^)(CGFloat  rightAddValue))rightAddByNumScreenFit;

- (UIView*(^)(CGFloat  rightAddValue))rightAddToNum;
- (UIView*(^)(CGFloat  rightAddValue))rightAddToNumScreenFit;

- (UIView*(^)(CGFloat  rightAddValue))rightSubByNum;
- (UIView*(^)(CGFloat  rightAddValue))rightSubByNumScreenFit;

- (UIView*(^)(CGFloat  rightAddValue))rightSubToNum;
- (UIView*(^)(CGFloat  rightAddValue))rightSubToNumScreenFit;















#pragma mark - ==============联调===============
//- (UIView*(^)())top;
//- (UIView*(^)())left;
//- (UIView*(^)())bottom;
//- (UIView*(^)())right;
//
//// 参考视图
////- (UIView*(^)(CGFloat distance))distance;
////- (UIView*(^)(UIView *refView))toRefView;
////- (UIView*(^)(UIView *refView))toRefViewScreenFit;
//- (UIView*(^)(CGFloat distance, UIView *refView))distanceToRefView;
//- (UIView*(^)(CGFloat distance, UIView *refView))distanceToRefViewScreenFit;
//// 相等
//- (UIView*(^)(CGFloat value))equalToNum;
//- (UIView*(^)(CGFloat value))equalToNumScreenFit;
//- (UIView*(^)(UIView *refView))equalToView;
//// 对齐
//- (UIView*(^)(CGFloat value))aligmentToNum;
//- (UIView*(^)(CGFloat value))aligmentToNumScreenFit;
//- (UIView*(^)(UIView *refView))aligmentToView;
//// 平移
//- (UIView*(^)(CGFloat value))moveByNum;
//- (UIView*(^)(CGFloat value))moveByNumScreenFit;


#pragma mark - ==============块调用函数===============
typedef void(^XHSSLayoutBlock)(UIView *layoutView);
- (UIView*(^)(XHSSLayoutBlock layout))addLayout;

@end

