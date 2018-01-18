# XHSSFrameLayoutTool
基于frame 的布局、适配工具，语法简洁易读
使用方法：
        导入 XHSSLayout 文件夹下的4个文件，然后在需要布局的文件中导入"UIView+XHSSLayoutTool.h" 即可使用
        
说明：
        .laBaseScreenWidth(375) 方法当在不同屏幕尺寸下需要按照比例适配时调用，而且应当首先被调用，然后再调用其他布局方法；该方法参数为当前参照的设计图所使用的屏幕宽度
        其他方法作用效果参见方法名称及部分注释
        
使用示例：

UIView *targetView = [[UIView alloc] init];
[self.view addSubview:targetView];
/////////////////////////布局测试//////////////////////////////////
targetView
.widthEqualToNum(100)
.heightEqualToNum(200)
.centerEqualToViewCenterPoint(self.view)

/////////////////////////参考视图//////////////////////////////////
/// *** ***
.topDistance(200).toTopRefView(topView)
.leftDistance(10).toLeftRefView(leftView)
.bottomDistance(100).toBottomRefView(bottomiew)
.rightDistance(10).toRightRefView(rightView)

/// *** ***
.laBaseScreenWidth(375).topDistance(200).toTopRefViewScreenFit(topView)
.laBaseScreenWidth(375).leftDistance(10).toLeftRefViewScreenFit(leftView)
.laBaseScreenWidth(375).bottomDistance(100).toBottomRefViewScreenFit(bottomiew)
.laBaseScreenWidth(320).rightDistance(10).toRightRefViewScreenFit(rightView)

/////////////////////////固定数值//////////////////////////////////
/// *** ***
.topEqualToNum(10)
.leftEqualToNum(20)
.bottomEqualToNum(30)
.rightEqualToNum(40)

/// *** ***
.laBaseScreenWidth(375).topEqualToNumScreenFit(10)
.laBaseScreenWidth(375).leftEqualToNumScreenFit(20)
.laBaseScreenWidth(375).bottomEqualToNumScreenFit(30)
.laBaseScreenWidth(375).rightEqualToNumScreenFit(40)

/// *** ***
.widthEqualToNum(200)
.heightEqualToNum(100)

/// *** ***
.laBaseScreenWidth(375).widthEqualToNumScreenFit(200)
.laBaseScreenWidth(375).heightEqualToNumScreenFit(100)

/// *** ***
.centerEqualToNum(self.view.center)

/////////////////////////视图相等//////////////////////////////////
.bottomEqualToView(leftView)  /// assistant
/// *** ***
.topEqualToView(rightView)
.topEqualToViewTop(leftView)
.topEqualToViewCenter(rightView)
.topEqualToViewBottom(topView)

.rightEqualToView(bottomiew)  /// assistant
/// *** ***
.leftEqualToView(topView)
.leftEqualToViewLeft(topView)
.leftEqualToViewCenter(topView)
.leftEqualToViewRight(topView)

.topEqualToView(rightView)  /// assistant
/// *** ***
.bottomEqualToView(leftView)
.bottomEqualToViewTop(leftView)
.bottomEqualToViewCenter(leftView)
.bottomEqualToViewBottom(leftView)

.leftEqualToView(topView)  /// assistant
/// *** ***
.rightEqualToView(bottomiew)
.rightEqualToViewLeft(bottomiew)
.rightEqualToViewCenter(bottomiew)
.rightEqualToViewRight(bottomiew)

/// *** ***
.widthEqualToView(topView)
.heightEqualToView(rightView)

/// *** ***
.centerEqualToView(self.view)
.centerEqualToViewCenterPoint(self.view)

.centerXEqualToNum(targetView.xhssWidth/2.0 +10)
.laBaseScreenWidth(375).centerXEqualToNumScreenFit(targetView.xhssWidth/2.0 +10)

.centerXEqualToView(topView)

.centerYEqualToNum(targetView.xhssHeight/2.0 +10)
.laBaseScreenWidth(375).centerYEqualToNumScreenFit(targetView.xhssHeight/2.0 +10)

.centerYEqualToView(rightView)

/////////////////////////对齐//////////////////////////////////
.widthEqualToNum(100).heightEqualToNum(100)  /// assistant
/// *** ***
.topAligmentToNum(10)
.laBaseScreenWidth(375).topAligmentToNumScreenFit(20)

.topAligmentToView(leftView)
.topAligmentToViewTop(leftView)
.topAligmentToViewCenter(leftView)
.topAligmentToViewBotton(leftView)

/// *** ***
.leftAligmentToNum(10)
.laBaseScreenWidth(375).leftAligmentToNumScreenFit(20)

.leftAligmentToView(bottomiew)
.leftAligmentToViewCenter(bottomiew)
.leftAligmentToViewRight(bottomiew)
.leftAligmentToViewLeft(bottomiew)

