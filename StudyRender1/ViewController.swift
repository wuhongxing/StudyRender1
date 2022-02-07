//
//  ViewController.swift
//  StudyRender
//
//  Created by 吴红星 on 2022/2/1.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
        }
    }
    
    private let dataSource = ["-圆角", "-cell阴影圆角", "-异步绘制"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "离屏渲染"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(AnotherViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(ShadowCornerViewController(), animated: true)
        default: break
        }
    }
}
