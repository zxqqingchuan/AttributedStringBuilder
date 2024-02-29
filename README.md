# QCAttributedStringBuilder

[![CI Status](https://img.shields.io/travis/zxqqingchuan/QCAttributedStringBuilder.svg?style=flat)](https://travis-ci.org/zxqqingchuan/QCAttributedStringBuilder)
[![Version](https://img.shields.io/cocoapods/v/QCAttributedStringBuilder.svg?style=flat)](https://cocoapods.org/pods/QCAttributedStringBuilder)
[![License](https://img.shields.io/cocoapods/l/QCAttributedStringBuilder.svg?style=flat)](https://cocoapods.org/pods/QCAttributedStringBuilder)
[![Platform](https://img.shields.io/cocoapods/p/QCAttributedStringBuilder.svg?style=flat)](https://cocoapods.org/pods/QCAttributedStringBuilder)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
label.attributedText = QCAttributedString("abc")
    .color(.blue)
    .font(.systemFont(ofSize: 10))
    .alignment(.left)
    .append(", efg")
    .appendAttr(
        QCAttributedString(", emn")
            .color(.green)
            .build()
    )
    .firstSet(.red, of: "e")
    .firstReplace(
        "abc",
        with:
            QCAttributedString("cba")
            .color(.cyan)
            .font(.systemFont(ofSize: 20))
            .build()
    )
    .appendImage...
    .appendSpace...
    .appendRoundedLabel...
    .build()
```

## Warning

if has libarclite_iphoneos.a or libarclite_iphonesimulatoros.a compile error, please make IPHONEOS_DEPLOYMENT_TARGET = '13.0'.
```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
```

Or add libarclite_iphonesimulatoros.a, libarclite_iphoneos.a into your /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib.

## Requirements

iOS >= 13.0

## Feature

* Builder 模式，支持链式调用。
* 支持文字排版 RTL 模式。
* 支持文字里嵌入 UIImageView, UIView, CALayer。
* Attachment 依赖 YYText 实现。

## Installation

QCAttributedStringBuilder is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QCAttributedStringBuilder'
```

## Author

zxqqingchuan, 147373551+zxqqingchuan@users.noreply.github.com

## License

QCAttributedStringBuilder is available under the MIT license. See the LICENSE file for more info.
