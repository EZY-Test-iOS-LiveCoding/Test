//
//  DynamicFontExt.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import UIKit
private let standard: CGFloat = 375
private let bound = UIScreen.main.bounds


// MARK: UILabel
extension UILabel {
    func dynamicFont(fontSize size: CGFloat, fontName: String = "AppleSDGothicNeo-Regular", textStyle: UIFont.TextStyle = .body){
        let resize = bound.width * (size/standard)
        let f = UIFont(name: fontName, size: resize)!
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: f)
    }
}
// MARK: UITextField
extension UITextField {
    func dynamicFont(fontSize size: CGFloat, fontName: String = "AppleSDGothicNeo-Regular", textStyle: UIFont.TextStyle = .body){
        let resize = bound.width * (size/standard)
        let f = UIFont(name: fontName, size: resize)!
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: f)
    }
}
// MARK: UITextView
extension UITextView {
    func dynamicFont(fontSize size: CGFloat, fontName: String = "AppleSDGothicNeo-Regular", textStyle: UIFont.TextStyle = .body){
        let resize = bound.width * (size/standard)
        let f = UIFont(name: fontName, size: resize)!
        self.adjustsFontForContentSizeCategory = true
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: f)
    }
    func autoSizing(_ width: CGFloat){
        let size = CGSize(width: width, height: .infinity)
        let estimatedSize = self.sizeThatFits(size)
        self.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
// MARK: UIButton
extension UIButton {
    func dynamicFont(fontSize size: CGFloat, fontName: String = "AppleSDGothicNeo-Regular", textStyle: UIFont.TextStyle = .body){
        let resize = bound.width * (size/standard)
        let f = UIFont(name: fontName, size: resize)!
        self.titleLabel?.adjustsFontForContentSizeCategory = true
        self.titleLabel?.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: f)
    }
}
