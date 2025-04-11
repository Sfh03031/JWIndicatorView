//
//  JWIndicatorView.swift
//  JWIndicatorView_Example
//
//  Created by sfh on 2024/3/12.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

#if canImport(UIKit)

import UIKit
import NVActivityIndicatorView

public class JWIndicatorView: UIView {
    
    private var config: JWIndicatorViewConfig = JWIndicatorViewConfig()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(hudView)
        hudView.contentView.addSubview(indicator)
        hudView.contentView.addSubview(infoLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject() as AnyObject
        var point = touch.location(in: self)
        point = self.hudView.layer.convert(point, from: self.layer)
        if self.hudView.layer.contains(point) {

        } else {
            if config.isTapDismiss {
                self.removeFromSuperview()
            }
        }
    }

    // MARK: lazyload
    
    private lazy var hudView: UIVisualEffectView = {
        let view = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: 80, height: 100))
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var indicator: NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: CGRect(x: 10, y: 10, width: 60, height: 60), type: .circleStrokeSpin, color: .black, padding: 0)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 80, width: 60, height: 20))
        label.text = "load..."
        label.textColor = .black.withAlphaComponent(0.6)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

}

//MARK: show or hide
public extension JWIndicatorView {
    
    /// show
    func show(in container: UIView, config: JWIndicatorViewConfig? = nil) {
        self.config = config ?? JWIndicatorViewConfig()
        self.backgroundColor = self.config.maskColor
        self.frame = container.bounds
        container.addSubview(self)
        
        if self.config.type == nil && self.config.message == nil {
            self.config.type = .circleStrokeSpin
        }
        
        var hudW: CGFloat = 0
        var hudH: CGFloat = 0
        var topH: CGFloat = 0
        var labW: CGFloat = 0
        var labH: CGFloat = 0
        if self.config.message != nil {
            let size = (self.config.message! as NSString).boundingRect(
                with: CGSize(width: self.config.maxWith - 2 * self.config.padding, height: CGFLOAT_MAX),
                options: [.usesFontLeading, .usesLineFragmentOrigin],
                attributes: [.font: self.config.msgFont, .foregroundColor: self.config.msgColor],
                context: nil).size
            labW = size.width > self.config.indicatorWH ? size.width : self.config.indicatorWH
            labH = size.height
            hudW = labW + 2 * self.config.padding
            topH = self.config.type != nil ? self.config.margin + self.config.indicatorWH : 0.0
            hudH = size.height + 2 * self.config.padding + topH
        } else {
            hudW = 2 * self.config.padding + self.config.indicatorWH
            topH = 0.0
            hudH = hudW
        }

        hudView.frame = CGRect(x: 0, y: 0, width: hudW, height: hudH)
        hudView.center.x = self.center.x
        if self.config.offset == 0 {
            switch self.config.position {
            case .top:
                if #available(iOS 11.0, *) {
                    hudView.center.y = self.safeAreaInsets.top + hudH / 2
                } else {
                    hudView.center.y = hudH / 2
                }
                break
            case .center:
                hudView.center.y = self.center.y
                break
            case .bottom:
                if #available(iOS 11.0, *) {
                    hudView.center.y = self.bounds.height - (self.safeAreaInsets.bottom + hudH / 2)
                } else {
                    hudView.center.y = self.bounds.height - hudH / 2
                }
                break
            }
        } else {
            hudView.center.y = self.center.y - self.config.offset
        }
        
        hudView.layer.cornerRadius = self.config.radius
        hudView.layer.masksToBounds = self.config.radius > 0.0
        if self.config.type != nil {
            indicator.frame = CGRect(x: (hudW - self.config.indicatorWH) / 2, y: self.config.padding, width: self.config.indicatorWH, height: self.config.indicatorWH)
        }
        infoLabel.frame = CGRect(x: self.config.padding, y: self.config.padding + topH, width: labW, height: labH)
        infoLabel.text = self.config.message
        infoLabel.font = self.config.msgFont
        infoLabel.textAlignment = self.config.msgAligment
        
        switch self.config.style {
        case .light:
            self.hudView.effect = UIBlurEffect(style: .light)
            self.hudView.backgroundColor = .clear
            self.indicator.color = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)
            self.infoLabel.textColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)
            break
        case .dark:
            self.hudView.effect = UIBlurEffect(style: .dark)
            self.hudView.backgroundColor = .clear
            self.indicator.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.infoLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            break
        case .custom:
            self.hudView.effect = nil
            self.hudView.backgroundColor = self.config.indicatorBackColor
            self.indicator.color = self.config.indicatorColor
            self.infoLabel.textColor = self.config.msgColor
            break
        }
        
        if self.config.type != nil {
            self.indicator.stopAnimating()
            self.indicator.type = self.config.type!
            self.indicator.startAnimating()
        }
    }
    
    /// hide
    func hide(in container: UIView, complete:(()->())? = nil) {
        if let exist = container.subviews.first(where: { $0 is JWIndicatorView }) {
            exist.removeFromSuperview()
        }
        complete?()
    }
}

public extension JWIndicatorView {
    
    /// Show `JWIndicatorView` in keyWindow
    /// - Parameters:
    ///   - type: type of indicator, default = `circleStrokeSpin`
    ///   - style: style of indicator, default = `dark`
    ///   - position: position of indicator, default = `center`
    ///   - message: info of indicator text, default = nil
    static func show(_ type: NVActivityIndicatorType? = nil, style: JWIndicatorViewStyle? = nil, position: JWIndicatorPositionStyle? = nil, message: String? = nil) {
        if let contain = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            if let exist = contain.subviews.first(where: { $0 is JWIndicatorView }) {
                exist.removeFromSuperview()
            }
            let config = JWIndicatorViewConfig()
            config.type = type
            config.style = style ?? .dark
            config.position = position ?? .center
            config.message = message
            JWIndicatorView().show(in: contain, config: config)
        }
    }
    
    /// Show custom `JWIndicatorView` in keyWindow
    /// - Parameters:
    ///   - config: `JWIndicatorViewConfig`, which is a properties collection
    ///   - delay: time if auto disapper after show, default = `0`
    ///   - complete: closure after `JWIndicatorView` disapper, default = nil
    static func show(config: JWIndicatorViewConfig, delay: TimeInterval = 0, complete:(()->())? = nil) {
        if let contain = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            if let exist = contain.subviews.first(where: { $0 is JWIndicatorView }) {
                exist.removeFromSuperview()
            }
            JWIndicatorView().show(in: contain, config: config)
            if delay > 0 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
                    JWIndicatorView().hide(in: contain, complete: complete)
                }
            }
        }
    }
    
    /// hide `JWIndicatorView` in keyWindow
    static func hide(complete: (()->())? = nil) {
        if let contain = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            JWIndicatorView().hide(in: contain, complete: complete)
        }
    }
}

#endif
