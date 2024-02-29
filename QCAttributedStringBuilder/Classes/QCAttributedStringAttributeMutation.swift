//
//  QCAttributedStringAttributeMutation.swift
//  MCAttributedText
//
//  Created by qingchuan on 2024/2/22.
//

import Foundation
import YYText

public protocol QCAttributedStringAttributeMutation<Builder>: QCAttributedStringAttribute where Builder: QCAttributedStringAttributeMutation {
    
    func append(_ str: String?) -> Builder
    
    func appendArr(_ attr: NSAttributedString?) -> Builder
    
    func firstSet(_ color: UIColor?, of str: String) -> Builder
    
    func firstReplace(_ str: String, with attr: NSAttributedString) -> Builder
    
    func appendImage(_ image: UIImage?, size: CGSize, leavingType: LeavingType) -> Builder

}

extension QCAttributedStringAttributeMutation where Builder: QCAttributedStringBuilder {
    
    public func append(_ str: String?) -> Builder {
        guard let str = str else { return builder }
        let directionStr = "\u{2068}\(str)\u{2069}"
        let length = builder.attr.length
        builder.attr.replaceCharacters(in: NSMakeRange(length, 0), with: directionStr)
        return builder
    }
    
    public func appendArr(_ attr: NSAttributedString?) -> Builder {
        if let attr = attr {
            builder.attr.append(attr)
        }
        return builder
    }
    
    public func firstSet(_ color: UIColor?, of str: String) -> Builder {
        let range = (builder.attr.string as NSString).range(of: str)
        if range.location != NSNotFound {
            _ = self.color(color, range: range)
        }
        return builder
    }
    
    public func firstReplace(_ str: String, with attr: NSAttributedString) -> Builder {
        let range = (builder.attr.string as NSString).range(of: str)
        if range.location != NSNotFound {
            builder.attr.replaceCharacters(in: range, with: attr)
        }
        return builder
    }
    
    public func appendImage(_ image: UIImage?, size: CGSize, leavingType: LeavingType) -> Builder {
        guard let image = image else { return builder }
        let font = builder.attr.yy_font ?? Builder.defaultFont
        return appendArr(.attributed(image: image, size: size, font: font, leavingType: leavingType))
    }

}

extension QCAttributedStringAttributeMutation where Self == QCYYAttributedString {
    
    public func appendImage(_ image: UIImage?, leavingType: LeavingType) -> Builder {
        return appendContent(image, leavingType: leavingType)
    }

    public func appendRoundedLabel(
        _ text: NSMutableAttributedString,
        backgroundColor: UIColor,
        inset: UIEdgeInsets,
        leavingType: LeavingType
    ) -> Builder {
        let size = YYTextLayout(containerSize: CGSize.greatestFiniteMagnitude, text: text)?.size ?? .zero
        let (width, height) = (
            size.width + inset.left + inset.right,
            size.height + inset.top + inset.bottom
        )
        let label = UILabel(frame: .init(x: 0, y: 0, width: width, height: height))
        label.text = text.string
        label.textAlignment = .center
        label.font = text.yy_font
        label.textColor = text.yy_color
        label.backgroundColor = backgroundColor
        label.layer.cornerRadius = height / 2.0
        label.layer.masksToBounds = true
        
        let textAttachment = NSMutableAttributedString.yy_attributed(
            content: label,
            size: label.bounds.size,
            font: text.yy_font ?? .systemFont(ofSize: 15.0),
            leavingType: leavingType
        )
        builder.attr.append(textAttachment)
        
        return builder
    }
    
    public func appendSpace(_ space: CGFloat) -> Builder {
        let spaceSize = CGSize(width: space, height: 0)
        let spaceContent = NSMutableAttributedString.yy_attachmentString(
            withContent: nil,
            contentMode: .scaleAspectFill,
            attachmentSize: spaceSize,
            alignTo: builder.attr.yy_font ?? .systemFont(ofSize: 15),
            alignment: .center
        )
        builder.attr.append(spaceContent)
        return builder
    }
    
    public func appendContent<T: YYAttachment>(_ content: T?, leavingType: LeavingType) -> Builder {
        appendContent(
            content,
            size: content?.attachmentSize ?? .init(width: 1.0, height: 1.0),
            leavingType: leavingType
        )
    }
    
    public func appendContent<T: YYAttachment>(_ content: T?,
                                               size: CGSize,
                                               leavingType: LeavingType) -> Builder {
        guard let content = content else { return builder }
        let font = builder.attr.yy_font ?? Builder.defaultFont
        _ = appendArr(
            NSAttributedString.yy_attributed(
                content: content,
                size: size,
                font: font,
                leavingType: leavingType
            )
        )
        return builder
    }
    
}
