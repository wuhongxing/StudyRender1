//
//  ShadowCornerViewController.swift
//  StudyRender1
//
//  Created by 吴红星 on 2022/2/7.
//

import UIKit

class ShadowCornerViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ShadowCornerCell.self, forCellReuseIdentifier: "test")
        tableView.register(FirstCell.self, forCellReuseIdentifier: "top")
        tableView.register(MiddleCell.self, forCellReuseIdentifier: "middle")
        tableView.register(LastCell.self, forCellReuseIdentifier: "bottom")
        
        tableView.backgroundColor = UIColor(red: 0xF5 / 0xFF, green: 0xF5 / 0xFF, blue: 0xF5 / 0xFF, alpha: 1)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        view.addSubview(tableView)
    }
}

extension ShadowCornerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
            return cell
        } else {
            if indexPath.row == 0 {
                return tableView.dequeueReusableCell(withIdentifier: "top", for: indexPath)
            }
            if indexPath.row == 9 {
                return tableView.dequeueReusableCell(withIdentifier: "bottom", for: indexPath)
            }
            return tableView.dequeueReusableCell(withIdentifier: "middle", for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

class ShadowCornerCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        let subView = UIView(frame: CGRect(x: 10, y: 10, width: bounds.width - 20, height: 60))
        subView.backgroundColor = .white
        subView.layer.cornerRadius = 10
        let path = UIBezierPath(roundedRect: subView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10))
        subView.layer.shadowColor = UIColor.gray.cgColor
        subView.layer.shadowOpacity = 1
        subView.layer.shadowOffset = CGSize(width: 0, height: 0)
        subView.layer.shadowRadius = 2
        subView.layer.shadowPath = path.cgPath
        contentView.addSubview(subView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 在这个里面可以处理主业务
// 对应不同形状的 cell 分发到不同的子类中去实现
// 这里其实还可以抽象一层，就是再搞一个协议 Conerable
// 把圆角这层抽象出来，因为这个东西是 view 共有的
// TODO: 暂时先不弄这个了，后面有时间把这个再弄出来
class BaseCell: UITableViewCell {
    lazy var subView = UIView(frame: CGRect(x: 10, y: 0, width: bounds.width - 20, height: 80))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        let view = UIView(frame: CGRect(x: 0, y: 20, width: subView.bounds.width, height: 20))
        view.backgroundColor = .orange
        subView.addSubview(view)
        subView.backgroundColor = .white
        contentView.addSubview(subView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FirstCell: BaseCell  {
    let shapeLayer = CAShapeLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let path = UIBezierPath(roundedRect: subView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
        
        shapeLayer.frame = subView.bounds
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        subView.backgroundColor = .clear
        subView.layer.addSublayer(shapeLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MiddleCell: BaseCell {
    
}

class LastCell: BaseCell {
    let shapeLayer = CAShapeLayer()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let path = UIBezierPath(roundedRect: subView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        shapeLayer.frame = subView.bounds
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        subView.backgroundColor = .clear
        shapeLayer.zPosition = -1
        subView.layer.addSublayer(shapeLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

