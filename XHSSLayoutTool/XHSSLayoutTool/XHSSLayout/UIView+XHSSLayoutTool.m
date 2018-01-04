//
//  UIView+XHSSLayoutTool.m
//  XiaoHaiLayoutFramework
//
//  Created by Apple on 2017/10/28.
//  Copyright © 2017年 XiaoHai. All rights reserved.
//
//
// *** should suport continue call of opration ***

#import "UIView+XHSSLayoutTool.h"
#import <objc/runtime.h>


typedef NS_ENUM(NSUInteger, XHSSLayoutToolLayoutPosition) {
    XHSSLayoutToolLayoutPositionTop,
    XHSSLayoutToolLayoutPositionLeft,
    XHSSLayoutToolLayoutPositionBottom,
    XHSSLayoutToolLayoutPositionRight,
};
typedef NS_ENUM(NSUInteger, XHSSLayoutToolLayoutType) {
    XHSSLayoutToolLayoutTypeDistanceToView,
    XHSSLayoutToolLayoutTypeDistanceToViewScreenFit,
    XHSSLayoutToolLayoutTypeEqualToNum,
    XHSSLayoutToolLayoutTypeEqualToNumScreenFit,
    XHSSLayoutToolLayoutTypeEqualToView,
    XHSSLayoutToolLayoutTypeAligmentToNum,
    XHSSLayoutToolLayoutTypeAligmentToNumScreenFit,
    XHSSLayoutToolLayoutTypeAligmentToView,
    XHSSLayoutToolLayoutTypeMoveByNum,
    XHSSLayoutToolLayoutTypeMoveByNumScreenFit,
};





@implementation UIView (XHSSLayoutTool)

#pragma mark - macro
#define kXHSSScreenFitRate [UIScreen mainScreen].bounds.size.width/screeWidth

#pragma mark - ==============RUNTIME UNRECOGNEZED SELECTOR===============
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    NSLog(@"<<<<<<< 看到此崩溃日志说明你对当前视图的配置有错误，使用了当前视图没有对属性 : %@ >>>>>>>", NSStringFromSelector(sel));
    return YES;
}

#pragma mark - ==============SETTER & GETTER===============
/**
 stack
 */
- (NSMutableArray*)stack {
    id returnStack = objc_getAssociatedObject(self, _cmd);
    if (returnStack == nil) {
        returnStack = [NSMutableArray array];
    }
    return returnStack;
}
- (void)setStack:(NSMutableArray *)stack {
    objc_setAssociatedObject(self, @selector(stack), stack, OBJC_ASSOCIATION_RETAIN);
}

/**
 adaptationRate
 */
- (CGFloat)adaptationRate {
    id adaptationRateObj = objc_getAssociatedObject(self, _cmd);
    
    if (adaptationRateObj == nil) {
        return [UIScreen mainScreen].bounds.size.width/self.baseScreenWidth;
    }
    
    return [adaptationRateObj floatValue];
}

- (void)setAdaptationRate:(CGFloat)adaptationRate {
    objc_setAssociatedObject(self, @selector(adaptationRate), @(adaptationRate), OBJC_ASSOCIATION_ASSIGN);
}

/**
 baseScreenWidth
 */
- (CGFloat)baseScreenWidth {
    id baseScreenWidthObj = objc_getAssociatedObject(self, _cmd);
    return [baseScreenWidthObj floatValue];
}

- (void)setBaseScreenWidth:(CGFloat)baseScreenWidth {
    objc_setAssociatedObject(self, @selector(baseScreenWidth), @(baseScreenWidth), OBJC_ASSOCIATION_ASSIGN);
}

- (UIView*(^)(CGFloat baseScreenWidth))laBaseScreenWidth {
    return ^(CGFloat baseScreenWidth){
        self.baseScreenWidth = baseScreenWidth;
        return self;
    };
}

//////////////////////////////////////////////////////////////////////////

/**
 float
 */
- (CGFloat)xhssFloatValue {
    id floatObj = objc_getAssociatedObject(self, _cmd);
#warning if nil
    return [floatObj floatValue];
}
- (void)setXhssFloatValue:(CGFloat)xhssFloatValue {
    objc_setAssociatedObject(self, @selector(xhssFloatValue), @(xhssFloatValue), OBJC_ASSOCIATION_ASSIGN);
}

/**
 point
 */
- (CGPoint)xhssPointValue {
    id pointObj = objc_getAssociatedObject(self, _cmd);
    return [pointObj CGPointValue];
}
- (void)setXhssPointValue:(CGPoint)xhssPointValue {
    objc_setAssociatedObject(self, @selector(xhssPointValue), [NSValue valueWithCGPoint:xhssPointValue], OBJC_ASSOCIATION_ASSIGN);
}

/**
 size
 */
- (CGSize)xhssSizeValue {
    id sizeObj = objc_getAssociatedObject(self, _cmd);
    return [sizeObj CGSizeValue];
}
- (void)setXhssSizeValue:(CGSize)xhssSizeValue {
    objc_setAssociatedObject(self, @selector(xhssSizeValue), [NSValue valueWithCGSize:xhssSizeValue], OBJC_ASSOCIATION_ASSIGN);
}

/**
 rect
 */
