//
//  ViewController.swift
//  HappineSwiftDemo
//
//  Created by Stray on 17/2/19.
//  Copyright © 2017年 XXTechnology Co.,Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController , FaceViewDataSource{

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            //用代码添加一个拖动手势
            faceView.addGestureRecognizer(UIPinchGestureRecognizer.init(target: faceView, action: #selector(faceView.scaleAction(gesture:))))
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    
    //xib 拖拽手势
    @IBAction func changeHappinessAction(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .ended: fallthrough
        case .changed:
            let translation = sender.translation(in: faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPoint.zero, in: faceView)
            }
            break
        default:
            break
        }
    }
    
    
    
    var happiness: Int = 70 {
        didSet{
            happiness = min(max(happiness, 0), 100)
            
            print("happiness = \(happiness)")
            updataUI()
        }
    }
    
    
    
    func updataUI()  {
        faceView.setNeedsDisplay()
    }
    
    
    
    func smilinessForFfaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
    
    
}

