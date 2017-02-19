//
//  FaceView.swift
//  HappineSwiftDemo
//
//  Created by Stray on 17/2/19.
//  Copyright © 2017年 XXTechnology Co.,Ltd. All rights reserved.
//

import UIKit
//设置代理，只能让类去实现
protocol FaceViewDataSource: class {
    func smilinessForFfaceView(sender: FaceView) -> Double?
    
}

/// 加上@IBDesignable 可以让storyboard 预览这个faceView UI
@IBDesignable
class FaceView: UIView {
    @IBInspectable //可以在 xib 上新增这个设置属性，后面改动的话，直接在xib上进行
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var color: UIColor = UIColor.blue { didSet { setNeedsDisplay() } }
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    
    var faceCenter: CGPoint {
        return convert(center, from: superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    //定义一个代理属性，可以为nil
    weak var dataSource: FaceViewDataSource?
    
    //外部访问的手势方法
    func scaleAction(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
    
    //定义一个私有的结构体
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    private enum Eye { case Left, Right }
    
    //画左右两个眼睛的私有方法
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticaloffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticaloffset
        switch whichEye {
        case .Left: eyeCenter.x -= eyeHorizontalSeparation / 2
        case .Right: eyeCenter.x += eyeHorizontalSeparation / 2
        }
        
        let path = UIBezierPath(arcCenter:eyeCenter,
                                radius: eyeRadius,
                                startAngle: 0,
                                endAngle: CGFloat(2*M_PI),
                                clockwise: true
        )
        
        return path
    }
    
    //画笑脸的线条
    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
        
    }
    
    
    //重写系统方法
    override func draw(_ rect: CGRect) {
        let facePath = UIBezierPath(
            arcCenter:faceCenter,
            radius: faceRadius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        
        facePath.lineWidth = lineWidth
        
        color.set()
        facePath.stroke()
        
        bezierPathForEye(whichEye: .Left).stroke()
        bezierPathForEye(whichEye: .Right).stroke()
        
        let smiliness = dataSource?.smilinessForFfaceView(sender: self) ??  0.0
        let smilePath = bezierPathForSmile(fractionOfMaxSmile: smiliness)
        smilePath.stroke()
        
        
    }
    

}
