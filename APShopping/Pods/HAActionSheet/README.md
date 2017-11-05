### HAActionSheet

This tool is a dynamic action sheet for ios and written in Swift 3.0.

![App Video](https://github.com/hasanlsn/HAActionSheet/raw/master/appvideo.gif)

## Requirements

- iOS 8.0+
- Xcode 8.1, 8.2, 8.3, and 9.0
- Swift 3.0, 3.1, 3.2, and 4.0

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate HAActionSheet into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
  pod 'HAActionSheet'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

```swift
import UIKit
import HAActionSheet

class ViewController: UIViewController {
  let data = ["Apple",
              "Orange",
              "Banana",
              "Berry"]

  override func viewDidLoad() {
    super.viewDidLoad()

    let view = HAActionSheet(fromView: self.view, sourceData: data)
    view.buttonCornerRadius = 16
    view.show { (canceled, index) in
      if !canceled {
        print(self.data[index!])
      }
    }
  } 
}
```

## Options

```swift

/// title for cancel button, default is "Cancel"
public var cancelButtonTitle: String

/// corner radius for cancel button, first and last button, default is 16.0
public var buttonCornerRadius: CGFloat

/// font for header title, default is UIFont.boldSystemFont(ofSize: 17)
public var headerTitleFont: UIFont

/// font for header message, default is UIFont.systemFont(ofSize: 14)
public var headerMessageFont: UIFont

/// header background color, default is white
public var headerBackgroundColor: UIColor

/// header text color, default is black
public var headerTextColor: UIColor

/// font for button titles, default is system font
public var titleFont: UIFont

/// cancel button title color, default is red
public var cancelButtonTitleColor: UIColor

/// cancel button background color, default is white
public var cancelButtonBackgroundColor: UIColor

/// button title color, default is blue
public var buttonTitleColor: UIColor

/// button background color, default is white
public var buttonBackgroundColor:UIColor

/// button seperator color, default is #EDEDEF
public var seperatorColor: UIColor
```

## TODO

- Fully iPad support
- More animation
