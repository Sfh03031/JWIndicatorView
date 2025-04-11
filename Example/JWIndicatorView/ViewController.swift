//
//  ViewController.swift
//  JWIndicatorView
//
//  Created by Sfh03031 on 04/11/2025.
//  Copyright (c) 2025 Sfh03031. All rights reserved.
//

import UIKit
import JWIndicatorView
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    var i = 0
    var typeList = NVActivityIndicatorType.allCases.filter( { $0 != .blank } )
    var list = [
        ["only indicator", "custom indicator type", "custom indicator and message", "custom indicator and long message", "only message", "only long message"],
        ["only indicator", "custom indicator type", "custom indicator and message", "custom indicator and long message", "only message", "only long message"],
        ["position top", "position bottom", "custom position on the y-axis", "custom `indicatorBackColor` and `indicatorColor` and `msgColor` \n only can customize them in `custom` mode of JWIndicatorViewStyle", "custom all properties, auto disapper with delay and closure, enjoy it"],
    ]
    
    var shortText = "Loading, please wait..."
    var longText = "He was an old man who fished alone in a skiff in the Gulf Stream and he had gone eighty-four days now without taking a fish.\nAll happy families are alike; each unhappy family is unhappy in its own way.\nAll children, except one, grow up. That one remains a child. It is Peter Pan."
    var isDone: Bool = false
    var delay: TimeInterval = 2.5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        
        print("count of indicator type: \(typeList.count)")
    }
    
    func hide() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            JWIndicatorView.hide()
        }
    }
    
    func random() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }
    
    func randomOffset() -> CGFloat {
        isDone = !isDone
        let offset = CGFloat(arc4random_uniform(350))
        print("random offset: \(isDone ? offset : -offset)")
        return isDone ? offset : -offset
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRectZero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var value = ""
        switch section {
        case 0:
            value = "JWIndicatorViewStyle: Light"
        case 1:
            value = "JWIndicatorViewStyle: Dark"
        case 2:
            value = "JWIndicatorViewStyle: Custom"
        default:
            return nil
        }
        
        let header = UIView()
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: 300, height: 50))
        label.text = value
        label.textColor = random()
        label.textAlignment = .left
        header.addSubview(label)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 2 && indexPath.row == 3) ? 100 : 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "id")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "id")
        }

        cell?.textLabel?.text = list[indexPath.section][indexPath.row]
        cell?.textLabel?.textColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)
        cell?.textLabel?.numberOfLines = 0
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
        
        i += 1
        let type = typeList[i % typeList.count]
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                JWIndicatorView.show(style: .light)
            case 1:
                JWIndicatorView.show(type, style: .light)
            case 2:
                JWIndicatorView.show(type, style: .light, message: shortText)
            case 3:
                JWIndicatorView.show(type, style: .light, message: longText)
            case 4:
                JWIndicatorView.show(style: .light, message:shortText)
            case 5:
                JWIndicatorView.show(style: .light, message: longText)
            default:
                break
            }
            hide()
            break
        case 1:
            switch indexPath.row {
            case 0:
                JWIndicatorView.show()
            case 1:
                JWIndicatorView.show(type)
            case 2:
                JWIndicatorView.show(type, message: shortText)
            case 3:
                JWIndicatorView.show(type, message: longText)
            case 4:
                JWIndicatorView.show(message: shortText)
            case 5:
                JWIndicatorView.show(message: longText)
            default:
                break
            }
            hide()
        case 2:
            switch indexPath.row {
            case 0:
//                JWIndicatorView.show(type, position: .top, message: shortText)
//                hide()
                
                // or
                
                JWIndicatorView.show(config: JWIndicatorViewConfig().position(.top).type(type).message(shortText), delay: delay)
            case 1:
//                JWIndicatorView.show(type, position: .bottom, message: shortText)
//                hide()
                
                // or
                
                JWIndicatorView.show(config: JWIndicatorViewConfig().position(.bottom).type(type).message(shortText), delay: delay)
            case 2:
                JWIndicatorView.show(config: JWIndicatorViewConfig().offset(randomOffset()).type(type).message(longText), delay: delay)
            case 3:
                JWIndicatorView.show(config: JWIndicatorViewConfig()
                    .style(.custom)
                    .type(type)
                    .indicatorBackColor(random())
                    .indicatorColor(random())
                    .msgColor(random()), delay: delay)
            case 4:
                let config = JWIndicatorViewConfig()
                    .style(.custom)
                    .type(type)
                    .indicatorBackColor(random())
                    .indicatorColor(random())
                    .indicatorWH(100.0)
                    .msgColor(random())
                    .message(longText)
                    .msgFont(UIFont.systemFont(ofSize: 20.0, weight: .bold))
                    .msgAligment(.left)
                    .padding(20.0)
                    .margin(30.0)
                    .radius(15.0)
                    .tapDismiss(true)
                    .offset(randomOffset())
                
                JWIndicatorView.show(config: config, delay: delay) {
                    let alert = UIAlertController(title: "alert", message: "JWIndicatorView disappered after show 5 seconds", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .cancel))
                    self.present(alert, animated: true)
                }
            default:
                break
            }
            
        default:
            break
        }
    }
}

