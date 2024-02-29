//
//  MCAttributedText+Utils.swift
//  MCAttributedText
//
//  Created by qingchuan on 2023/12/13.
//

import Foundation
import YYText

extension UIView {
    
    static var isRTL: Bool {
        let attribute = UIView.appearance().semanticContentAttribute
        return UIView.userInterfaceLayoutDirection(for: attribute) == .rightToLeft
    }
    
}

public extension YYTextLayout {
    
    var size: CGSize {
        if UIView.isRTL {
            return .init(width: ceil(textBoundingRect.width), height: textBoundingSize.height)
        } else {
            return textBoundingSize
        }
    }
    
}

extension CGSize {
    
    static var greatestFiniteMagnitude: CGSize {
        .init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }
    
}

public enum LeavingType: Int, Comparable {
    
    public static func < (lhs: LeavingType, rhs: LeavingType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case none = 0, ahead, behind, both
    
}

public extension NSAttributedString {
    
    static func yy_attributed<T: YYAttachment>(
        content: T,
        size: CGSize,
        font: UIFont,
        leavingType: LeavingType
    ) -> NSMutableAttributedString {

        func createPadding() -> NSAttributedString {
            let leavingSize = CGSize(width: 5, height: 12)
            let leavingContent = NSMutableAttributedString.yy_attachmentString(
                withContent: nil,
                contentMode: .scaleAspectFill,
                attachmentSize: leavingSize,
                alignTo: font,
                alignment: .center
            )
            return leavingContent
        }

        let content = NSMutableAttributedString.yy_attachmentString(
            withContent: content,
            contentMode: .scaleAspectFill,
            attachmentSize: size,
            alignTo: font,
            alignment: .center
        )
        if leavingType > .none {
            if leavingType == .ahead || leavingType == .both {
                content.insert(createPadding(), at: 0)
            }
            if leavingType == .behind || leavingType == .both  {
                content.append(createPadding())
            }
        }
        return content
    }
    
    static func attributed(
        image: UIImage,
        size: CGSize,
        font: UIFont,
        leavingType: LeavingType
    ) -> NSMutableAttributedString {

        func createPadding() -> NSAttributedString {
            let padding = NSTextAttachment()
            // height 需设置为 0，不然 padding 会有白色块
            padding.bounds = CGRect(x: 0, y: 0, width: 5, height: 0)
            return NSAttributedString(attachment: padding)
        }

        let attachment = NSTextAttachment(image: image)
        let bounds: CGRect = CGRect(
            x: 0,
            y: (font.capHeight - size.height) / 2,
            width: size.width,
            height: size.height
        )
        attachment.bounds = bounds
        let attr = NSMutableAttributedString(attachment: attachment)

        if leavingType > .none {
            if leavingType == .ahead || leavingType == .both {
                attr.insert(createPadding(), at: 0)
            }
            if leavingType == .behind || leavingType == .both {
                attr.append(createPadding())
            }
        }

        return attr
    }

}

public extension NSMutableAttributedString {
    
    func addShadow(color: UIColor, offset: CGSize, blurRadius: CGFloat, range: NSRange? = nil) {
        let shadow = NSShadow()
        shadow.shadowColor = color
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = blurRadius
        if let range = range {
            self.yy_setShadow(shadow, range: range)
        } else {
            self.yy_shadow = shadow
        }
    }
    
    func addShadow(_ shadow: NSShadow, range: NSRange? = nil) {
        if let range = range {
            self.yy_setShadow(shadow, range: range)
        } else {
            self.yy_shadow = shadow
        }
    }
    
    func removeShadow(_ range: NSRange? = nil) {
        if let range = range {
            self.yy_setShadow(nil, range: range)
        } else {
            self.yy_shadow = nil
        }
    }
    
}

public protocol YYAttachment {
    var attachmentSize: CGSize { get }
}
extension UIImage: YYAttachment {
    public var attachmentSize: CGSize {
        self.size
    }
}
extension CALayer: YYAttachment {
    public var attachmentSize: CGSize {
        self.bounds.size
    }
}
extension UIView: YYAttachment {
    public var attachmentSize: CGSize {
        self.bounds.size
    }
}
