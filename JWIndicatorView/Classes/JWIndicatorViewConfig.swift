//
//  JWIndicatorViewConfig.swift
//  Pods
//
//  Created by sfh on 2025/4/10.
//

#if canImport(UIKit)

import NVActivityIndicatorView

/// JWIndicatorViewStyle
public enum JWIndicatorViewStyle: CaseIterable {
    case light
    case dark
    case custom
}

/// JWIndicatorPositionStyle
public enum JWIndicatorPositionStyle: CaseIterable {
    case top
    case center
    case bottom
}

/// JWIndicatorViewConfig
public class JWIndicatorViewConfig: NSObject {
    /// JWIndicatorViewStyle of JWIndicatorView, default = `dark`
    public var style: JWIndicatorViewStyle = .dark
    /// background color of JWIndicatorView, default = `clear`
    @IBInspectable public var maskColor: UIColor = UIColor(white: 0, alpha: 0.4)
    /// whether tap JWIndicatorView to dismiss or not, default = `false`
    @IBInspectable public var isTapDismiss: Bool = false
    
    /// UIIndicatorPositionStyle of content, default = `center`, only work in `offset = 0.0`
    public var position: JWIndicatorPositionStyle = .center
    /// offset of the content on the y-axis, with the screen centered by default, `> 0` near the top edge of the screen, and `< 0` near the bottom edge of the screen, default = `0.0`
    @IBInspectable var offset: CGFloat = 0.0
    /// max-width of content, default = `UIScreen.main.bounds.width - 40.0`
    @IBInspectable public var maxWith: CGFloat = UIScreen.main.bounds.width - 40.0
    /// padding of content, default = `10.0`
    @IBInspectable public var padding: CGFloat = 10.0
    /// background color of content, default = `#2D2D2D`, only work in `style = .custom`
    @IBInspectable public var indicatorBackColor: UIColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)
    /// cornerRadius of content, default = `10.0`
    @IBInspectable public var radius: CGFloat = 10.0
    
    /// width and height of indicator, default = `60.0`
    @IBInspectable public var indicatorWH: CGFloat = 60.0
    /// color of indicator, default = `#2D2D2D`, only work in `style = .custom`
    @IBInspectable public var indicatorColor: UIColor = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)
    /// type of indicator, default = `nil`
    public var type: NVActivityIndicatorType? = nil
    
    /// margin between indicator and text on the y-axis, default = `10.0`
    @IBInspectable public var margin: CGFloat = 10.0
    
    /// font of indicator text, default = `14.0, medium`
    @IBInspectable public var msgFont: UIFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    /// color of indicator text, default = `#2D2D2D`, only work in `style = .custom`
    @IBInspectable public var msgColor: UIColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)
    /// aligment of indicator text, default = `center`
    @IBInspectable public var msgAligment: NSTextAlignment = .center
    /// info of indicator text, default = `nil`
    @IBInspectable public var message: String? = nil
}


public extension JWIndicatorViewConfig {
    
    //TODO: JWIndicatorView
    
    /// type of JWIndicatorViewStyle
    func style(_ value: JWIndicatorViewStyle = .light) -> Self {
        self.style = value
        return self
    }
    
    /// background color of JWIndicatorView
    func maskColor(_ value: UIColor = UIColor(white: 0, alpha: 0.4)) -> Self {
        self.maskColor = value
        return self
    }
    
    /// whether tap JWIndicatorView to dismiss or not
    func tapDismiss(_ value: Bool = false) -> Self {
        self.isTapDismiss = value
        return self
    }
    
    //TODO: contentView
    
    /// type of UIIndicatorPositionStyle
    func position(_ value: JWIndicatorPositionStyle = .center) -> Self {
        self.position = value
        return self
    }
    
    /// offset of the content on the y-axis, with the screen centered by default, `> 0` near the top edge of the screen, and `< 0` near the bottom edge of the screen
    func offset(_ value: CGFloat = 0) -> Self {
        self.offset = value
        return self
    }
    
    /// max-width of content
    func maxWith(_ value: CGFloat = UIScreen.main.bounds.width - 20) -> Self {
        self.maxWith = value
        return self
    }
    
    /// padding of content
    func padding(_ value: CGFloat = 10.0) -> Self {
        self.padding = value
        return self
    }
    
    /// background color of content, only work in `style = .custom`
    func indicatorBackColor(_ value: UIColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)) -> Self {
        self.indicatorBackColor = value
        return self
    }
    
    /// cornerRadius of content
    func radius(_ value: CGFloat = 10.0) -> Self {
        self.radius = value
        return self
    }
    
    //TODO: indicator
    
    /// width and height of indicator
    func indicatorWH(_ value: CGFloat = 60.0) -> Self {
        self.indicatorWH = value
        return self
    }
    
    /// color of indicator, only work in `style = .custom`
    func indicatorColor(_ value: UIColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)) -> Self {
        self.indicatorColor = value
        return self
    }
    
    /// type of indicator
    func type(_ value: NVActivityIndicatorType? = nil) -> Self {
        self.type = value
        return self
    }
    
    //TODO: between indicator and text
    
    /// margin between indicator and text on the y-axis
    func margin(_ value: CGFloat = 10.0) -> Self {
        self.margin = value
        return self
    }
    
    //TODO: indicator text
    
    /// font of indicator text
    func msgFont(_ value: UIFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)) -> Self {
        self.msgFont = value
        return self
    }
    
    /// color of indicator text, only work in `style = .custom`
    func msgColor(_ value: UIColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)) -> Self {
        self.msgColor = value
        return self
    }
    
    /// alignment of indicator text, default = `center`
    func msgAligment(_ value: NSTextAlignment = .center) -> Self {
        self.msgAligment = value
        return self
    }
    
    /// info of indicator text
    func message(_ value: String? = nil) -> Self {
        self.message = value
        return self
    }
    
}

#endif