- (CGRect)xhssRectValue {
    id rectObj = objc_getAssociatedObject(self, _cmd);
    return [rectObj CGRectValue];
}
- (void)setXhssRectValue:(CGRect)xhssRectValue{
    objc_setAssociatedObject(self, @selector(xhssRectValue), [NSValue valueWithCGRect:xhssRectValue], OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - ==============参考视图===============
//===========================================================
//===========================================================
//====    　参考视图
//===========================================================
//===========================================================

#pragma mark - top
/**
 保存 self 的 top 以备后续使用
 */
- (UIView*(^)(CGFloat topDistance))topDistance {
    return ^(CGFloat topDistance) {
        self.xhssFloatValue = topDistance;
        return self;
    };
}


/**
 设置上边距时，上侧的参考视图
 */
- (UIView*(^)(UIView *topRefView))toTopRefView {
    return ^(UIView *topRefView) {
        //self.y = topRefView.maxY + self.laFloatValue;
        
        ///self.xhssY = topRefView.xhssMaxY + self.xhssFloatValue;
        
        self.xhssHeight += (self.xhssY -(topRefView.xhssMaxY +self.xhssFloatValue));
        self.xhssY = topRefView.xhssMaxY + self.xhssFloatValue;
        return self;
    };
}

- (UIView*(^)(UIView *topRefView))toTopRefViewScreenFit {
    return ^(UIView *topRefView) {
        //self.y = topRefView.maxY + self.laFloatValue * self.adaptationRate;
        
        ///self.xhssY = topRefView.xhssMaxY + self.xhssFloatValue * self.adaptationRate;
        
        self.xhssHeight += (self.xhssY -(topRefView.xhssMaxY +self.xhssFloatValue * self.adaptationRate));
        self.xhssY = topRefView.xhssMaxY + self.xhssFloatValue * self.adaptationRate;
        return self;
    };
}

#pragma mark - left
/**
 保存 self 的 left 以备后续使用
 */
- (UIView*(^)(CGFloat leftDistance))leftDistance {
    return ^(CGFloat leftDistance) {
        self.xhssFloatValue = leftDistance;
        return self;
    };
}

/**
 设置左边距时，左侧的参考视图
 */
- (UIView*(^)(UIView *leftRefView))toLeftRefView {
    return ^(UIView *leftRefView) {
        //self.x = leftRefView.maxX + self.laFloatValue;
        
        ///self.xhssX = leftRefView.xhssMaxX + self.xhssFloatValue;
        
        self.xhssWidth += (self.xhssX -(leftRefView.xhssMaxX + self.xhssFloatValue));
        self.xhssX = leftRefView.xhssMaxX + self.xhssFloatValue;
        return self;
    };
}

- (UIView*(^)(UIView *leftRefView))toLeftRefViewScreenFit {
    return ^(UIView *leftRefView) {
        //self.x = leftRefView.maxX + self.laFloatValue * self.adaptationRate;
        
        ///self.xhssX = leftRefView.xhssMaxX + self.xhssFloatValue * self.adaptationRate;
        
        self.xhssWidth += (self.xhssX -(leftRefView.xhssMaxX + self.xhssFloatValue * self.adaptationRate));
        self.xhssX = leftRefView.xhssMaxX + self.xhssFloatValue * self.adaptationRate;
        return self;
    };
}

#pragma mark - bottom
/**
 保存 self 的 bottom 以备后续使用
 */
- (UIView*(^)(CGFloat bottomDistance))bottomDistance {
    return ^(CGFloat bottomDistance) {
        self.xhssFloatValue = bottomDistance;
        return self;
    };
}

/**
 设置下边距时，下侧的参考视图
 */
- (UIView*(^)(UIView *bottomRefView))toBottomRefView {
    return ^(UIView *bottomRefView) {
        //self.maxY = bottomRefView.y - self.laFloatValue;
        self.xhssMaxY = bottomRefView.xhssY - self.xhssFloatValue;
        return self;
    };
}

- (UIView*(^)(UIView *bottomRefView))toBottomRefViewScreenFit {
    return ^(UIView *bottomRefView) {
        //self.maxY = bottomRefView.y - self.laFloatValue * self.adaptationRate;
        self.xhssMaxY = bottomRefView.xhssY - self.xhssFloatValue * self.adaptationRate;
        return self;
    };
}

#pragma mark - right
/**
 保存 self 的 right 以备后续使用
 */
- (UIView*(^)(CGFloat rightDistance))rightDistance {
    return ^(CGFloat rightDistance) {
        self.xhssFloatValue = rightDistance;
        return self;
    };
}

/**
 设置右边距时，右侧的参考视图
 */
- (UIView*(^)(UIView *rightRefView))toRightRefView {
    return ^(UIView *rightRefView) {
        //self.maxX = rightRefView.x - self.laFloatValue;
        self.xhssMaxX = rightRefView.xhssX - self.xhssFloatValue;
        return self;
    };
}

- (UIView*(^)(UIView *rightRefView))toRightRefViewScreenFit {
    return ^(UIView *rightRefView) {
        //self.maxX = rightRefView.x - self.laFloatValue * self.adaptationRate;
        self.xhssMaxX = rightRefView.xhssX - self.xhssFloatValue * self.adaptationRate;
        return self;
    };
}

#pragma mark - width
/**
 保存 self 的 width 以备后续使用
 */
- (UIView*(^)(CGFloat widthValue))widthValue {
    return ^(CGFloat widthValue) {
        self.xhssFloatValue = widthValue;
        return self;
    };
}

/**
 设置 width 时的参考视图
 */
- (UIView*(^)(UIView *refView))equalToRefViewWidth {
    return ^(UIView *refView) {
        //self.width = refView.width;
        self.xhssWidth = refView.xhssWidth;
        return self;
    };
}

#pragma mark - height
/**
 保存 self 的 height 以备后续使用
 */
- (UIView*(^)(CGFloat heightValue))heightValue {
    return ^(CGFloat heightValue) {
        self.xhssFloatValue = heightValue;
        return self;
    };
}

/**
 设置 height 时的参考视图
 */
- (UIView*(^)(UIView *refView))equalToRefViewHeight {
    return ^(UIView *refView) {
        //self.height = refView.height;
        self.xhssHeight = refView.xhssHeight;
        return self;
    };
}

#pragma mark - center
/**
 保存 self 的 center 以备后续使用
 */
- (UIView*(^)(CGPoint centerValue))centerValue {
    return ^(CGPoint centerValue) {
        self.xhssPointValue = centerValue;
        return self;
    };
}

/**
 设置 center 时的参考视图
 */
- (UIView*(^)(UIView *refView))equalToRefViewCenter {
    return ^(UIView *refView) {
        self.xhssCenter = refView.center;
        return self;
    };
}

#pragma mark - origin
/**
 保存 self 的 origin 以备后续使用
 */
- (UIView*(^)(CGPoint orignValue))originValue {
    return ^(CGPoint orignValue) {
        self.xhssPointValue = orignValue;
        return self;
    };
}

/**
 设置 origin 时的参考视图
 */
- (UIView*(^)(UIView *refView))equalToRefViewOrigin {
    return ^(UIView *refView) {
        self.xhssOrigin = refView.frame.origin;
        return self;
    };
}

#pragma mark - bounds
/**
 保存 self 的 bounds 以备后续使用
 */
- (UIView*(^)(CGSize boundsValue))boundsValue {
    return ^(CGSize boundsValue) {
        self.xhssSizeValue = boundsValue;
        return self;
    };
}

/**
 设置 bounds 时的参考视图
 */
- (UIView*(^)(UIView *refView))equalToRefViewBounds {
    return ^(UIView *refView) {
        self.xhssBounds = refView.bounds.size;
        return self;
    };
}


#pragma mark - ==============固定数值===============
//===========================================================
//===========================================================
//====    固定数值
//===========================================================
//===========================================================

/**
 left
 默认只适配 左边到父视图的距离
 */
- (UIView*(^)(CGFloat leftValue))leftEqualToNum {
    return ^(CGFloat leftValue) {
        //self.x = leftValue;
        
        //self.xhssX = leftValue;
        
        self.xhssWidth += (self.xhssX -leftValue);
        self.xhssX = leftValue;
        return self;
    };
}

- (UIView*(^)(CGFloat leftValue))leftEqualToNumScreenFit {
    return ^(CGFloat leftValue) {
        //self.x = leftValue * self.adaptationRate;
        
        //self.xhssX = leftValue * self.adaptationRate;
        
        self.xhssWidth += (self.xhssX -leftValue * self.adaptationRate);
        self.xhssX = leftValue * self.adaptationRate;
        return self;
    };
}


/**
 right
 默认只适配 右边到父视图的距离
 */
- (UIView*(^)(CGFloat rightValue))rightEqualToNum {
    return ^(CGFloat rightValue) {
        //self.selMaxX = self.superview.width - rightValue;
        self.xhssMaxX = self.superview.xhssWidth - rightValue;
        return self;
    };
}

- (UIView*(^)(CGFloat rightValue))rightEqualToNumScreenFit {
    return ^(CGFloat rightValue) {
        //self.selMaxX = self.superview.width - rightValue * self.adaptationRate;
        self.xhssMaxX = self.superview.xhssWidth - rightValue * self.adaptationRate;
        return self;
    };
}

/**
 top
 默认只适配 上边到父视图的距离
 */
- (UIView*(^)(CGFloat topValue))topEqualToNum {
    return ^(CGFloat topValue) {
        //self.y = topValue;
        
        //self.xhssY = topValue;
        
        self.xhssHeight += (self.xhssY -topValue);
        self.xhssY = topValue;
        return self;
    };
}

- (UIView*(^)(CGFloat topValue))topEqualToNumScreenFit {
    return ^(CGFloat topValue) {
        //self.y = topValue * self.adaptationRate;
        
        //self.xhssY = topValue * self.adaptationRate;
        
        self.xhssHeight += (self.xhssY -topValue * self.adaptationRate);
        self.xhssY = topValue * self.adaptationRate;
        return self;
    };
}

/**
 bottom
 默认只适配 底边到父视图的距离
 */
- (UIView*(^)(CGFloat bottomValue))bottomEqualToNum {
    return ^(CGFloat bottomValue) {
        //self.maxY = self.superview.height - bottomValue;
        self.xhssMaxY = self.superview.xhssHeight - bottomValue;
        return self;
    };
}

- (UIView*(^)(CGFloat bottomValue))bottomEqualToNumScreenFit {
    return ^(CGFloat bottomValue) {
        //self.maxY = self.superview.height - bottomValue * self.adaptationRate;
        self.xhssMaxY = self.superview.xhssHeight - bottomValue * self.adaptationRate;
        return self;
    };
}

/**
 width
 适配宽度到具体数值
 */
- (UIView*(^)(CGFloat widthValue))widthEqualToNum {
    return ^(CGFloat widthValue) {
        //self.width = widthValue;
        self.xhssWidth = widthValue;
        return self;
    };
}

- (UIView*(^)(CGFloat widthValue))widthEqualToNumScreenFit {
    return ^(CGFloat widthValue) {
        //self.width = widthValue * self.adaptationRate;
        self.xhssWidth = widthValue * self.adaptationRate;
        return self;
    };
}

/**
 height
 适配高度到具体数值
 */
- (UIView*(^)(CGFloat heightValue))heightEqualToNum {
    return ^(CGFloat heightValue) {
        //self.height = heightValue;
        self.xhssHeight = heightValue;
        return self;
    };
}

- (UIView*(^)(CGFloat heightValue))heightEqualToNumScreenFit {
    return ^(CGFloat heightValue) {
        //self.height = heightValue * self.adaptationRate;
        self.xhssHeight = heightValue * self.adaptationRate;
        return self;
    };
}

/**
 center
 适配中心点到具体位置
 */
- (UIView*(^)(CGPoint centerValue))centerEqualToNum {
    return ^(CGPoint centerValue) {
        self.xhssCenter = centerValue;
        return self;
    };
}

- (UIView*(^)(CGPoint centerValue))centerEqualToNumScreenFit {
    return ^(CGPoint centerValue) {
        self.xhssCenter = CGPointMake(centerValue.x * self.adaptationRate, centerValue.y * self.adaptationRate);
        return self;
    };
}


/**
 origin
 适配原点到具体位置
 */
- (UIView*(^)(CGPoint originValue))originEqualToNum {
    return ^(CGPoint originValue) {
        self.xhssOrigin = originValue;
        return self;
    };
}

- (UIView*(^)(CGPoint originValue))originEqualToNumScreenFit {
    return ^(CGPoint originValue) {
        self.xhssOrigin = CGPointMake(originValue.x * self.adaptationRate, originValue.y * self.adaptationRate);
        return self;
    };
}


/**
 bounds
  适配边框到具体尺寸
 */
- (UIView*(^)(CGSize sizeValue))sizeEqualToNum {
    return ^(CGSize sizeValue) {
        CGRect oldBounds = self.bounds;
        oldBounds.size = sizeValue;
        self.bounds = oldBounds;
        return self;
    };
}

- (UIView*(^)(CGSize sizeValue))sizeEqualToNumScreenFit {
    return ^(CGSize sizeValue) {
        CGRect oldBounds = self.bounds;
        oldBounds.size = CGSizeMake(sizeValue.width * self.adaptationRate, sizeValue.height * self.adaptationRate);
        self.bounds = oldBounds;
        return self;
    };
}

#pragma mark - ==============视图相等==============
//===========================================================
//===========================================================
//====    　视图相等
//===========================================================
//===========================================================

/**
 top
 */
- (UIView*(^)(UIView  *refView))topEqualToView {
    return ^(UIView  *refView) {
        //self.y = refView.y;
        
        //self.xhssY = refView.xhssY;
        
        self.xhssHeight += (self.xhssY -refView.xhssY);
        self.xhssY = refView.xhssY;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))topEqualToViewTop {
    return ^(UIView  *refView) {
        self.xhssHeight += (self.xhssY -refView.xhssY);
        self.xhssY = refView.xhssY;
        return self;
    };
};
/// *** not implementation ***   ???????
- (UIView*(^)(UIView  *refView))topEqualToViewCenter {
    return ^(UIView  *refView) {
        self.xhssHeight += (self.xhssY -(refView.xhssY +refView.xhssHeight/2.0f));
        self.xhssY = (refView.xhssY +refView.xhssHeight/2.0f);
        return self;
    };
};
/// *** not implementation ***   ???????
- (UIView*(^)(UIView  *refView))topEqualToViewBottom {
    return ^(UIView  *refView) {
        self.xhssHeight += (self.xhssY -refView.xhssMaxY);
        self.xhssY = refView.xhssMaxY;
        return self;
    };
};

/**
 left
 */
- (UIView*(^)(UIView  *refView))leftEqualToView {
    return ^(UIView  *refView) {
        //self.x = refView.x;
        
        //self.xhssX = refView.xhssX;
        
        self.xhssWidth += (self.xhssX -refView.xhssX);
        self.xhssX = refView.xhssX;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))leftEqualToViewLeft {
    return ^(UIView  *refView) {
        self.xhssWidth += (self.xhssX -refView.xhssX);
        self.xhssX = refView.xhssX;
        return self;
    };
}
/// *** not implementation ***    ???????
- (UIView*(^)(UIView  *refView))leftEqualToViewCenter {
    return ^(UIView  *refView) {
        self.xhssWidth += (self.xhssX -(refView.xhssX +refView.xhssWidth/2.0f));
        self.xhssX = (refView.xhssX +refView.xhssWidth/2.0f);
        return self;
    };
}
/// *** not implementation ***    ???????
- (UIView*(^)(UIView  *refView))leftEqualToViewRight {
    return ^(UIView  *refView) {
        self.xhssWidth += (self.xhssX -refView.xhssMaxX);
        self.xhssX = refView.xhssMaxX;
        return self;
    };
}

/**
 bottom
 */
- (UIView*(^)(UIView  *refView))bottomEqualToView {
    return ^(UIView  *refView) {
        //self.maxY = refView.maxY;
        self.xhssMaxY = refView.xhssMaxY;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))bottomEqualToViewTop {
    return ^(UIView  *refView) {
        self.xhssMaxY = refView.xhssY;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))bottomEqualToViewCenter {
    return ^(UIView  *refView) {
        self.xhssMaxY = refView.xhssMaxY -refView.xhssHeight/2.0f;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))bottomEqualToViewBottom {
    return ^(UIView  *refView) {
        self.xhssMaxY = refView.xhssMaxY;
        return self;
    };
}

/**
 right
 */
- (UIView*(^)(UIView  *refView))rightEqualToView {
    return ^(UIView  *refView) {
        //self.maxX = refView.maxX;
        self.xhssMaxX = refView.xhssMaxX;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))rightEqualToViewLeft {
    return ^(UIView  *refView) {
        self.xhssMaxX = refView.xhssX;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))rightEqualToViewCenter {
    return ^(UIView  *refView) {
        self.xhssMaxX = refView.xhssMaxX -refView.xhssWidth/2.0f;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))rightEqualToViewRight {
    return ^(UIView  *refView) {
        self.xhssMaxX = refView.xhssMaxX;
        return self;
    };
}

/**
 width
 */
- (UIView*(^)(UIView  *refView))widthEqualToView {
    return ^(UIView  *refView) {
        //self.width = refView.width;
        self.xhssWidth = refView.xhssWidth;
        return self;
    };
}

/**
 height
 */
- (UIView*(^)(UIView  *refView))heightEqualToView {
    return ^(UIView  *refView) {
        //self.height = refView.height;
        self.xhssHeight = refView.xhssHeight;
        return self;
    };
}

/**
 center
 */
- (UIView*(^)(UIView  *refView))centerEqualToView {
    return ^(UIView  *refView) {
        self.xhssCenter = refView.center;
        return self;
    };
}

/**
 center point
 */
- (UIView*(^)(UIView  *refView))centerEqualToViewCenterPoint {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(refView.frame.size.width/2.0, refView.frame.size.height/2.0);
        return self;
    };
}

/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerX))centerXEqualToNum {
    return ^(CGFloat centerX) {
        self.xhssCenter = CGPointMake(centerX, self.xhssCenter.y);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerX))centerXEqualToNumScreenFit {
    return ^(CGFloat centerX) {
        self.xhssCenter = CGPointMake(centerX * self.adaptationRate, self.xhssCenter.y);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView  *refView))centerXEqualToView {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(refView.xhssCenter.x, self.xhssCenter.y);
        return self;
    };
}

