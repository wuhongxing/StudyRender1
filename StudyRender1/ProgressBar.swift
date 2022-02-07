//
//  ProgressBar.swift
//  StudyRender1
//
//  Created by 吴红星 on 2022/2/5.
//

import Foundation
import UIKit

class ProgressBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: bounds.width / 2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.cyan.cgColor
        shape.fillColor = UIColor.red.cgColor
        
        let group = CAAnimationGroup()
        let random = 0.5
        
        let basic = CABasicAnimation(keyPath: "strokeEnd")
        basic.fromValue = random
        basic.toValue = 1 + random
        basic.duration = 0.5
        
        let basic1 = CABasicAnimation(keyPath: "strokeStart")
        basic1.fromValue = random
        basic1.toValue = 1 + random
        basic1.duration = 0.5
        basic1.beginTime = 0.5
        group.animations = [basic, basic1]
        group.duration = 1
        group.repeatCount = .infinity
        shape.add(group, forKey: "basic")
        layer.addSublayer(shape)
    }
    
    func start() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
