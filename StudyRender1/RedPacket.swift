//
//  RedPacket.swift
//  StudyRender1
//
//  Created by 吴红星 on 2022/2/5.
//

import Foundation
import UIKit

class RedPacket {
    static var scoreView: UILabel = {
        let x = UIScreen.main.bounds.width / 2 - 50
        let y = UIScreen.main.bounds.height / 2 - 25
        let scoreView = UILabel(frame: CGRect(x: x, y: y, width: 100, height: 50))
        scoreView.font = UIFont.systemFont(ofSize: 30)
        scoreView.text = "+0"
        return scoreView
    }()
    
    static var score: Int = 0 {
        didSet {
            scoreView.text = "+\(score)"
        }
    }
    
    static func start(in view: UIView) {
        let redPacketView = RedPacketView(frame: view.bounds)
        redPacketView.callback = {
            score += 1
        }
        view.addSubview(redPacketView)
        view.addSubview(scoreView)
    }
}



class RedPacketView: UIView {
    var packets = Set<RedPacketModel>()
    var reusePackets = Set<RedPacketModel>()
    var callback: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let timer = Timer(timeInterval: 1, repeats: true) { [weak self] timer in
            (0 ..< 3).forEach { i in
                var view: RedPacketModel! = self?.reusePackets.popFirst()
                if view == nil { view = RedPacketModel() }
                let width = UIScreen.main.bounds.width / 3
                let x = arc4random() % UInt32(width - 50)
                view.frame = CGRect(x: Int(width) * i + Int(x), y: 20, width: 80, height: 80)
                view.reuse()
                view.speed = CGFloat(arc4random() % 10 / 3) + 2
                view.backgroundColor = .red
                view.addTarget(self, action: #selector(self?.tap(_:)), for: .touchUpInside)
                self?.addSubview(view)
                view?.layer.cornerRadius = 10
                self?.packets.insert(view)
            }
        }
        RunLoop.main.add(timer, forMode: .default)

        let displayLink = CADisplayLink(target: self, selector: #selector(rain))
        displayLink.add(to: RunLoop.main, forMode: .default)
    }

    @objc private func rain() {
        packets.forEach { view in
            view.down()
            if view.frame.minY > UIScreen.main.bounds.height || view.frame.width < 50 {
                putInReuse(view)
                removeFromPackets(view)
            }
        }
    }
    
    private func putInReuse(_ view: RedPacketModel) {
        reusePackets.insert(view)
    }
    
    private func removeFromPackets(_ view: RedPacketModel) {
        packets.remove(view)
        view.removeFromSuperview()
    }

    @objc private func tap(_ view: UIButton) {
        view.isSelected = true
        view.backgroundColor = .orange
        callback?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class RedPacketModel: UIButton {
        var isClicked: Bool = false
        var speed: CGFloat = 2
        
        func down() {
            if isSelected {
                frame = CGRect(x: frame.minX + 0.2, y: frame.minY + speed + 0.1, width: bounds.width - 0.4, height: bounds.height - 0.4)
            } else {
                frame = CGRect(x: frame.minX, y: frame.minY + speed, width: bounds.width, height: bounds.height)
            }
        }
        
        func reuse() {
            isClicked = false
            isSelected = false
        }
    }
}