/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerY))centerYEqualToNum {
    return ^(CGFloat centerY) {
        self.xhssCenter = CGPointMake(self.xhssCenter.x, centerY);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerY))centerYEqualToNumScreenFit {
    return ^(CGFloat centerY) {
        self.xhssCenter = CGPointMake(self.xhssCenter.x, centerY * self.adaptationRate);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView  *refView))centerYEqualToView {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(self.xhssCenter.x, refView.xhssCenter.y);
        return self;
    };
}



/**
 origin
 */
- (UIView*(^)(UIView  *refView))originEqualToView {
    return ^(UIView  *refView) {
        self.xhssOrigin = refView.frame.origin;
        return self;
    };
}

/**
 size
 */
- (UIView*(^)(UIView  *refView))sizeEqualToView {
    return ^(UIView  *refView) {
        CGRect oldBounds = self.bounds;
        oldBounds.size = refView.bounds.size;
        self.bounds = oldBounds;
        return self;
    };
}

#pragma mark - ==============对齐===============
/**
 top
 */
/// *** not implementation ***
- (UIView*(^)(CGFloat  topValue))topAligmentToNum {
    return ^(CGFloat topValue) {
        self.xhssY = topValue;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(CGFloat topValue))topAligmentToNumScreenFit {
    return ^(CGFloat topValue) {
        self.xhssY = topValue * self.adaptationRate;
        return self;
    };
}

/// *** not implementation ***
- (UIView*(^)(UIView  *refView))topAligmentToView {
    return ^(UIView  *refView) {
        self.xhssY = refView.xhssY;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))topAligmentToViewTop {
    return ^(UIView  *refView) {
        self.xhssY = refView.xhssY;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))topAligmentToViewCenter {
    return ^(UIView  *refView) {
        self.xhssY = refView.xhssY +refView.xhssHeight/2.0f;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))topAligmentToViewBotton {
    return ^(UIView  *refView) {
        self.xhssY = refView.xhssMaxY;
        return self;
    };
}

/**
 left
 */
/// *** not implementation ***
- (UIView*(^)(CGFloat  leftValue))leftAligmentToNum {
    return ^(CGFloat leftValue) {
        self.xhssX = leftValue;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(CGFloat  leftValue))leftAligmentToNumScreenFit {
    return ^(CGFloat leftValue) {
        self.xhssX = leftValue * self.adaptationRate;
        return self;
    };
}

/// *** not implementation ***
- (UIView*(^)(UIView  *refView))leftAligmentToView {
    return ^(UIView  *refView) {
        self.xhssX = refView.xhssX;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))leftAligmentToViewLeft {
    return ^(UIView  *refView) {
        self.xhssX = refView.xhssX;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))leftAligmentToViewCenter {
    return ^(UIView  *refView) {
        self.xhssX = refView.xhssX +refView.xhssWidth/2.0f;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))leftAligmentToViewRight {
    return ^(UIView  *refView) {
        self.xhssX = refView.xhssMaxX;
        return self;
    };
}

/**
 bottom             amxx  -> value
 */
- (UIView*(^)(CGFloat  bottomValue))bottomAligmentToNum {
    return ^(CGFloat bottomValue) {
        self.xhssY = self.superview.xhssHeight - bottomValue - self.xhssHeight;
        return self;
    };
}
- (UIView*(^)(CGFloat  bottomValue))bottomAligmentToNumScreenFit {
    return ^(CGFloat bottomValue) {
        self.xhssY = self.superview.xhssHeight - bottomValue*self.adaptationRate - self.xhssHeight;
        return self;
    };
}

- (UIView*(^)(UIView  *refView))bottomAligmentToView {
    return ^(UIView  *refView) {
        self.xhssY = self.xhssY + (refView.xhssMaxY - self.xhssMaxY);
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))bottomAligmentToViewTop {
    return ^(UIView  *refView) {
        self.xhssY = self.xhssY + (refView.xhssY - self.xhssMaxY);
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))bottomAligmentToViewCenter {
    return ^(UIView  *refView) {
        self.xhssY = self.xhssY + ((refView.xhssY +refView.xhssHeight/2.0f) - self.xhssMaxY);
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))bottomAligmentToViewBotton {
    return ^(UIView  *refView) {
        self.xhssY = self.xhssY + (refView.xhssMaxY - self.xhssMaxY);
        return self;
    };
}

/**
 right
 */
- (UIView*(^)(CGFloat  rightValue))rightAligmentToNum {
    return ^(CGFloat rightValue) {
        self.xhssX = self.superview.xhssWidth - rightValue - self.xhssWidth;
        return self;
    };
}
- (UIView*(^)(CGFloat  rightValue))rightAligmentToNumScreenFit {
    return ^(CGFloat rightValue) {
        self.xhssX = self.superview.xhssWidth - rightValue*self.adaptationRate - self.xhssWidth;
        return self;
    };
}

- (UIView*(^)(UIView  *refView))rightAligmentToView {
    return ^(UIView  *refView) {
        self.xhssX = self.xhssX + (refView.xhssMaxX - self.xhssMaxX);
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))rightAligmentToViewLeft {
    return ^(UIView  *refView) {
        self.xhssX = self.xhssX + (refView.xhssX - self.xhssMaxX);
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))rightAligmentToViewCenter {
    return ^(UIView  *refView) {
        self.xhssX = self.xhssX + ((refView.xhssX +refView.xhssWidth/2.0f) - self.xhssMaxX);
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(UIView  *refView))rightAligmentToViewRight {
    return ^(UIView  *refView) {
        self.xhssX = self.xhssX + (refView.xhssMaxX - self.xhssMaxX);
        return self;
    };
}

/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerXValue))centerXAligmentToNum {
    return ^(CGFloat centerXValue) {
        self.xhssCenter = CGPointMake(centerXValue, self.xhssCenter.y);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerXValue))centerXAligmentToNumScreenFit {
    return ^(CGFloat centerXValue) {
        self.xhssCenter = CGPointMake(centerXValue * self.adaptationRate, self.xhssCenter.y);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerXAligmentToView {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(refView.xhssCenter.x, self.xhssCenter.y);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerXAligmentToViewLeft {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(refView.xhssX, self.xhssCenter.y);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerXAligmentToViewCenterX {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(refView.xhssX + refView.xhssWidth/2.0, self.xhssCenter.y);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerXAligmentToViewRight {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(refView.xhssMaxX, self.xhssCenter.y);
        return self;
    };
}

/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerYValue))centerYAligmentToNum {
    return ^(CGFloat centerYValue) {
        self.xhssCenter = CGPointMake(self.xhssCenter.x, centerYValue);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(CGFloat centerYValue))centerYAligmentToNumScreenFit {
    return ^(CGFloat centerYValue) {
        self.xhssCenter = CGPointMake(self.xhssCenter.x, centerYValue * self.adaptationRate);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerYAligmentToView {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(self.xhssCenter.x, refView.xhssCenter.y);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerYAligmentToViewTop {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(self.xhssCenter.x, refView.xhssY);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerYAligmentToViewCenterY {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(self.xhssCenter.x, refView.xhssY + refView.xhssHeight/2.0);
        return self;
    };
}
/// <<<<<<<>>>>>>>
- (UIView*(^)(UIView *refView))centerYAligmentToViewBottom {
    return ^(UIView  *refView) {
        self.xhssCenter = CGPointMake(self.xhssCenter.x, refView.xhssMaxY);
        return self;
    };
}


#pragma mark - ==============平移===============
/**
 up
 */
- (UIView*(^)(CGFloat  topValue))moveUpByNum {
    return ^(CGFloat topValue) {
        self.xhssY = self.xhssY - topValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  topValue))moveUpByNumScreenFit {
    return ^(CGFloat topValue) {
        self.xhssY = self.xhssY - topValue*self.adaptationRate;
        return self;
    };
}

/// *** not implementation ***
- (UIView*(^)(CGFloat  topValue))moveUpToNum {
    return ^(CGFloat topValue) {
        self.xhssY = topValue;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(CGFloat  topValue))moveUpToNumScreenFit {
    return ^(CGFloat topValue) {
        self.xhssY = topValue * self.adaptationRate;
        return self;
    };
}

/**
 left
 */
- (UIView*(^)(CGFloat  leftValue))moveLeftByNum {
    return ^(CGFloat leftValue) {
        self.xhssX = self.xhssX - leftValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  leftValue))moveLeftByNumScreenFit {
    return ^(CGFloat leftValue) {
        self.xhssX = self.xhssX - leftValue*self.adaptationRate;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(CGFloat  leftValue))moveLeftToNum {
    return ^(CGFloat leftValue) {
        self.xhssX = leftValue;
        return self;
    };
}
/// *** not implementation ***
- (UIView*(^)(CGFloat  leftValue))moveLeftToNumScreenFit {
    return ^(CGFloat leftValue) {
        self.xhssX = leftValue * self.adaptationRate;
        return self;
    };
}

/**
 dwon
 */
- (UIView*(^)(CGFloat  dwonValue))moveDwonByNum {
    return ^(CGFloat dwonValue) {
        self.xhssY = self.xhssY + dwonValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  dwonValue))moveDwonByNumScreenFit {
    return ^(CGFloat dwonValue) {
        self.xhssY = self.xhssY + dwonValue*self.adaptationRate;
        return self;
    };
}
/// *** not implementation ***    ???????
- (UIView*(^)(CGFloat  dwonValue))moveDwonToNum {
    return ^(CGFloat dwonValue) {
        self.xhssY = self.superview.xhssHeight - (dwonValue + self.xhssHeight);
        return self;
    };
}
/// *** not implementation ***    ???????
- (UIView*(^)(CGFloat  dwonValue))moveDwonToNumScreenFit {
    return ^(CGFloat dwonValue) {
        self.xhssY = self.superview.xhssHeight - (dwonValue* self.adaptationRate + self.xhssHeight);
        return self;
    };
}


/**
 right
 */
- (UIView*(^)(CGFloat  rightValue))moveRightByNum {
    return ^(CGFloat rightValue) {
        self.xhssX = self.xhssX + rightValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  rightValue))moveRightByNumScreenFit {
    return ^(CGFloat rightValue) {
        self.xhssX = self.xhssX + rightValue*self.adaptationRate;
        return self;
    };
}
/// *** not implementation ***    ???????
- (UIView*(^)(CGFloat  rightValue))moveRightToNum {
    return ^(CGFloat rightValue) {
        self.xhssX = self.superview.xhssWidth - (rightValue + self.xhssWidth);
        return self;
    };
}
/// *** not implementation ***    ???????
- (UIView*(^)(CGFloat  rightValue))moveRightToNumScreenFit {
    return ^(CGFloat rightValue) {
        self.xhssX = self.superview.xhssWidth - (rightValue * self.adaptationRate + self.xhssWidth);
        return self;
    };
}

#pragma mark - ==============增长===============
/**
 Top
 */
/// *** add by ***
- (UIView*(^)(CGFloat  topAddValue))topAddByNum {
    return ^(CGFloat  topAddValue) {
        self.xhssHeight += topAddValue;
        self.xhssY -= topAddValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  topAddValue))topAddByNumScreenFit {
    return ^(CGFloat  topAddValue) {
        self.xhssHeight += topAddValue * self.adaptationRate;
        self.xhssY -= topAddValue * self.adaptationRate;
        return self;
    };
}

/// *** add to ***    ???????
- (UIView*(^)(CGFloat  topAddValue))topAddToNum {
    return ^(CGFloat  topAddValue) {
        self.xhssHeight -= (topAddValue -self.xhssY);
        self.xhssY = topAddValue;
        return self;
    };
}
///     ???????
- (UIView*(^)(CGFloat  topAddValue))topAddToNumScreenFit {
    return ^(CGFloat  topAddValue) {
        self.xhssHeight -= (topAddValue * self.adaptationRate -self.xhssY);
        self.xhssY = topAddValue*self.adaptationRate;
        return self;
    };
}

/// *** sub by ***
- (UIView*(^)(CGFloat  topSubValue))topSubByNum {
    return ^(CGFloat  topSubValue) {
        self.xhssHeight -= topSubValue;
        self.xhssY += topSubValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  topSubValue))topSubByNumScreenFit {
    return ^(CGFloat  topSubValue) {
        self.xhssHeight -= topSubValue * self.adaptationRate;
        self.xhssY += topSubValue * self.adaptationRate;
        return self;
    };
}

/// *** sub to ***    ???????
- (UIView*(^)(CGFloat  topSubValue))topSubToNum {
    return ^(CGFloat  topSubValue) {
        self.xhssHeight -= (self.superview.xhssHeight - topSubValue -self.xhssY);
        self.xhssY = self.superview.xhssHeight - topSubValue;
        return self;
    };
}
///    ???????
- (UIView*(^)(CGFloat  topSubValue))topSubToNumScreenFit {
    return ^(CGFloat  topSubValue) {
        self.xhssHeight -= (self.superview.xhssHeight - topSubValue * self.adaptationRate -self.xhssY);
        self.xhssY = self.superview.xhssHeight -  topSubValue * self.adaptationRate;
        return self;
    };
}


/**
 Left
 */
/// *** add by ***
- (UIView*(^)(CGFloat  leftAddValue))leftAddByNum {
    return ^(CGFloat  leftAddValue) {
        self.xhssWidth += leftAddValue;
        self.xhssX -= leftAddValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  leftAddValue))leftAddByNumScreenFit {
    return ^(CGFloat  leftAddValue) {
        self.xhssWidth += leftAddValue * self.adaptationRate;
        self.xhssX -= leftAddValue * self.adaptationRate;
        return self;
    };
}

/// *** add to ***    ???????
- (UIView*(^)(CGFloat  leftAddValue))leftAddToNum {
    return ^(CGFloat  leftAddValue) {
        self.xhssWidth += (self.xhssX -leftAddValue);
        self.xhssX = leftAddValue;
        return self;
    };
}
///    ???????
- (UIView*(^)(CGFloat  leftAddValue))leftAddToNumScreenFit {
    return ^(CGFloat  leftAddValue) {
        self.xhssWidth += (self.xhssX - leftAddValue * self.adaptationRate);
        self.xhssX = leftAddValue * self.adaptationRate;
        return self;
    };
}

/// *** sub by ***
- (UIView*(^)(CGFloat  leftSubValue))leftSubByNum {
    return ^(CGFloat  leftSubValue) {
        self.xhssWidth -= leftSubValue;
        self.xhssX += leftSubValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  leftSubValue))leftSubByNumScreenFit {
    return ^(CGFloat  leftSubValue) {
        self.xhssWidth -= leftSubValue * self.adaptationRate;
        self.xhssX += leftSubValue * self.adaptationRate;
        return self;
    };
}

/// *** sub to ***    ???????
- (UIView*(^)(CGFloat  leftSubValue))leftSubToNum {
    return ^(CGFloat  leftSubValue) {
        self.xhssWidth -= (self.superview.xhssWidth -leftSubValue -self.xhssX);
        self.xhssX = self.superview.xhssWidth -leftSubValue;
        return self;
    };
}
///    ???????
- (UIView*(^)(CGFloat  leftSubValue))leftSubToNumScreenFit {
    return ^(CGFloat  leftSubValue) {
        self.xhssWidth -= (self.superview.xhssWidth -leftSubValue * self.adaptationRate -self.xhssX);
        self.xhssX = self.superview.xhssWidth -leftSubValue * self.adaptationRate;
        return self;
    };
}

/**
 Bottom
 */
/// *** add by ***
- (UIView*(^)(CGFloat  bottomAddValue))bottomAddByNum {
    return ^(CGFloat  bottomAddValue) {
        self.xhssHeight += bottomAddValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  bottomAddValue))bottomAddByNumScreenFit {
    return ^(CGFloat  bottomAddValue) {
        self.xhssHeight += bottomAddValue * self.adaptationRate;
        return self;
    };
}

/// *** add to ***    ???????
- (UIView*(^)(CGFloat  bottomAddValue))bottomAddToNum {
    return ^(CGFloat  bottomAddValue) {
        self.xhssMaxY = self.superview.xhssHeight - bottomAddValue;
        return self;
    };
}
///    ???????
- (UIView*(^)(CGFloat  bottomAddValue))bottomAddToNumScreenFit {
    return ^(CGFloat  bottomAddValue) {
        self.xhssMaxY = self.superview.xhssHeight - bottomAddValue * self.adaptationRate;
        return self;
    };
}

/// *** sub by ***
- (UIView*(^)(CGFloat  bottomSubValue))bottomSubByNum {
    return ^(CGFloat  bottomSubValue) {
        self.xhssHeight -= bottomSubValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  bottomSubValue))bottomSubByNumScreenFit {
    return ^(CGFloat  bottomSubValue) {
        self.xhssHeight -= bottomSubValue * self.adaptationRate;
        return self;
    };
}

/// *** sub to ***    ???????
- (UIView*(^)(CGFloat  bottomSubValue))bottomSubToNum {
    return ^(CGFloat  bottomSubValue) {
        self.xhssMaxY = self.superview.xhssHeight - bottomSubValue;
        return self;
    };
}
///    ???????
- (UIView*(^)(CGFloat  bottomSubValue))bottomSubToNumScreenFit {
    return ^(CGFloat  bottomSubValue) {
        self.xhssMaxY = self.superview.xhssHeight - bottomSubValue * self.adaptationRate;
        return self;
    };
}

/**
 Right
 */
/// *** add by ***
- (UIView*(^)(CGFloat  rightAddValue))rightAddByNum {
    return ^(CGFloat  rightAddValue) {
        self.xhssWidth += rightAddValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  rightAddValue))rightAddByNumScreenFit {
    return ^(CGFloat  rightAddValue) {
        self.xhssWidth += rightAddValue * self.adaptationRate;
        return self;
    };
}

/// *** add to ***    ???????
- (UIView*(^)(CGFloat  rightAddValue))rightAddToNum {
    return ^(CGFloat  rightAddValue) {
        self.xhssMaxX = self.superview.xhssWidth - rightAddValue;
        return self;
    };
}
///    ???????
- (UIView*(^)(CGFloat  rightAddValue))rightAddToNumScreenFit {
    return ^(CGFloat  rightAddValue) {
        self.xhssMaxX = self.superview.xhssWidth - rightAddValue * self.adaptationRate;
        return self;
    };
}

/// *** sub by ***
- (UIView*(^)(CGFloat  rightSubValue))rightSubByNum {
    return ^(CGFloat  rightSubValue) {
        self.xhssWidth -= rightSubValue;
        return self;
    };
}
- (UIView*(^)(CGFloat  rightSubValue))rightSubByNumScreenFit {
    return ^(CGFloat  rightSubValue) {
        self.xhssWidth -= rightSubValue * self.adaptationRate;
        return self;
    };
}

/// *** sub to ***    ???????
- (UIView*(^)(CGFloat  rightSubValue))rightSubToNum {
    return ^(CGFloat  rightSubValue) {
        self.xhssMaxX = self.superview.xhssWidth - rightSubValue;
        return self;
    };
}
///    ???????
- (UIView*(^)(CGFloat  rightSubValue))rightSubToNumScreenFit {
    return ^(CGFloat  rightSubValue) {
        self.xhssMaxX = self.superview.xhssWidth - rightSubValue * self.adaptationRate;
        return self;
    };
}














#pragma mark - ==============联调===============
// position
- (UIView*(^)())top {
    return ^() {
        [self pushStack:@(XHSSLayoutToolLayoutPositionTop)];
        return self;
    };
}
- (UIView*(^)())left {
    return ^() {
        [self pushStack:@(XHSSLayoutToolLayoutPositionLeft)];
        return self;
    };
}
- (UIView*(^)())bottom {
    return ^() {
        [self pushStack:@(XHSSLayoutToolLayoutPositionBottom)];
        return self;
    };
}
- (UIView*(^)())right {
    return ^() {
        [self pushStack:@(XHSSLayoutToolLayoutPositionRight)];
        return self;
    };
}

// layout type
// 参考视图
- (UIView*(^)(CGFloat distance))distance {
    return ^(CGFloat distance) {
        return self;
    };
}
- (UIView*(^)(UIView *refView))toRefView {
    return ^(UIView *refView) {
        return self;
    };
}
- (UIView*(^)(UIView *refView))toRefViewScreenFit {
    return ^(UIView *refView) {
        return self;
    };
}
- (UIView*(^)(CGFloat distance, UIView *refView))distanceToRefView {
    return ^(CGFloat distance, UIView *refView) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeDistanceToView value:distance refView:refView];
        return self;
    };
}
- (UIView*(^)(CGFloat distance, UIView *refView))distanceToRefViewScreenFit {
    return ^(CGFloat distance, UIView *refView) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeDistanceToViewScreenFit value:distance refView:refView];
        return self;
    };
}
// 相等
- (UIView*(^)(CGFloat value))equalToNum {
    return ^(CGFloat value) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeEqualToNum value:value refView:nil];
        return self;
    };
}
- (UIView*(^)(CGFloat value))equalToNumScreenFit {
    return ^(CGFloat value) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeEqualToNumScreenFit value:value refView:nil];
        return self;
    };
}
- (UIView*(^)(UIView *refView))equalToView {
    return ^(UIView *refView) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeEqualToView value:0 refView:refView];
        return self;
    };
}
// 对齐
- (UIView*(^)(CGFloat value))aligmentToNum {
    return ^(CGFloat value) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeAligmentToNum value:value refView:nil];
        return self;
    };
}
- (UIView*(^)(CGFloat value))aligmentToNumScreenFit {
    return ^(CGFloat value) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeAligmentToNumScreenFit value:value refView:nil];
        return self;
    };
}
- (UIView*(^)(UIView *refView))aligmentToView {
    return ^(UIView *refView) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeAligmentToView value:0 refView:refView];
        return self;
    };
}
// 平移
- (UIView*(^)(CGFloat value))moveByNum {
    return ^(CGFloat value) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeMoveByNum value:value refView:nil];
        return self;
    };
}
- (UIView*(^)(CGFloat value))moveByNumScreenFit {
    return ^(CGFloat value) {
        [self executeContinueWithLayoutType:XHSSLayoutToolLayoutTypeMoveByNumScreenFit value:value refView:nil];
        return self;
    };
}

