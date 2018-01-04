//
//  UIView+XHSSFrameTool.m
//  XiaoHaiLayoutFramework
//
//  Created by Apple on 2017/10/28.
//  Copyright © 2017年 XiaoHai. All rights reserved.
//

#import "UIView+XHSSFrameTool.h"

@implementation UIView (XHSSFrameTool)

// x
- (CGFloat)xhssX {
    return self.frame.origin.x;
}
- (void)setXhssX:(CGFloat)xhssX {

    CGRect oldFrame = self.frame;
    oldFrame.origin.x = xhssX;
    self.frame = oldFrame;
}

// y
- (CGFloat)xhssY {
    return self.frame.origin.y;
}
- (void)setXhssY:(CGFloat)xhssY {
    CGRect oldFrame = self.frame;
    oldFrame.origin.y = xhssY;
    self.frame = oldFrame;
}

// maxX
- (CGFloat)xhssMaxX {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setXhssMaxX:(CGFloat)xhssMaxX {
    CGRect oldFrame = self.frame;
    oldFrame.size.width = self.superview.frame.size.width - self.frame.origin.x - (self.superview.frame.size.width - xhssMaxX);
    self.frame = oldFrame;
}

// maxY
- (CGFloat)xhssMaxY {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setXhssMaxY:(CGFloat)xhssMaxY {
    CGRect oldFrame = self.frame;
    oldFrame.size.height = self.superview.frame.size.height - self.frame.origin.y - (self.superview.frame.size.height - xhssMaxY);
    self.frame = oldFrame;
}

// width
- (CGFloat)xhssWidth {
    return self.frame.size.width;
}
- (void)setXhssWidth:(CGFloat)xhssWidth {
    CGRect oldFrame = self.frame;
    oldFrame.size.width = xhssWidth;
    self.frame = oldFrame;
}

// height
- (CGFloat)xhssHeight {
    return self.frame.size.height;
}
- (void)setXhssHeight:(CGFloat)xhssHeight {
    CGRect oldFrame = self.frame;
    oldFrame.size.height = xhssHeight;
    self.frame = oldFrame;
}

// center
- (CGPoint)xhssCenter {
    return self.center; //CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
}
- (void)setXhssCenter:(CGPoint)xhssCenter {
    CGRect oldFrame = self.frame;
    oldFrame.origin.x = xhssCenter.x - self.frame.size.width/2.0;
    oldFrame.origin.y = xhssCenter.y - self.frame.size.height/2.0;
    self.frame = oldFrame;
}

// origin
- (CGPoint)xhssOrigin {
    return self.frame.origin;
}
- (void)setXhssOrigin:(CGPoint)xhssOrigin {
    CGRect oldFrame = self.frame;
    oldFrame.origin.x = xhssOrigin.x;
    oldFrame.origin.y = xhssOrigin.y;
    self.frame = oldFrame;
}

// bounds
- (CGSize)xhssBounds {
    return self.bounds.size;
}
- (void)setXhssBounds:(CGSize)xhssBounds {
    CGRect oldFrame = self.frame;
    oldFrame.size = xhssBounds;
    self.frame = oldFrame;
}

@end
