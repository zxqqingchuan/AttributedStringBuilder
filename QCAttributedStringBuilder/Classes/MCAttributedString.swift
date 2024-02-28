//
//  MCAttributedString.swift
//  MCAttributedText
//
//  Created by qingchuan on 2024/2/26.
//

import Foundation

/**
 使用方式：
 label.attributedText = MCAttributedString("abc")
     .color(.blue)
     .font(.systemFont(ofSize: 10))
     .alignment(.left)
     .append(", efg")
     .appendArr(
         MCAttributedString(", emn")
             .color(.green)
             .build()
     )
     .firstSet(.red, of: "e")
     .firstReplace(
         "abc",
         with:
             MCAttributedString("cba")
             .color(.cyan)
             .font(.systemFont(ofSize: 20))
             .build()
     )
     .build()
 */
public struct MCAttributedString: MCAttributedStringBuilder {
    
    public var attr: NSMutableAttributedString
    
    public init(_ str: String = "") {
        if UIView.isRTL {
            attr = NSMutableAttributedString(string: "\u{200F}\(str)")
            for style in paragraphStyles() {
                style.alignment = .right
            }
        } else {
            attr = NSMutableAttributedString(string: "\u{200E}\(str)")
            for style in paragraphStyles() {
                style.alignment = .left
            }
        }
    }
    
}

extension MCAttributedString: MCAttributedStringAttributeMutation {
    
    public typealias Builder = Self
    
    public var builder: Builder {
        self
    }
    
}

/**
 YYText 有些富文本处理只能作用于 YYLabel，UILabel 无法识别，例如 yy_attachment。
 故：如果想用 appendRoundedLabel, appendSpace, appendContent，需使用 YYLabel，同时使用 MCYYAttributedString 类构建 attr。
 */
public struct MCYYAttributedString: MCAttributedStringBuilder {
    
    public var attr: NSMutableAttributedString
    
    public init(_ str: String = "") {
        if UIView.isRTL {
            attr = NSMutableAttributedString(string: "\u{200F}\(str)")
            for style in paragraphStyles() {
                style.alignment = .right
            }
        } else {
            attr = NSMutableAttributedString(string: "\u{200E}\(str)")
            for style in paragraphStyles() {
                style.alignment = .left
            }
        }
    }
    
}

extension MCYYAttributedString: MCAttributedStringAttributeMutation {
    
    public typealias Builder = Self
    
    public var builder: Builder {
        self
    }
    
}