#warning HERE CODE IS TOO LONG , SHOULD REPLACE IT BY OTHER METHOD
- (void)executeContinueWithLayoutType:(XHSSLayoutToolLayoutType)layoutType value:(CGFloat)value refView:(UIView*)refView {
    NSMutableArray *abc = [NSMutableArray array];
    while ([self stackObjectCount] > 0) {
        [abc addObject:[self popStack]];
    }
    for (NSInteger i=0; i<abc.count; i++) {
        [self executeLayoutOprationAtPosition:[abc[i] integerValue] layoutType:layoutType value:value refView:refView];
    }
   
//    while ([self stackObjectCount] > 0) {
//        [self executeLayoutOprationAtPosition:[[self popStack] integerValue] layoutType:layoutType value:value refView:refView];
//    }
}

// execute fountion
- (void)executeLayoutOprationAtPosition:(XHSSLayoutToolLayoutPosition)position layoutType:(XHSSLayoutToolLayoutType)layoutType value:(CGFloat)value refView:(UIView*)refView {
    switch (position) {
        case XHSSLayoutToolLayoutPositionTop:{
            [self layoutTopWithLayoutType:layoutType value:value refView:refView];
        }
            break;
        case XHSSLayoutToolLayoutPositionLeft:{
            [self layoutLeftWithLayoutType:layoutType value:value refView:refView];
        }
            break;
        case XHSSLayoutToolLayoutPositionBottom:{
            [self layoutBottomWithLayoutType:layoutType value:value refView:refView];
        }
            break;
        case XHSSLayoutToolLayoutPositionRight:{
            [self layoutRightWithLayoutType:layoutType value:value refView:refView];
        }
            break;
            
        default:
            break;
    }
}

