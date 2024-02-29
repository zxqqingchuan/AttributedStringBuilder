//
//  QCAttributedStringBuilder.swift
//  MCAttributedText
//
//  Created by qingchuan on 2024/2/21.
//

import Foundation

public protocol QCAttributedStringBuilder {
    
    var attr: NSMutableAttributedString { get set }
    
    func build() -> NSAttributedString
    
    func buildMutable() -> NSMutableAttributedString
    
}

extension QCAttributedStringBuilder {
    
    public func build() -> NSAttributedString {
        return .init(attributedString: attr)
    }
    
    public func buildMutable() -> NSMutableAttributedString {
        return .init(attributedString: attr)
    }
    
    public static var defaultFont: UIFont {
        .systemFont(ofSize: 15, weight: .semibold)
    }

}

extension QCAttributedStringBuilder {
    
    func setAttributes(_ attrs: [NSAttributedStringKey: Any], range: NSRange) {
        for attr in  attrs {
            setAttribute(attr.key, value: attr.value, range: range)
        }
    }
    
    func setAttributes(_ attrs: [NSAttributedStringKey: Any]) {
        for attr in  attrs {
            setAttribute(attr.key, value: attr.value)
        }
    }
    
    func setAttribute(_ name: NSAttributedStringKey, value: Any?) {
        setAttribute(name, value: value, range: NSMakeRange(0, attr.length))
    }
    
    func setAttribute(_ name: NSAttributedStringKey, value: Any?, range: NSRange) {
        if let value = value {
            attr.addAttribute(name, value: value, range: range)
        } else {
            attr.removeAttribute(name, range: range)
        }
    }
    
}

extension QCAttributedStringBuilder {
    
    func paragraphStyles() -> [NSMutableParagraphStyle] {
        let range = NSMakeRange(0, attr.length)
        return paragraphStyles(range: range)
    }
    
    func paragraphStyles(range: NSRange) -> [NSMutableParagraphStyle] {
        var styles: [NSMutableParagraphStyle] = []
        attr.enumerateAttribute(.paragraphStyle, in: range) { value, subRange, _ in
            var new = false
            if let value = value as? NSMutableParagraphStyle {
                styles.append(value)
            } else if let value = value as? NSParagraphStyle,
                      let mutableValue = value.mutableCopy() as? NSMutableParagraphStyle {
                new = true
                styles.append(mutableValue)
            } else {
                new = true
                styles.append(NSMutableParagraphStyle())
            }
            if new, let lastStyle = styles.last {
                setAttribute(.paragraphStyle, value: lastStyle, range: subRange)
            }
        }
        return styles
    }
    
}
