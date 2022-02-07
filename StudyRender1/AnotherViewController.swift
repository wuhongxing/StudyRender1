//
//  AnotherViewController.swift
//  StudyRender1
//
//  Created by 吴红星 on 2022/2/7.
//

import UIKit

class AnotherViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 250, width: 100, height: 100))
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 400, width: 100, height: 100))
        return label
    }()
    
    private lazy var _view: UIView = {
        let view = UIView(frame: CGRect(x: 100, y: 550, width: 100, height: 100))
        return view
    }()
    
    // 如果有子视图时也需要切圆角
    private lazy var mulView: UIView = {
        let view = UIView(frame: CGRect(x: 220, y: 100, width: 100, height: 200))
        view.backgroundColor = .orange
        view.layer.cornerRadius = 20
        /*
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view1.backgroundColor = .red
        let view2 = UIView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        view2.backgroundColor = .blue
        view.addSubview(view1)
        view.addSubview(view2)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
         */
        
        let layer1 = CAShapeLayer()
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 20, width: 100, height: 100), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
        layer1.path = path.cgPath
        layer1.fillColor = UIColor.red.cgColor
        view.layer.addSublayer(layer1)

        let layer2 = CAShapeLayer()
        let path2 = UIBezierPath(roundedRect: CGRect(x: 0, y:100, width: 100, height: 80), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        layer2.path = path2.cgPath
        layer2.fillColor = UIColor.blue.cgColor
        view.layer.addSublayer(layer2)
        return view
    }()
    
    // 画一个只有一个圆角的 view
    let cornerView: UIView = {
        let view = UIView(frame: CGRect(x: 220, y: 350, width: 100, height: 200))
        let layer = CAShapeLayer()
        layer.frame = view.bounds
        let path = UIBezierPath(roundedRect: layer.bounds, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: 20, height: 10))
        layer.path = path.cgPath
        layer.fillColor = UIColor.cyan.cgColor
        view.isUserInteractionEnabled = true
        view.layer.addSublayer(layer)
        let tap = UITapGestureRecognizer(target: self, action: #selector(test))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    // 直接设置圆角和阴影也是不会发生离屏渲染的
    let shadowCornerView: UIView = {
         let view = UIView(frame: CGRect(x: 220, y: 600, width: 100, height: 100))
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOpacity = 1
        view.backgroundColor = UIColor.orange
        view.layer.cornerRadius = 50
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 50, height: 50))
        view.layer.shadowPath = path.cgPath
        return view
    }()
    
    // 这样写不可以
    let bezierView: UIView = {
         let view = UIView(frame: CGRect(x: 220, y: 720, width: 100, height: 100))
        let path = UIBezierPath(arcCenter: CGPoint(x: 50, y: 50), radius: 40, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        UIColor.red.setFill()
        path.fill()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        // 当我们只是单纯的设置 image 或者 backgroundcolor 的时候
        // 这个时候是不会触发离屏渲染的
        // 设置 background = .clear 的时候也是不会触发离屏渲染的
        // 所以看网上很多说图片必须要同时设置两个值后会产生离屏渲染错的离谱
        // 然后必须要在子线程 clip 到主线程中再显示
//        imageView.backgroundColor = UIColor.red
//        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.imageView.image = UIImage(named: "wechatPay")
            // 这里无论是大图还是小图，都是不会
            self.imageView.image = UIImage(named: "test")
        }
        
        view.addSubview(button)
        button.setTitle("TEST", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.red
        // 直接设置 cornerRadius 就可以了
        // 这里要是加了 layer.masksToBounds = true
        // 那么就会触发离屏渲染
        button.layer.cornerRadius = 50
        
        view.addSubview(label)
        label.text = "TEST"
        label.textColor = UIColor.white
        // 这里的 bakcgroundColor 是被特殊处理过的
        // 设置的并不是 layer.background
        // 而是 layer 的 content
        // TODO: 这里的说法是网上看的，还是待验证的，我打印重设值都是没有成功的
        label.backgroundColor = UIColor.blue
        
        // 如果这样设置是会触发离屏渲染的
//        label.layer.backgroundColor = UIColor.blue.cgColor
        label.layer.cornerRadius = 50
        label.layer.masksToBounds = true
        
        view.addSubview(_view)
        _view.backgroundColor = UIColor.orange
        _view.layer.cornerRadius = 50
        
        view.addSubview(mulView)
        view.addSubview(cornerView)
        view.addSubview(shadowCornerView)
        view.addSubview(bezierView)
    }
    
    @objc private func test() {
        print("tap")
    }
}