- (void)layoutTopWithLayoutType:(XHSSLayoutToolLayoutType)layoutType value:(CGFloat)value refView:(UIView*)refView {
    switch (layoutType) {
        case XHSSLayoutToolLayoutTypeDistanceToView:{
            self.topDistance(value).toRefView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeDistanceToViewScreenFit:{
            self.topDistance(value).toRefViewScreenFit(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToNum:{
            self.topEqualToNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToNumScreenFit:{
            self.topEqualToNumScreenFit(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToView:{
            self.topEqualToView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToNum:{
            // has not this founction now
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToNumScreenFit:{
            // has not this founction now
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToView:{
            // has not this founction now
        }
            break;
        case XHSSLayoutToolLayoutTypeMoveByNum:{
            self.moveUpByNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeMoveByNumScreenFit:{
            self.moveUpByNumScreenFit(value);
        }
            break;
        default:
            break;
    }
}
- (void)layoutLeftWithLayoutType:(XHSSLayoutToolLayoutType)layoutType value:(CGFloat)value  refView:(UIView*)refView {
    switch (layoutType) {
        case XHSSLayoutToolLayoutTypeDistanceToView:{
            self.leftDistance(value).toRefView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeDistanceToViewScreenFit:{
            self.leftDistance(value).toRefViewScreenFit(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToNum:{
            self.leftEqualToNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToNumScreenFit:{
            self.leftEqualToNumScreenFit(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToView:{
            self.leftEqualToView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToNum:{
            // has not this founction now
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToNumScreenFit:{
            // has not this founction now
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToView:{
            // has not this founction now
        }
            break;
        case XHSSLayoutToolLayoutTypeMoveByNum:{
            self.moveLeftByNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeMoveByNumScreenFit:{
            self.moveLeftByNumScreenFit(value);
        }
            break;
        default:
            break;
    }
}
- (void)layoutBottomWithLayoutType:(XHSSLayoutToolLayoutType)layoutType value:(CGFloat)value  refView:(UIView*)refView {
    switch (layoutType) {
        case XHSSLayoutToolLayoutTypeDistanceToView:{
            self.bottomDistance(value).toRefView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeDistanceToViewScreenFit:{
            self.bottomDistance(value).toRefViewScreenFit(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToNum:{
            self.bottomEqualToNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToNumScreenFit:{
            self.bottomEqualToNumScreenFit(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToView:{
            self.bottomEqualToView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToNum:{
            self.bottomAligmentToNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToNumScreenFit:{
            self.bottomAligmentToNumScreenFit(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToView:{
            self.bottomAligmentToView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeMoveByNum:{
            self.moveDwonByNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeMoveByNumScreenFit:{
            self.moveDwonByNumScreenFit(value);
        }
            break;
        default:
            break;
    }
}
- (void)layoutRightWithLayoutType:(XHSSLayoutToolLayoutType)layoutType value:(CGFloat)value refView:(UIView*)refView {
    switch (layoutType) {
        case XHSSLayoutToolLayoutTypeDistanceToView:{
            self.rightDistance(value).toRefView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeDistanceToViewScreenFit:{
            self.rightDistance(value).toRefViewScreenFit(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToNum:{
            self.rightEqualToNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToNumScreenFit:{
            self.rightEqualToNumScreenFit(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeEqualToView:{
            self.rightEqualToView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToNum:{
            self.rightAligmentToNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToNumScreenFit:{
            self.rightAligmentToNumScreenFit(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeAligmentToView:{
            self.rightAligmentToView(refView);
        }
            break;
        case XHSSLayoutToolLayoutTypeMoveByNum:{
            self.moveRightByNum(value);
        }
            break;
        case XHSSLayoutToolLayoutTypeMoveByNumScreenFit:{
            self.moveRightByNumScreenFit(value);
        }
            break;
        default:
            break;
    }
}

#pragma mark - ==================== stack opration ===================
- (void)pushStack:(id)object {
    [self.stack addObject:object];
}
- (id)popStack {
    if (self.stack.count == 0) {
        return nil;
    }
    
    id object = [self.stack lastObject];
    [self.stack removeLastObject];
    return object;
}
- (NSInteger)stackObjectCount {
    return self.stack.count;
}
- (void)clearStack {
    [self.stack removeAllObjects];
}




#pragma mark - ==============块调用函数===============
- (UIView*(^)(XHSSLayoutBlock layout))addLayout {
    return ^(XHSSLayoutBlock layout) {
        if (layout) {
            layout(self);
        }
        return self;
    };
}

@end

