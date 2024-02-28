//
//  MCAttributedStringAttribute.swift
//  MCAttributedText
//
//  Created by qingchuan on 2024/2/22.
//

import Foundation

public protocol MCAttributedStringAttribute<Builder> where Builder: MCAttributedStringAttribute {
    
    associatedtype Builder
    
    var builder: Builder { get }
    
    func color(_ color: UIColor?) -> Builder
    
    func color(_ color: UIColor?, range: NSRange) -> Builder
    
    func font(_ font: UIFont?) -> Builder
    
    // 字符间距
    func kern(_ kern: CGFloat) -> Builder
    
    func backgroundColor(_ color: UIColor?) -> Builder
    
    // 文字描边
    func strokeColor(_ color: CGColor?) -> Builder
    
    func strokeWidth(_ width: CGFloat) -> Builder
    
    func shadow(_ shadow: NSShadow?) -> Builder
    
    func shadow(color: UIColor, offset: CGSize, blurRadius: CGFloat) -> Builder

    // 下划线
    func underlineStyle(_ style: NSUnderlineStyle) -> Builder
    
    func underlineColor(_ color: UIColor?) -> Builder
    
    // 字体倾斜度
    func obliqueness(_ obliqueness: CGFloat?) -> Builder
    
    // 基线偏移量
    func baselineOffset(_ offset: CGFloat?) -> Builder
    
    func paragraphStyle(_ style: NSParagraphStyle?) -> Builder

    func alignment(_ alignment: NSTextAlignment) -> Builder
    
    func lineBreakMode(_ mode: NSLineBreakMode) -> Builder
    
    func lineSpacing(_ space: CGFloat) -> Builder
    
    // 除首行外，距离段落起始位置
    func headIndent(_ indent: CGFloat) -> Builder
    
    // 首行缩进
    func firstLineHeadIndent(_ indent: CGFloat) -> Builder
    
    // 包含首行，距离段落结束位置，负数为向左缩进
    func tailIndent(_ indent: CGFloat) -> Builder
    
    func lineHeight(multiple: CGFloat, maximum: CGFloat, minimum: CGFloat) -> Builder
    
}

extension MCAttributedStringAttribute where Builder: MCAttributedStringBuilder {
    
    public func color(_ color: UIColor?) -> Builder {
        builder.setAttribute(.foregroundColor, value: color)
        return builder
    }
    
    public func color(_ color: UIColor?, range: NSRange) -> Builder {
        builder.setAttribute(.foregroundColor, value: color, range: range)
        return builder
    }
    
    public func font(_ font: UIFont?) -> Builder {
        builder.setAttribute(.font, value: font)
        return builder
    }
    
    public func kern(_ kern: CGFloat) -> Builder {
        builder.setAttribute(.kern, value: NSNumber(value: kern))
        return builder
    }
    
    public func backgroundColor(_ color: UIColor?) -> Builder {
        builder.setAttribute(.backgroundColor, value: color)
        return builder
    }
    
    public func strokeColor(_ color: CGColor?) -> Builder {
        builder.setAttribute(.strokeColor, value: color)
        return builder
    }
    
    public func strokeWidth(_ width: CGFloat) -> Builder {
        builder.setAttribute(.strokeWidth, value: NSNumber(value: width))
        return builder
    }
    
    public func shadow(_ shadow: NSShadow?) -> Builder {
        builder.setAttribute(.shadow, value: shadow)
        return builder
    }
    
    public func shadow(color: UIColor, offset: CGSize, blurRadius: CGFloat) -> Builder {
        let shadow = NSShadow()
        shadow.shadowColor = color
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = blurRadius
        builder.setAttribute(.shadow, value: shadow)
        return builder
    }

    public func underlineStyle(_ style: NSUnderlineStyle) -> Builder {
        builder.setAttribute(.underlineStyle, value: style.rawValue)
        return builder
    }
    
    public func underlineColor(_ color: UIColor?) -> Builder {
        builder.setAttribute(.underlineColor, value: color)
        return builder
    }
    
    public func obliqueness(_ obliqueness: CGFloat?) -> Builder {
        builder.setAttribute(.obliqueness, value: obliqueness as? NSNumber)
        return builder
    }
    
    public func baselineOffset(_ offset: CGFloat?) -> Builder {
        builder.setAttribute(.baselineOffset, value: offset as? NSNumber)
        return builder
    }
    
    public func paragraphStyle(_ style: NSParagraphStyle?) -> Builder {
        builder.setAttribute(.paragraphStyle, value: style)
        return builder
    }

    public func alignment(_ alignment: NSTextAlignment) -> Builder {
        for style in builder.paragraphStyles() {
            style.alignment = alignment
        }
        return builder
    }
    
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Builder {
        for style in builder.paragraphStyles() {
            style.lineBreakMode = mode
        }
        return builder
    }
    
    public func lineSpacing(_ space: CGFloat) -> Builder {
        for style in builder.paragraphStyles() {
            style.lineSpacing = space
        }
        return builder
    }
    
    public func headIndent(_ indent: CGFloat) -> Builder {
        for style in builder.paragraphStyles() {
            style.headIndent = indent
        }
        return builder
    }
    
    public func firstLineHeadIndent(_ indent: CGFloat) -> Builder {
        for style in builder.paragraphStyles() {
            style.firstLineHeadIndent = indent
        }
        return builder
    }
    
    public func tailIndent(_ indent: CGFloat) -> Builder {
        for style in builder.paragraphStyles() {
            style.tailIndent = indent
        }
        return builder
    }
    
    public func lineHeight(multiple: CGFloat, maximum: CGFloat, minimum: CGFloat) -> Builder {
        for style in builder.paragraphStyles() {
            style.lineHeightMultiple = multiple
            style.maximumLineHeight = maximum
            style.minimumLineHeight = minimum
        }
        return builder
    }
    
}
