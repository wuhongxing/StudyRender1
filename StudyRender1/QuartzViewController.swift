//
//  QuartzViewControoler.swift
//  StudyRender1
//
//  Created by 吴红星 on 2022/2/9.
//

import UIKit

class QuartzViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan
        let view1 = UIView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 200))
        let imageView = UIImageView(image: UIImage(named: "test"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view1.addSubview(imageView)
        view1.backgroundColor = UIColor.red
        let transform = CGAffineTransform(a: 1, b: 1, c: -1, d: 1, tx: 0, ty: 0)
        imageView.transform = transform
        view.addSubview(view1)
        
        let view2 = UIView(frame: CGRect(x: 0, y: 350, width: view.bounds.width, height: 200))
        view2.backgroundColor = .red
        let tr1 = TrView1(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view2.addSubview(tr1)
        
        let tr2 = TrView2(frame: CGRect(x: 220, y: 0, width: 200, height: 200))
        view2.addSubview(tr2)
        view.addSubview(view2)
        
        let view3 = BezierView(frame: CGRect(x: 0, y: 600, width: view.bounds.width, height: 200))
//        let imageView1 = UIImageView(image: UIImage(named: "test"))
//        imageView1.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        view3.addSubview(imageView1)
        view3.backgroundColor = UIColor.red
        view.addSubview(view3)
    }
}

class TrView1: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)
        // TODO: 后期还要再了解一下这个到底有什么用！
        context?.saveGState()
        let rect = CGRect(x: 20, y: 20, width: 50, height: 50)
        context?.setFillColor(UIColor.orange.cgColor)
        context?.fill(rect)
        context?.setShadow(offset: CGSize(width: -15, height: 20), blur: 5)
        context?.fill(rect)
        
        let rect1 = CGRect(x: 45, y: 45, width: 50, height: 50)
        context?.setFillColor(UIColor.blue.cgColor)
        context?.fill(rect1)
        context?.setShadow(offset: CGSize(width: -15, height: 20), blur: 5)
        
        let rect2 = CGRect(x: 65, y: 65, width: 50, height: 50)
        context?.setFillColor(UIColor.red.cgColor)
        context?.fill(rect2)
        context?.setShadow(offset: CGSize(width: -15, height: 20), blur: 5)
        context?.restoreGState()
    }
}
class TrView2: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)
        context?.setShadow(offset: CGSize(width: -15, height: 20), blur: 5)
        context?.beginTransparencyLayer(in: rect, auxiliaryInfo: nil)
        let rect = CGRect(x: 20, y: 20, width: 50, height: 50)
        context?.setFillColor(UIColor.orange.cgColor)
        context?.fill(rect)
        
        let rect1 = CGRect(x: 45, y: 45, width: 50, height: 50)
        context?.setFillColor(UIColor.blue.cgColor)
        context?.fill(rect1)
        
        let rect2 = CGRect(x: 65, y: 65, width: 50, height: 50)
        context?.setFillColor(UIColor.red.cgColor)
        context?.fill(rect2)
        context?.endTransparencyLayer()
    }
}

class BezierView: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.addArc(center: CGPoint(x: 50, y: 50), radius: 40, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        context?.setFillColor(UIColor.blue.cgColor)
        context?.fillPath()
        context?.addArc(center: CGPoint(x: 50, y: 50), radius: 20, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        context?.clip()
        context?.addArc(center: CGPoint(x: 50, y: 50), radius: 40, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        context?.setFillColor(UIColor.white.cgColor)
        context?.fillPath()
    }
}