/// *** ***
.bottomAligmentToNum(10)
.laBaseScreenWidth(375).bottomAligmentToNumScreenFit(20)

.bottomAligmentToView(leftView)
.bottomAligmentToViewTop(leftView)
.bottomAligmentToViewCenter(leftView)
.bottomAligmentToViewBotton(leftView)

/// *** ***
.rightAligmentToNum(10)
.laBaseScreenWidth(375).rightAligmentToNumScreenFit(20)

.rightAligmentToView(topView)
.rightAligmentToViewLeft(topView)
.rightAligmentToViewCenter(topView)
.rightAligmentToViewRight(topView)

/// *** ***
.centerXAligmentToNum(targetView.xhssWidth/2.0 +10)
.laBaseScreenWidth(375).centerXAligmentToNumScreenFit(targetView.xhssWidth/2.0 +10)

.centerXAligmentToView(topView)
.centerXAligmentToViewLeft(topView)
.centerXAligmentToViewCenterX(topView)
.centerXAligmentToViewRight(topView)

.centerYAligmentToNum(targetView.xhssHeight/2.0 +10)
.laBaseScreenWidth(375).centerYAligmentToNumScreenFit(targetView.xhssHeight/2.0 +10)

.centerYAligmentToView(rightView)
.centerYAligmentToViewTop(rightView)
.centerYAligmentToViewCenterY(rightView)
.centerYAligmentToViewBottom(rightView)

/////////////////////////平移//////////////////////////////////
/// *** ***
.moveUpByNum(targetView.xhssHeight/2.0)
.laBaseScreenWidth(320).moveUpByNumScreenFit(targetView.xhssHeight/2.0)

.moveUpToNum(10)
.laBaseScreenWidth(375).moveUpToNumScreenFit(10)

/// *** ***
.moveLeftByNum(targetView.xhssWidth/2.0)
.laBaseScreenWidth(375).moveLeftByNumScreenFit(targetView.xhssWidth/2.0)

.moveLeftToNum(10)
.laBaseScreenWidth(375).moveLeftToNumScreenFit(10)

/// *** ***
.moveDwonByNum(20)
.laBaseScreenWidth(375).moveDwonByNumScreenFit(20)

.moveDwonToNum(10)
.laBaseScreenWidth(375).moveDwonToNumScreenFit(10)

/// *** ***
.moveRightByNum(20)
.laBaseScreenWidth(375).moveRightByNumScreenFit(20)

.moveRightToNum(10)
.laBaseScreenWidth(375).moveRightToNumScreenFit(10)

/////////////////////////增长//////////////////////////////////
/// *** ***
.topAddByNum(100)
.laBaseScreenWidth(375).topAddByNumScreenFit(100)

.topSubByNum(100)
.laBaseScreenWidth(375).topSubByNumScreenFit(100)

.topAddToNum(10)
.laBaseScreenWidth(375).topAddToNumScreenFit(10)

.topSubToNum(30)
.laBaseScreenWidth(375).topSubToNumScreenFit(30)

/// *** ***
.leftAddByNum(100)
.laBaseScreenWidth(375).leftAddByNumScreenFit(100)

.leftSubByNum(100)
.laBaseScreenWidth(375).leftSubByNumScreenFit(100)

.leftAddToNum(10)
.laBaseScreenWidth(375).leftAddToNumScreenFit(10)

.leftSubToNum(30)
.laBaseScreenWidth(375).leftSubToNumScreenFit(30)

/// *** ***
.moveUpByNum(20)  /// assistant

.bottomAddByNum(20)
.laBaseScreenWidth(375).bottomAddByNumScreenFit(20)

.bottomSubByNum(20)
.laBaseScreenWidth(375).bottomSubByNumScreenFit(20)

.bottomAddToNum(10)
.laBaseScreenWidth(375).bottomAddToNumScreenFit(10)

.bottomSubToNum(30)
.laBaseScreenWidth(375).bottomSubToNumScreenFit(30)

/// *** ***
.moveLeftByNum(20)  /// assistant

.rightAddByNum(20)
.laBaseScreenWidth(375).rightAddByNumScreenFit(20)

.rightSubByNum(20)
.laBaseScreenWidth(375).rightSubByNumScreenFit(20)

.rightAddToNum(10)
.laBaseScreenWidth(375).rightAddToNum(10)

.rightSubToNum(20)
.laBaseScreenWidth(375).rightSubToNumScreenFit(30)
;


/////////////////////////块调用函数//////////////////////////////////
targetView.addLayout(^(UIView *manager) {
manager
.widthEqualToNum(100)
.heightEqualToNum(100)
.centerEqualToViewCenterPoint(self.view);
});
