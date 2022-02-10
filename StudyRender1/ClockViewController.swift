//
//  GStoreViewController.swift
//  StudyRender1
//
//  Created by 吴红星 on 2022/2/9.
//

import UIKit

class ClockViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let gView = ClockView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 400))
        gView.backgroundColor = UIColor.red
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.duration = 2
        anim.fromValue = 0
        anim.toValue = CGFloat.pi * 2
        gView.layer.add(anim, forKey: "test")
     
        view.addSubview(gView)
        
        let fView = FView(frame: CGRect(x: 0, y: 550, width: view.bounds.width, height: 200))
        fView.backgroundColor = UIColor.orange
        view.addSubview(fView)
    }
}

class FView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        // 从下面这两个区别就可以看出，一个是更改了 context 当前的属性，而另一个是生成了一个新的 context
        // saveGState/restoreGState
        // save 相当于我把当前画板的属性快照
        // restore 回退到快照状态
//        UIColor.red.setFill()
//        UIRectFill(CGRect(x: 0, y: 0, width: 50, height: 50))
//        context.saveGState()
//        UIColor.black.setFill()
//        UIRectFill(CGRect(x: 50, y: 0, width: 50, height: 50))
//        context.restoreGState()
//        UIRectFill(CGRect(x: 100, y: 0, width: 50, height: 50))
        
        UIColor.red.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 50, height: 50))
        UIGraphicsPushContext(context)
        UIColor.black.setFill()
        UIRectFill(CGRect(x: 50, y: 0, width: 50, height: 50))
        UIGraphicsPopContext()
        UIRectFill(CGRect(x: 100, y: 0, width: 50, height: 50))
        context.beginPath()
    }
}

class ClockView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.translateBy(x: rect.width / 2, y: 200)
        for i in 1 ... 20 {
            context.saveGState()
            context.rotate(by: .pi * 2 / 20 * CGFloat(i))
            context.translateBy(x: 0, y: 80)
            context.fill(CGRect(x: 0, y: 0, width: 10, height: 30))
            context.restoreGState()
        }
        context.addArc(center: CGPoint(x: 0, y: 0), radius: 80, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        context.strokePath()
        context.addArc(center: CGPoint(x: 0, y: 0), radius: 110, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        context.strokePath()
    }
}
