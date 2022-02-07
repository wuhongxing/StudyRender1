//
//  AsyncViewController.swift
//  StudyRender1
//
//  Created by 吴红星 on 2022/2/7.
//

import UIKit

// TODO: 总结 UIView 绘制流程
 
class AsyncViewController: UIViewController {
    private lazy var myview: MyView = {
        let view = MyView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 500))
        view.backgroundColor = .cyan
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(myview)
        // 如果这里不调用的话，那么 dipaly 就不会被调用
        // 思考：为什么 display 方法不应该被直接调用
        // 还要被设计成公开的 api
//        myview.layer.setNeedsDisplay()
        
    }
}

class MyView: UIView {
//    override class var layerClass: AnyClass {
//        return MyLayer.self
//    }
    
//    override func display(_ layer: CALayer) {
//
//    }
    
    // 这个方法只要被调用，内存就会大量增长
    // 2532*1170
    // 能不用这个方法就不要用这个方法
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.addArc(center: CGPoint(x: 50, y: 50), radius: 40, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        context?.setFillColor(UIColor.red.cgColor)
//        let path = UIBezierPath(arcCenter: CGPoint(x: 50, y: 50), radius: 40, startAngle: 0, endAngle: .pi * 2, clockwise: true)
//        UIColor.red.setFill()
//        path.fill()
    }
}

class MyLayer: CALayer {
    override func display() {
        
    }
}
