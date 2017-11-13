# RSUtils

A Swift RSUtils kit. Simple most of func for all project ... 
## Usage


Import RSUtils at the top of the Swift file with the content you would like.
```swift
import RSUtils
```

### Prerequisites

*The framework compiles on Swift 3.x or 4.x, but it can format programs written in Swift 2.x, 3.x or 4.x. Swift 2.x is no longer actively supported however, and newer rules may not work correctly with Swift 2.x. If you find that RSUtils breaks your 2.x codebase, the best solution is probably to revert to an earlier RSUtils release, or enable only a subset of rules.*

## Setting up with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with Homebrew using the following command:
```swift
$ brew update
$ brew install carthage
```

## Contributing
To integrate Format into your Xcode project using Carthage, specify it in your Cartfile:

```
github "mhtranbn/RSUtils"
```

## Setting up with CocoaPods
```swift
source 'https://github.com/CocoaPods/Specs.git'
pod 'RSUtils'
```

## Authors

* **mhtranbn** - *Initial work* - [mhtranbn](https://github.com/mhtranbn),[duongpq](https://www.facebook.com/soleilpqd)

See also the list of [contributors](https://github.com/mhtranbn/RSUtils/network/members).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## String+encode
```swift
base64Encoded() -> String
base64Decoded() -> String
```
## Time Date String+encode

### Initialization

```swift
Date(era: 235, year: 26, month: 8, day: 14, hour: 20, minute: 25, second: 43, nanosecond: 0, on: Calendar(identifier: .japanese))
Date(year: 2014, month: 8, day: 14, hour: 20, minute: 25, second: 43, nanosecond: 0)
Date(year: 2014, month: 8, day: 14, hour: 20, minute: 25, second: 43)
Date(year: 2014, month: 8, day: 14)

Date.today()
Date.yesterday()
Date.tomorrow()
```

### Calculation

```swift
now + 1.year
now - 2.months
now + (3.weeks - 4.days + 5.hours)

1.year.later
1.year.ago
```

### Change

```swift
now.changed(year: 2014)
now.changed(weekday: 1)
now.truncated([.minute, .second, .nanosecond])
now.truncated(from: .day)
```

### Formating

```swift
now.stringIn(dateStyle: .long, timeStyle: .medium)
now.dateString(in: .medium)
now.timeString(in: .short)

3.days.string(in: .full)
```

### Parsing

```swift
"2014/8/14".date(inFormat: "yyyy/MM/dd")
"2014-08-14T20:25:43+0900".dateInISO8601Format()

## Async

**Async** sugar looks like this:
```swift
Async.userInitiated {
	return 10
}.background {
	return "Score: \($0)"
}.main {
	label.text = $0
}
```

So even though GCD has nice-ish syntax as of Swift 3.0, compare the above with:
```swift
DispatchQueue.global(qos: .userInitiated).async {
	let value = 10
	DispatchQueue.global(qos: .background).async {
		let text = "Score: \(value)"
		DispatchQueue.main.async {
			label.text = text
		}
	}
}
```

**AsyncGroup** sugar looks like this:
```swift
let group = AsyncGroup()
group.background {
    print("This is run on the background queue")
}
group.background {
    print("This is also run on the background queue in parallel")
}
group.wait()
print("Both asynchronous blocks are complete")
```

### Things you can do
Supports the modern queue classes:
```swift
Async.main {}
Async.userInteractive {}
Async.userInitiated {}
Async.utility {}
Async.background {}
```

Chain as many blocks as you want:
```swift
Async.userInitiated {
	// 1
}.main {
	// 2
}.background {
	// 3
}.main {
	// 4
}
```

Store reference for later chaining:
```swift
let backgroundBlock = Async.background {
	print("This is run on the background queue")
}

// Run other code here...

// Chain to reference
backgroundBlock.main {
	print("This is run on the \(qos_class_self().description) (expected \(qos_class_main().description)), after the previous block")
}
```

Custom queues:
```swift
let customQueue = DispatchQueue(label: "CustomQueueLabel", attributes: [.concurrent])
let otherCustomQueue = DispatchQueue(label: "OtherCustomQueueLabel")
Async.custom(queue: customQueue) {
	print("Custom queue")
}.custom(queue: otherCustomQueue) {
	print("Other custom queue")
}
```

Dispatch block after delay:
```swift
let seconds = 0.5
Async.main(after: seconds) {
	print("Is called after 0.5 seconds")
}.background(after: 0.4) {
	print("At least 0.4 seconds after previous block, and 0.9 after Async code is called")
}
```

Cancel blocks that aren't already dispatched:
```swift
// Cancel blocks not yet dispatched
let block1 = Async.background {
	// Heavy work
	for i in 0...1000 {
		print("A \(i)")
	}
}
let block2 = block1.background {
	print("B – shouldn't be reached, since cancelled")
}
Async.main {
	// Cancel async to allow block1 to begin
	block1.cancel() // First block is _not_ cancelled
	block2.cancel() // Second block _is_ cancelled
}
```

Wait for block to finish – an ease way to continue on current queue after background task:
```swift
let block = Async.background {
	// Do stuff
}

// Do other stuff

block.wait()
```

### How does it work
The way it work is by using the new notification API for GCD introduced in OS X 10.10 and iOS 8. Each chaining block is called when the previous queue has finished.
```swift
let previousBlock = {}
let chainingBlock = {}
let dispatchQueueForChainingBlock = ...

// Use the GCD API to extend the blocks
let _previousBlock = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, previousBlock)
let _chainingBlock = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, chainingBlock)

// Use the GCD API to call back when finishing the "previous" block
dispatch_block_notify(_previousBlock, dispatchQueueForChainingBlock, _chainingBlock)
```

The syntax part of the chaining works by having class methods on the `Async` object e.g. `Async.main {}` which returns a struct. The struct has matching methods e.g. `theStruct.main {}`.

### Known bugs
Modern GCD queues don't work as expected in the iOS Simulator. See issues [13](https://github.com/duemunk/Async/issues/13), [22](https://github.com/duemunk/Async/issues/22).

### Known improvements
The ```dispatch_block_t``` can't be extended. Workaround used: Wrap ```dispatch_block_t``` in a struct that takes the block as a property.

### Apply
There is also a wrapper for [`dispatch_apply()`](https://developer.apple.com/library/mac/documentation/Performance/Reference/GCD_libdispatch_Ref/index.html#//apple_ref/c/func/dispatch_apply)  for quick parallelisation of a `for` loop.
```swift
Apply.background(100) { i in
	// Do stuff e.g. print(i)
}
```
Note that this function returns after the block has been run all 100 times i.e. it is not asynchronous. For asynchronous behaviour, wrap it in a an `Async` block like `Async.background { Apply.background(100) { ... } }`.

### AsyncGroup
**AsyncGroup** facilitates working with groups of asynchronous blocks.

Multiple dispatch blocks with GCD:
```swift
let group = AsyncGroup()
group.background {
    // Run on background queue
}
group.utility {
    // Run on utility queue, in parallel to the previous block
}
group.wait()
```
All modern queue classes:
```swift
group.main {}
group.userInteractive {}
group.userInitiated {}
group.utility {}
group.background {}
```
Custom queues:
```swift
let customQueue = dispatch_queue_create("Label", DISPATCH_QUEUE_CONCURRENT)
group.custom(queue: customQueue) {}
```
Wait for group to finish:
```swift
let group = AsyncGroup()
group.background {
    // Do stuff
}
group.background {
    // Do other stuff in parallel
}
// Wait for both to finish
group.wait()
// Do rest of stuff
```
Custom asynchronous operations:
```swift
let group = AsyncGroup()
group.enter()
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    // Do stuff
    group.leave()
}
group.enter()
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    // Do other stuff in parallel
    group.leave()
}
// Wait for both to finish
group.wait()
// Do rest of stuff
```
## Device

Here are some usage examples. All devices are also available as simulators:
```swift
.iPhone6 => .simulator(.iPhone6)
.iPhone6s => .simulator(.iPhone6s)
```

### Get the Device You're Running On
```swift
let device = Device()

print(device)     // prints, for example, "iPhone 6 Plus"

if device == .iPhone6Plus {
  // Do something
} else {
  // Do something else
}
```

### Get the Device Family
```swift
let device = Device()
if device.isPod {
  // iPods (real or simulator)
} else if device.isPhone {
  // iPhone (real or simulator)
} else if device.isPad {
  // iPad (real or simulator)
}
```

### Check If Running on Simulator
```swift
let device = Device()
if device.isSimulator {
  // Running on one of the simulators(iPod/iPhone/iPad) 
  // Skip doing something irrelevant for Simulator
} 
```

### Get the Simulator Device
```swift
let device = Device()
switch device {
case .simulator(.iPhone6s): break // You're running on the iPhone 6s simulator
case .simulator(.iPadAir2): break // You're running on the iPad Air 2 simulator
default: break
}
```
 
### Make Sure the Device Is Contained in a Preconfigured Group
```swift
let groupOfAllowedDevices: [Device] = [.iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .simulator(.iPhone6), .simulator(.iPhone6Plus), .simulator(.iPhone6s), .simulator(.iPhone6sPlus)]
let device = Device()
 
if device.isOneOf(groupOfAllowedDevices) {
  // Do you action
}
```

### Get the Current Battery State
```swift
if device.batteryState == .full || device.batteryState >= .charging(75) {
  print("Your battery is happy! 😊")
}
```

### Get the Current Battery Level
```swift
if device.batteryLevel >= 50 {
  install_iOS()
} else {
  showError()
}
```
# Use
All of the extensions are called off of the `dc` variable ***stands for ([UI]DeviceComplete)*** object that this 
library extends onto `UIDevice` that way native methods of `UIDevice` and methods of this library can
easily be seen, also lowering the possibility of naming conflicts.


### Getting common device name

```swift 
UIdevice.current.dc.commonDeviceName // iPad Pro (12.9 inch, Wi-Fi+LTE)
```

### Detecting iOS Device models

```Swift
let device = UIdevice.current.dc.deviceModel

switch device {
    case .iPhone6Plus, .iPhone7Plus:
        print("Lots of screen realestate eh?")
    case .iPhoneSE, .iPhone5, iPhone5S:
        print("Less iPhone is more iPhone...")
    case .iPadPro:
        print("Why?")
    default:
        print("Not sure what this is...")
}
```

### Detecting iOS Device Screen Size (Inches)

Screen size can be be queried with the following computed property returning a simple `Double`
that represents the screen size in inches:

```swift
let screenSize: Double = UIDevice.current.dc.screen.inches

if screenSize <= 4.0 {
    print("Modest screen size; not so modest price tag")
} else if screenSize >= 5.5 {
    print("Plus is always a plus")
} else {
    print("Chances are this is an iPad or an iPhone (Texas Edition).")
}
```

### Detecting iOS Device Family

If the type of device family is all you are after i.e iPhone or iPad and the specific model
is not important then `DeviceFamily` might be what you need.

```Swift
let deviceFamily = UIdevice.current.dc.deviceFamily

switch deviceFamily {
    case .iPhone:
        print("...phone home?")
    case .iPad:
        print("when it comes to screen size; more is more")
    case .iPod:
        print("Why not?")
    default:
        print("No family...")
}
```
## Swift Validators

Validation is done using the `apply` function of a `Validator`.
You can create a `Validator` manually or you can use on of the already available via static functions in the Validator class. 

A `Validator`'s apply function accepts an input as a nullable value that conforms to the `StringConvertible` protocol. By default `String`, `NSString`, `Int`, `Float`, `Double` and `Bool` conform to `StringConvertible`.

You can specify the `Validator`'s behaviour when it's input is nil if you are using the static Validator function by setting the `nilResponse` parameter to either true or false. By default nilResponse is set to false.

```swift
Validator.exactLength(3).apply("abc") //returns true

Validator.exactLength(3).apply(true) //returns false (the string representation of true is 'true')

Validator.exactLength(3).apply(nil) //returns false since `nilResponse` is set to false by default

Valuidator.exactLength(3, nilResponse: true).apply(nil) //returns true since we set nilResponse to true
```

For more examples on how to call each validator you can look at the [unit tests](https://github.com/gkaimakas/SwiftValidators/blob/master/SwiftValidatorsTests/ValidatorSpec.swift).

#### Logical Operators

You can combine operators using the logical `AND`, logical `OR` and Logical `NOT` operators ( &&,  || and ! respectively). 
```swift
let combinedANDValidator = Validator.required() && Validator.isTrue()
```
The `combinedANDValidator` will be `true` only when the value is not empty and `"true"`
```swift
let combinedORValidator = Validator.isTrue() || Validators.isFalse()
```
The `combinedORValidator` will be `true` if the value is `"true"` or `"false"`, otherwise it will be false.
```swift
let reversedValidator = !Validator.isTrue()
```
The `reversedValidator` will be `false` when the value equals `"true"` and `true` for all other values.


### Available Validators

Name|Description|Type|Arguments|Example
----|-----------|----|---------|-------
contains | checks if it is contained in the seed | func | String, Bool(nilReponse=false) | Validator.contains("some seed").apply("ee")
equals | checks if it equals another | func | String, Bool(nilReponse=false) | Validator.equals("aa").apply("aa") 
exactLength | checks if it has the exact length | func |  Int, Bool(nilReponse=false) | Validator.exactLength(2).apply("aa")
isASCII | checks if it is valid ascii string | func | Bool(nilReponse=false) | Validator.isASCII().apply("SDGSFG")
isAfter | checks if it is after the date | func | String, String, Bool(nilReponse=false) | Validator.isAfter("23/07/2015", format: "dd/MM/yyyy").apply("24/07/2015")
isAlpha|checks if it has only letters| func | Bool(nilReponse=false) |Validator.isAlpha().apply("abc")
isAlphanumeric|checks if it has letters and numbers only| func | Bool(nilReponse=false) |Validator.isAlphanumeric().apply("abc123")
isBase64 | checks if it a valid base64 string | func | Bool(nilReponse=false) | Validator.isBase64().apply("some string")
isBefore|checks if it is before the date | func |String, String, Bool(nilReponse=false)|Validator.isBefore("25/09/1987", format: "dd/MM/yyyy").apply("29/03/1994")
isBool|checks if it is boolean| func | Bool(nilReponse=false) |Validator.isBool().apply("true")
isCreditCard|checks if it is a credit card number| func | Bool(nilReponse=false) |Validator.isCreditCard().apply("123")
isDate|checks if it is a valid date|func|String, Bool(nilReponse=false)|Validator.isDate("dd/MM/yyyy").apply("25/09/1987")
isEmail|checks if it is an email|func|Bool(nilReponse=false)|Validator.isEmail().apply("gkaimakas@gmail.com")
isEmpty|checks if it is an empty string|func|Bool(nilReponse=false)|Validator.isEmpty().apply("")
isFQDN|checks if it is fully qualified domain name| func| FQDNOptions or empty, Bool(nilReponse=false)| Validator.isFQDN().apply("ABC")
isFalse|checks if it is false|func|Bool(nilReponse=false)|Validator.isFalse().apply("false")
isFloat|checks if it is a float number |func|Bool(nilReponse=false)|Validator.isFloat().apply("2.3e24")
isHexColor|checks if it is a valid hex color|func|Bool(nilReponse=false)|Validator.isHexColor().apply("#fafafa")
isHexadecimal|checks if it is a hexadecimal value|func|Bool(nilReponse=false)|Validator.isHexadecimal().apply("abcdef")
isIP|checks if it is a valid IP (4 \|6)|func|Bool(nilReponse=false)|Validator.isIP().apply("0.0.0.0")
isIPv4|checks if it is a valid IPv4 |func|Bool(nilReponse=false)|Validator.isIPv4().apply("0.0.0.0")
isIPv6|checks if it is a valid IPv6|func|Bool(nilReponse=false)|Validator.isIPv6().apply("::")
isISBN|checks if it is a valid ISBN|func|ISBN, Bool(nilReponse=false)|Validator.isISBN(.v13).apply("asdf")
isIn|checks if the value exists in the supplied array|func|Array<String>, Bool(nilReponse=false)|Validator.isIn(["a","b","c"]).apply("a")
isInt|checks if it is a valid integer|func|Bool(nilReponse=false)|Validator.isInt().apply("123")
isLowercase|checks if it only has lowercase characters|func|Bool(nilReponse=false)|Validator.isLowercase().apply("asdf")
isMongoId|checks if it a hexadecimal mongo id|func|Bool(nilReponse=false)|Validator.isMongoId()("adfsdffsg")
isNumeric|checks if it is numeric|func|Bool(nilReponse=false)|Validator.isNumeric().apply("+123")
isPhone|checks if it is a valid phone | func| Phone, Bool(nilReponse=false) | Validator.isPhone(.el_GR).apply("6944848966")
isPostalCode| checks it is a valid postal code | func | PostalCode, Bool(nilResponse=false) | Validator.isPostalCode(.GR).apply("30 006")
isTrue|checks if it is true|func|Bool(nilReponse=false)|Validator.isTrue().apply("true")
isUUID|checks if it is a valid UUID| func|Bool(nilReponse=false)|Validator.isUUID().apply("243-124245-2235-123")
isUppercase|checks if has only uppercase letter|func|Bool(nilReponse=false)|Validator.isUppercase().apply("ABC")
maxLength|checks if the length does not exceed the max length|func|Int, Bool(nilReponse=false)|Validator.maxLength(2).apply("ab")
minLength|checks if the length isn't lower than|func|Int, Bool(nilReponse=false)|Validator.minLength(1).apply("213")
required|checks if it is not an empty string|func|Bool(nilReponse=false)|Validator.required().apply("")
regex| checks that the value matches the regex from start to finish| func | String, Bool(nilReponse=false) | Validator.regex(pattern).apply("abcd")

*FQDNOptions is a class that is used on isFQDN for configuration purposes. It can be instantiated like this: 
```swift
FQDNOptions(requireTLD: Bool, allowUnderscores: Bool, allowTrailingDot: Bool)
```
## AttributedTextView

### General usage
In interfacebuilder put an UITextView on the canvas and set the base class to AttributedTextView and create a referencing outlet to the a property in  your viewController. In the samples below we have called this property textView1. Always assign to the attributer property when you want to set something.

### Paragraph styling
You do have to be aware that the paragraph functions will only be applied after calling the .paragraphApplyStyling function. On start the paragraph styling will use default styling. After each range change (what happens after .all, .match* or .append) the styling will be reset to the default.

### The active range
Styling will always be applied on the active range. When executing a function on a string, then that complete string will become the active range. If you use .append to add an other string, then that latest string will become the active range. When using the + sign then that will replaced by an append on 2 Attributer objects. All functions on those objects will first be performed before the append will be executed. So if you do an .all then still only one of the strings will be tha active range. You can use brackets to influence the order of execution.

For instance here all text will be size 20

```swift
("red".red + "blue".blue).all.size(20)
```

And here only the text blue will be size 20

```swift
"red".red + "blue".blue.all.size(20)
```

And like this all text will be size 20

```swift
"red".red.append("blue").blue.all.size(20)
```

### Sample code

Here is a sample of some basic functions:

```swift
textView1.attributer =
    "1. ".red
    .append("This is the first test. ").green
    .append("Click on ").black
    .append("evict.nl").makeInteract { _ in
        UIApplication.shared.open(URL(string: "http://evict.nl")!, options: [:], completionHandler: { completed in })
    }.underline
    .append(" for testing links. ").black
    .append("Next test").underline.makeInteract { _ in
        print("NEXT")
    }
    .all.font(UIFont(name: "SourceSansPro-Regular", size: 16))
    .setLinkColor(UIColor.purple) 
```

![animated](https://github.com/evermeer/AttributedTextView/blob/master/Screenshots/Sample1.png?raw=true)

Some more attributes and now using + instead of .append:

```swift
textView1.attributer =
    "2. red, ".red.underline.underline(0x00ff00)
    + "green, ".green.fontName("Helvetica").size(30)
    + "cyan, ".cyan.size(22)
    + "orange, ".orange.kern(10)
    + "blue, ".blue.strikethrough(3).baselineOffset(8)
    + "black.".shadow(color: UIColor.gray, offset: CGSize(width: 2, height: 3), blurRadius: 3.0)
```

![animated](https://github.com/evermeer/AttributedTextView/blob/master/Screenshots/Sample2.png?raw=true)

A match and matchAll sample:

```swift
textView1.attributer = "It is this or it is that where the word is is selected".size(20)
    .match("is").underline.underline(UIColor.red)
    .matchAll("is").strikethrough(4)
```

![animated](https://github.com/evermeer/AttributedTextView/blob/master/Screenshots/Sample3.png?raw=true)

A hashtags and mentions sample:

```swift
textView1.attributer = "@test: What #hashtags do we have in @evermeer #AtributedTextView library"
    .matchHashtags.underline
    .matchMentions
    .makeInteract { link in
        UIApplication.shared.open(URL(string: "https://twitter.com\(link.replacingOccurrences(of: "@", with: ""))")!, options: [:], completionHandler: { completed in })
    }
```

![animated](https://github.com/evermeer/AttributedTextView/blob/master/Screenshots/Sample4.png?raw=true)


Some other text formating samples:

```swift
textView1.attributer =  (
    "test stroke".strokeWidth(2).strokeColor(UIColor.red)
    + "test stroke 2\n".strokeWidth(2).strokeColor(UIColor.blue)
    + "test strikethrough".strikethrough(2).strikethroughColor(UIColor.red)
    + " test strikethrough 2\n".strikethrough(2).strikethroughColor(UIColor.yellow)
    + "letterpress ".letterpress
    + " obliquenes\n".obliqueness(0.4).backgroundColor(UIColor.cyan)
    + "expansion\n".expansion(0.8)
    ).all.size(24)
```

![animated](https://github.com/evermeer/AttributedTextView/blob/master/Screenshots/Sample5.png?raw=true)


Paragraph formatting:

```swift
textView1.attributer = (
    "The quick brown fox jumps over the lazy dog.\nPack my box with five dozen liquor jugs.\nSeveral fabulous dixieland jazz groups played with quick tempo."
    .paragraphLineHeightMultiple(5)
    .paragraphLineSpacing(6)
    .paragraphMinimumLineHeight(15)
    .paragraphMaximumLineHeight(50)
    .paragraphLineSpacing(10)
    .paragraphLineBreakModeWordWrapping
    .paragraphFirstLineHeadIndent(20)
    .paragraphApplyStyling
    ).all.size(12)
```




### Use the attributedText functionality on a UILabel
You can also use the Attributer for your UILabel. You only can't use the makeInteract function:

```swift
let myUILabel = UILabel()
myUILabel.attributedText = ("Just ".red + "some ".green + "text.".orange).attributedText
```


### Extending AttributedTextView
In the demo app you can see how you can extend the AttributedTextView with a custom property / function that will perform multiple actions. Here is a simple sample that will show you how you can create a myTitle property that will set multiple attributes:

```swift
extension Attributer {
    open var myTitle: Attributer {
        get {
            return self.fontName("Arial").size(28).color(0xffaa66).kern(5)
        }
    }
}

public extension String {
    var myTitle: Attributer {
        get {
            return attributer.myTitle
        }
    }
}
```

### Decorating the Attributed object
In the demo app there is also a sample that shows you how you could decorate an Attributed object with default styling.

```swift
        attributedTextView.attributer = decorate(4) { content in return content
            + "This is our custom title".myTitle
        }
```

The decorate function can then look something like this:

```swift
    func decorate(_ id: Int, _ builder: ((_ content: Attributer) -> Attributer)) -> Attributer {
        var b = "Sample \(id + 1):\n\n".red
        b = builder(b) // Now add the content
        return b
    }
```

### Creating your own custom label
There is also an AttributedLabel class which derives from UILabel which makes it easy to create your own custom control that includes support for interfacebuilder. If you put a lable on a form in interfacebuilder and set it's class to your subclass (AttributedLabelSubclassDemo in the sample below) Then you will see the text formated in interface building according to what you have implemented in the configureAttributedLabel function. Here is a sample where a highlightText property is added so that a text can be constructed where that part is highlighted. 

```swift
import AttributedTextView
import UIKit

@IBDesignable open class AttributedLabelSubclassDemo: AttributedLabel {

    // Add this field in interfacebuilder and make sure the interface is updated after changes
    @IBInspectable var highlightText: String? {
        didSet { configureAttributedLabel() }
    }

    // Configure our custom styling.
    override open func configureAttributedLabel() {
        self.numberOfLines = 0
        if let highlightText = self.highlightText {
            self.attributedText = self.text?.green.match(highlightText).red.attributedText
        } else {
            self.attributedText = self.text?.green.attributedText
        }
        layoutIfNeeded()
    }
}
```

In the demo app there is also a lable subclass for an icon list like this:
![animated](https://github.com/evermeer/AttributedTextView/blob/master/Screenshots/IconList.png?raw=true)

You can find the code here:
[Icon bulet list code](https://github.com/evermeer/AttributedTextView/blob/master/Demo/AttributedLabelSubclassDemo.swift#L52)


### Creating your own custom textview
You could do the same as a label with the AttributedTextView (see previous paragraph). In the sample below 2 properties are entered into interfacebuilder the linkText is the part of the text what will be clickable and linkUrl will be the webpage that will be opened.

```swift
import AttributedTextView
import UIKit

@IBDesignable class AttributedTextViewSubclassDemo: AttributedTextView {

    // Add this field in interfacebuilder and make sure the interface is updated after changes
    @IBInspectable var linkText: String? {
        didSet { configureAttributedTextView() }
    }

    // Add this field in interfacebuilder and make sure the interface is updated after changes
    @IBInspectable var linkUrl: String? {
        didSet { configureAttributedTextView() }
    }

    // Configure our custom styling.
    override func configureAttributedTextView() {
        if let text = self.text, let linkText = self.linkText, let linkUrl = self.linkUrl {
            self.attributer = text.green.match(linkText).makeInteract { _ in
                UIApplication.shared.open(URL(string: linkUrl)!, options: [:], completionHandler: { completed in })
            }
        } else {
            self.attributer = (self.text ?? "").green
        }
        layoutIfNeeded()
    }
}
```

## StatefulViewController

> This guide describes the use of the `StatefulViewController` protocol on `UIViewController`. However, you can also adopt the `StatefulViewController` protocol on any `UIViewController` subclass, such as `UITableViewController` or `UICollectionViewController`, as well as your custom `UIView` subclasses.

First, make sure your view controller adopts to the `StatefulViewController` protocol.

```swift
class MyViewController: UIViewController, StatefulViewController {
    // ...
}
```

Then, configure the `loadingView`, `emptyView` and `errorView` properties (provided by the `StatefulViewController` protocol) in `viewDidLoad`.

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    // Setup placeholder views
    loadingView = // UIView
    emptyView = // UIView
    errorView = // UIView
}
```

In addition, call the `setupInitialViewState()` method in `viewWillAppear:` in order to setup the initial state of the controller.

```swift
override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    setupInitialViewState()
}
```

After that, simply tell the view controller whenever content is loading and `StatefulViewController` will take care of showing and hiding the correct loading, error and empty view for you.

```swift
override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    loadDeliciousWines()
}

func loadDeliciousWines() {
    startLoading()

    let url = NSURL(string: "http://example.com/api")
    let session = NSURLSession.sharedSession()
    session.dataTaskWithURL(url) { (let data, let response, let error) in
        endLoading(error: error)
    }.resume()
}
```

### Life cycle

StatefulViewController calls the `hasContent` method to check if there is any content to display. If you do not override this method in your own class, `StatefulViewController` will always assume that there is content to display.

```swift
func hasContent() -> Bool {
    return datasourceArray.count > 0
}
```

Optionally, you might also be interested to respond to an error even if content is already shown. `StatefulViewController` will not show its `errorView` in this case, because there is already content that can be shown.

To e.g. show a custom alert or other unobtrusive error message, use `handleErrorWhenContentAvailable:` to manually present the error to the user.

```swift
func handleErrorWhenContentAvailable(error: ErrorType) {
    let alertController = UIAlertController(title: "Ooops", message: "Something went wrong.", preferredStyle: .Alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    presentViewController(alertController, animated: true, completion: nil)
}
```



### Custom Placeholder View insets

Per default, StatefulViewController presents all configured placeholder views fullscreen (i.e. with 0 insets from top, bottom, left & right from the superview). In case a placeholder view should have custom insets the configured placeholderview may conform to the `StatefulPlaceholderView` protocol and override the `placeholderViewInsets` method to return custom edge insets.

```swift
class MyPlaceholderView: UIView, StatefulPlaceholderView {
    func placeholderViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
```



<a name="viewstatemachine"></a>

### View State Machine

> Note: The following section is only intended for those, who want to create a stateful controller that differs from the flow described above.

You can also use the underlying view state machine to create a similar implementation for your custom flow of showing/hiding views.

```swift
let stateMachine = ViewStateMachine(view: view)

// Add states
stateMachine["loading"] = loadingView
stateMachine["other"] = otherView

// Transition to state
stateMachine.transitionToState(.View("loading"), animated: true) {
    println("finished switching to loading view")
}

// Hide all views
stateMachine.transitionToState(.None, animated: true) {
    println("all views hidden now")
}

## File

### Paths

Paths are handled with the `Path` structure.

```swift
let home = Path("~")
let drive: Path = "/Volumes/Macintosh HD"
let file:  Path = "~/Desktop/file\(1)"
```

#### Operations

##### New Files

A blank file can be written by calling `createFile()` on an `Path`.

```swift
try Path(".gitignore").createFile()
```

##### New Directories

A directory can be created by calling `createDirectory()` on an `Path`.

```swift
try Path("~/Files").createDirectory()
try Path("~/Books").createDirectory(withIntermediateDirectories: false)
```

Intermediate directories are created by default.

##### New Symlinks

A symbolic link can be created by calling `createSymlinkToPath(_:)` on an `Path`.

```swift
try Path("path/to/MyApp.app").symlinkFile(to: "~/Applications")
print(Path("~/Applications/MyApp.app").exists)  // true
```

##### Finding Paths

You can find all paths with the ".txt" extension five folders deep into the
Desktop with:

```swift
let textFiles = Path.userDesktop.find(searchDepth: 5) { path in
    path.pathExtension == "txt"
}
```

A negative `searchDepth` will make it run until every path in `self` is checked
against.

You can even map a function to paths found and get the non-nil results:

```swift
let documents = Path.userDocuments.find(searchDepth: 1) { path in
    String(path)
}
```

##### Iterating Through Paths

Because `Path` conforms to `SequenceType`, it can be iterated through with a
`for` loop.

```swift
for download in Path.userDownloads {
    print("Downloaded file: \(download)")
}
```

##### Current Working Directory

The current working directory for the process can be changed with `Path.Current`.

To quickly change the current working directory to a path and back, there's the
`changeDirectory(_:)` method:

```swift
Path.userDesktop.changeDirectory {
    print(Path.current)  // "/Users/nvzqz/Desktop"
}
```

##### Common Ancestor

A common ancestor between two paths can be obtained:

```swift
print(Path.root.commonAncestor(.userHome))       // "/"
print("~/Desktop"  <^> "~/Downloads")            // "~"
print(.UserLibrary <^> .UserApplicationSupport)  // "/Users/nvzqz/Library"
```

##### `+` Operator

Appends two paths and returns the result

```swift
// ~/Documents/My Essay.docx
let essay = Path.userDocuments + "My Essay.docx"
```

It can also be used to concatenate a string and a path, making the string value
a `Path` beforehand.

```swift
let numberedFile: Path = "path/to/dir" + String(10)  // "path/to/dir/10"
```

##### `+=` Operator

Appends the right path to the left path. Also works with a `String`.

```swift
var photos = Path.userPictures + "My Photos"  // ~/Pictures/My Photos
photos += "../My Other Photos"                // ~/Pictures/My Photos/../My Other Photos
```

##### `%` Operator

Returns the standardized version of the path.

```swift
let path: Path = "~/Desktop"
path% == path.standardized  // true
```

##### `*` Operator

Returns the resolved version of the path.

```swift
let path: Path = "~/Documents"
path* == path.resolved  // true
```

##### `^` Operator

Returns the path's parent path.

```swift
let path: Path = "~/Movies"
path^ == "~"  // true
```

##### `->>` Operator

Moves the file at the left path to the right path.

`Path` counterpart: **`moveFile(to:)`**

`File` counterpart: **`move(to:)`**

##### `->!` Operator

Forcibly moves the file at the left path to the right path by deleting anything
at the left path before moving the file.

##### `+>>` Operator

Copies the file at the left path to the right path.

`Path` counterpart: **`copyFile(to:)`**

`File` counterpart: **`copy(to:)`**

##### `+>!` Operator

Forcibly copies the file at the left path to the right path by deleting anything
at the left path before copying the file.

##### `=>>` Operator

Creates a symlink of the left path at the right path.

`Path` counterpart: **`symlinkFile(to:)`**

`File` counterpart: **`symlink(to:)`**

##### `=>!` Operator

Forcibly creates a symlink of the left path at the right path by deleting
anything at the left path before creating the symlink.

##### Subscripting

Subscripting an `Path` will return all of its components up to and including
the index.

```swift
let users = Path("/Users/me/Desktop")[1]  // /Users
```

##### `standardize()`

Standardizes the path.

The same as doing:
```swift
somePath = somePath.standardized
```

##### `resolve()`

Resolves the path's symlinks.

The same as doing:
```swift
somePath = somePath.resolved
```

### Files

A file can be made using `File` with a `DataType` for its data type.

```swift
let plistFile = File<Dictionary>(path: Path.userDesktop + "sample.plist")
```

Files can be compared by size.

#### Operators

##### `|>` Operator

Writes the data on the left to the file on the right.

```swift
do {
    try "My name is Bob." |> TextFile(path: Path.userDesktop + "name.txt")
} catch {
    print("I can't write to a desktop file?!")
}
```

#### TextFile

The `TextFile` class allows for reading and writing strings to a file.

Although it is a subclass of `File<String>`, `TextFile` offers some functionality
that `File<String>` doesn't.

##### `|>>` Operator

Appends the string on the left to the `TextFile` on the right.

```swift
let readme = TextFile(path: "README.txt")
try "My Awesome Project" |> readme
try "This is an awesome project." |>> readme
```

#### NSDictionaryFile

A typealias to `File<NSDictionary>`.

#### NSArrayFile

A typealias to `File<NSArray>`

#### NSDataFile

A typealias to `File<NSData>`

#### DataFile

The `DataFile` class allows for reading and writing `Data` to a file.

Although it is a subclass of `File<Data>`, `DataFile` offers some functionality
that `File<Data>` doesn't. You could specify `Data.ReadingOptions` and `Data.WritingOptions`

### File Permissions

The `FilePermissions` struct allows for seeing the permissions of the current
process for a given file.

```swift
let swift: Path = "/usr/bin/swift"
print(swift.filePermissions)  // FilePermissions[read, execute]
```

### Data Types

All types that conform to `DataType` can be used to satisfy the generic type for
`File`.

#### Readable Protocol

A `Readable` type must implement the static method `read(from: Path)`.

All `Readable` types can be initialized with `init(contentsOfPath:)`.

#### Writable Protocol

A `Writable` type must implement `write(to: Path, atomically: Bool)`.

Writing done by `write(to: Path)` is done atomically by default.

##### WritableToFile

Types that have a `write(toFile:atomically:)` method that takes in a `String`
for the file path can conform to `Writable` by simply conforming to
`WritableToFile`.

##### WritableConvertible

If a type itself cannot be written to a file but can output a writable type,
then it can conform to `WritableConvertible` and become a `Writable` that way.

### FileKitError

The type for all errors thrown by FileKit operations is `FileKitError`.

Errors can be converted to `String` directly for any logging. If only the error
message is needed, `FileKitError` has a `message` property that states why the
error occurred.

```swift
// FileKitError(Could not copy file from "path/to/file" to "path/to/destination")
String(FileKitError.copyFileFail(from: "path/to/file", to: "path/to/destination"))
```

## CryptoSwift

#### Hash (Digest)
- [MD5](http://tools.ietf.org/html/rfc1321)
- [SHA1](http://tools.ietf.org/html/rfc3174)
- [SHA224](http://tools.ietf.org/html/rfc6234)
- [SHA256](http://tools.ietf.org/html/rfc6234)
- [SHA384](http://tools.ietf.org/html/rfc6234)
- [SHA512](http://tools.ietf.org/html/rfc6234)
- [SHA3](http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf)

#### Cyclic Redundancy Check (CRC)
- [CRC32](http://en.wikipedia.org/wiki/Cyclic_redundancy_check)
- [CRC16](http://en.wikipedia.org/wiki/Cyclic_redundancy_check)

#### Cipher
- [AES-128, AES-192, AES-256](http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf)
- [ChaCha20](http://cr.yp.to/chacha/chacha-20080128.pdf)
- [Rabbit](https://tools.ietf.org/html/rfc4503)
- [Blowfish](https://www.schneier.com/academic/blowfish/)

#### Message authenticators
- [Poly1305](http://cr.yp.to/mac/poly1305-20050329.pdf)
- [HMAC](https://www.ietf.org/rfc/rfc2104.txt) MD5, SHA1, SHA256

#### Cipher block mode
- Electronic codebook ([ECB](http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Electronic_codebook_.28ECB.29))
- Cipher-block chaining ([CBC](http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cipher-block_chaining_.28CBC.29))
- Propagating Cipher Block Chaining ([PCBC](http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Propagating_Cipher_Block_Chaining_.28PCBC.29))
- Cipher feedback ([CFB](http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cipher_feedback_.28CFB.29))
- Output Feedback ([OFB](http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Output_Feedback_.28OFB.29))
- Counter ([CTR](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Counter_.28CTR.29))

#### Password-Based Key Derivation Function
- [PBKDF1](http://tools.ietf.org/html/rfc2898#section-5.1) (Password-Based Key Derivation Function 1)
- [PBKDF2](http://tools.ietf.org/html/rfc2898#section-5.2) (Password-Based Key Derivation Function 2)

#### Data padding
- PKCS#5
- [PKCS#7](http://tools.ietf.org/html/rfc5652#section-6.3)
- [Zero padding](https://en.wikipedia.org/wiki/Padding_(cryptography)#Zero_padding)
- No padding


## Timer

You can easily schedule repeating and non-repeating timers (repeats and delays) using `Timer.every` and `Timer.after`:

```swift
Timer.every(0.7.seconds) {
    statusItem.blink()
}

Timer.after(1.minute) {
    println("Are you still here?")
}
```

You can specify time intervals with these intuitive helpers:

```swift
100.ms
1.second
2.5.seconds
5.seconds
10.minutes
1.hour
2.days
```

You can pass method references instead of closures:

```swift
Timer.every(30.seconds, align)
```

### Manual scheduling

If you want to make a timer object without scheduling, use `new(after:)` and `new(every:)`:

```swift
let timer = Timer.new(every: 1.second) {
    println(self.status)
}
```

(This should be defined as an initializer, but [a bug in Foundation](http://www.openradar.me/18720947) prevents this)

Call `start()` to schedule timers created using `new`. You can optionally pass the run loop and run loop modes:

```swift
timer.start()
timer.start(modes: .defaultRunLoopMode, .eventTrackingRunLoopMode)
```

### Invalidation

If you want to invalidate a repeating timer on some condition, you can take a `Timer` argument in the closure you pass in:

```swift
Timer.every(5.seconds) { (timer: Timer) in
    // do something
    
    if finished {
        timer.invalidate()
    }
}
```

## Format

## Number Formatting

Format provides a formatting extension for all number types. To format an Int to two decimal places:
```swift
let formattedNumber = 45.format(Decimals.two) // 45.00
```

Format defaults to the user's current locale but a custom locale can be easily provided:
```swift
let frLocale = Locale(identifier: "FR")
let gbLocale = Locale(identifier: "GB")
let formattedFRNumber = 99.format(Currency.EUR, locale: frLocale) // 99,00 €
let formattedGBNumber = 99.format(Currency.GBP, locale: gbLocale) // £ 99.00
```

Apply any of these formatters to any number type:
```swift
Decimals.three // 10.123
Currency.USD // $10.12
General.ordinal // 10th (iOS9+ only)
General.spellOut // ten point one two three
General.distance // 30 feet
Mass.person // 67 kg
```

The distance formatter assumes the number represents the distance in meters before converting and formatting it to the current locale's preferred unit.

## Address Formatting (iOS9.0+ only)

Different cultures have [different ways of displaying addresses](https://en.wikipedia.org/wiki/Address_(geography)#Address_format). Format includes an extension on CLPlacemark that converts the addressDictionary to a formatted string in the current locale:

```swift
let address = placemark.format()
```
Please note that this function will produce a deprecated warning when used. This is because Apple is using AddressBook keys in the CLPlacemark and AddressBook was deprecated.

To format a custom address (all fields are optional strings):

```swift
let address = AddressFormatter().format(street, city: city, state: state, postalCode: postalCode, country: country, ISOCountryCode: ISOCountryCode)
```

## Color Formatting

Format can help you convert hexadecimal colors from the web to UIColors you can work with:

```swift
let color = ColorFormatter().format("2ba134")
```

In case of an error, the color will default to black if the string is empty or white if the string is invalid.

## Localize-Swift

Add `.localized()` following any `String` object you want translated:
```swift
textLabel.text = "Hello World".localized()
```

To get an array of available localizations:
```swift
Localize.availableLanguages()
```

To change the current language:
```swift
Localize.setCurrentLanguage("fr")
```

To update the UI in the view controller where a language change can take place, observe LCLLanguageChangeNotification:
```swift
NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
```

To reset back to the default app language:
```swift
Localize.resetCurrentLanguageToDefault()
```

## genstrings

To support this new i18n syntax, Localize-Swift includes custom genstrings swift script.

Copy the genstrings.swift file into your project's root folder and run with

```bash
./genstrings.swift
```

This will print the collected strings in the terminal. Select and copy to your default Localizable.strings.

The script includes the ability to specify excluded directories and files (by editing the script).


## SwiftyJSON

```swift
let json = JSON(data: dataFromNetworking)
```
Or

```swift
let json = JSON(jsonObject)
```
Or

```swift
if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
    let json = JSON(data: dataFromString)
}
```

#### Subscript

```swift
// Getting a double from a JSON Array
let name = json[0].double
```

```swift
// Getting an array of string from a JSON Array
let arrayNames =  json["users"].arrayValue.map({$0["name"].stringValue})
```

```swift
// Getting a string from a JSON Dictionary
let name = json["name"].stringValue
```

```swift
// Getting a string using a path to the element
let path: [JSONSubscriptType] = [1,"list",2,"name"]
let name = json[path].string
// Just the same
let name = json[1]["list"][2]["name"].string
// Alternatively
let name = json[1,"list",2,"name"].string
```

```swift
// With a hard way
let name = json[].string
```

```swift
// With a custom way
let keys:[SubscriptType] = [1,"list",2,"name"]
let name = json[keys].string
```

#### Loop

```swift
// If json is .Dictionary
for (key,subJson):(String, JSON) in json {
   // Do something you want
}
```

*The first element is always a String, even if the JSON is an Array*

```swift
// If json is .Array
// The `index` is 0..<json.count's string value
for (index,subJson):(String, JSON) in json {
    // Do something you want
}
```

#### Error

##### SwiftyJSON 4.x

SwiftyJSON 4.x introduces an enum type called `SwiftyJSONError`, which includes `unsupportedType`, `indexOutOfBounds`, `elementTooDeep`, `wrongType`, `notExist` and `invalidJSON`, at the same time, `ErrorDomain` are being replaced by `SwiftyJSONError.errorDomain`.
Note: Those old error types are deprecated in SwiftyJSON 4.x and will be removed in the future release.

##### SwiftyJSON 3.x

Use a subscript to get/set a value in an Array or Dictionary

If the JSON is:
*  an array, the app may crash with "index out-of-bounds."
*  a dictionary, it will be assigned to `nil` without a reason.
*  not an array or a dictionary, the app may crash with an "unrecognised selector" exception.

This will never happen in SwiftyJSON.

```swift
let json = JSON(["name", "age"])
if let name = json[999].string {
    // Do something you want
} else {
    print(json[999].error!) // "Array[999] is out of bounds"
}
```

```swift
let json = JSON(["name":"Jack", "age": 25])
if let name = json["address"].string {
    // Do something you want
} else {
    print(json["address"].error!) // "Dictionary["address"] does not exist"
}
```

```swift
let json = JSON(12345)
if let age = json[0].string {
    // Do something you want
} else {
    print(json[0])       // "Array[0] failure, It is not an array"
    print(json[0].error!) // "Array[0] failure, It is not an array"
}

if let name = json["name"].string {
    // Do something you want
} else {
    print(json["name"])       // "Dictionary[\"name"] failure, It is not an dictionary"
    print(json["name"].error!) // "Dictionary[\"name"] failure, It is not an dictionary"
}
```

#### Optional getter

```swift
// NSNumber
if let id = json["user"]["favourites_count"].number {
   // Do something you want
} else {
   // Print the error
   print(json["user"]["favourites_count"].error!)
}
```

```swift
// String
if let id = json["user"]["name"].string {
   // Do something you want
} else {
   // Print the error
   print(json["user"]["name"].error!)
}
```

```swift
// Bool
if let id = json["user"]["is_translator"].bool {
   // Do something you want
} else {
   // Print the error
   print(json["user"]["is_translator"].error!)
}
```

```swift
// Int
if let id = json["user"]["id"].int {
   // Do something you want
} else {
   // Print the error
   print(json["user"]["id"].error!)
}
...
```

#### Non-optional getter

Non-optional getter is named `xxxValue`

```swift
// If not a Number or nil, return 0
let id: Int = json["id"].intValue
```

```swift
// If not a String or nil, return ""
let name: String = json["name"].stringValue
```

```swift
// If not an Array or nil, return []
let list: Array<JSON> = json["list"].arrayValue
```

```swift
// If not a Dictionary or nil, return [:]
let user: Dictionary<String, JSON> = json["user"].dictionaryValue
```

#### Setter

```swift
json["name"] = JSON("new-name")
json[0] = JSON(1)
```

```swift
json["id"].int =  1234567890
json["coordinate"].double =  8766.766
json["name"].string =  "Jack"
json.arrayObject = [1,2,3,4]
json.dictionaryObject = ["name":"Jack", "age":25]
```

#### Raw object

```swift
let rawObject: Any = json.object
```

```swift
let rawValue: Any = json.rawValue
```

```swift
//convert the JSON to raw NSData
do {
	let rawData = try json.rawData()
  //Do something you want
} catch {
	print("Error \(error)")
}
```

```swift
//convert the JSON to a raw String
if let rawString = json.rawString() {
  //Do something you want
} else {
	print("json.rawString is nil")
}
```

#### Existence

```swift
// shows you whether value specified in JSON or not
if json["name"].exists()
```

#### Literal convertibles

For more info about literal convertibles: [Swift Literal Convertibles](http://nshipster.com/swift-literal-convertible/)

```swift
// StringLiteralConvertible
let json: JSON = "I'm a json"
```

```swift
/ /IntegerLiteralConvertible
let json: JSON =  12345
```

```swift
// BooleanLiteralConvertible
let json: JSON =  true
```

```swift
// FloatLiteralConvertible
let json: JSON =  2.8765
```

```swift
// DictionaryLiteralConvertible
let json: JSON =  ["I":"am", "a":"json"]
```

```swift
// ArrayLiteralConvertible
let json: JSON =  ["I", "am", "a", "json"]
```

```swift
// With subscript in array
var json: JSON =  [1,2,3]
json[0] = 100
json[1] = 200
json[2] = 300
json[999] = 300 // Don't worry, nothing will happen
```

```swift
// With subscript in dictionary
var json: JSON =  ["name": "Jack", "age": 25]
json["name"] = "Mike"
json["age"] = "25" // It's OK to set String
json["address"] = "L.A." // Add the "address": "L.A." in json
```

```swift
// Array & Dictionary
var json: JSON =  ["name": "Jack", "age": 25, "list": ["a", "b", "c", ["what": "this"]]]
json["list"][3]["what"] = "that"
json["list",3,"what"] = "that"
let path: [JSONSubscriptType] = ["list",3,"what"]
json[path] = "that"
```

```swift
// With other JSON objects
let user: JSON = ["username" : "Steve", "password": "supersecurepassword"]
let auth: JSON = [
  "user": user.object, // use user.object instead of just user
  "apikey": "supersecretapitoken"
]
```

#### Merging

It is possible to merge one JSON into another JSON. Merging a JSON into another JSON adds all non existing values to the original JSON which are only present in the `other` JSON.

If both JSONs contain a value for the same key, _mostly_ this value gets overwritten in the original JSON, but there are two cases where it provides some special treatment:

- In case of both values being a `JSON.Type.array` the values form the array found in the `other` JSON getting appended to the original JSON's array value.
- In case of both values being a `JSON.Type.dictionary` both JSON-values are getting merged the same way the encapsulating JSON is merged.

In case, where two fields in a JSON have a different types, the value will get always overwritten.

There are two different fashions for merging: `merge` modifies the original JSON, whereas `merged` works non-destructively on a copy.

```swift
let original: JSON = [
    "first_name": "John",
    "age": 20,
    "skills": ["Coding", "Reading"],
    "address": [
        "street": "Front St",
        "zip": "12345",
    ]
]

let update: JSON = [
    "last_name": "Doe",
    "age": 21,
    "skills": ["Writing"],
    "address": [
        "zip": "12342",
        "city": "New York City"
    ]
]

let updated = original.merge(with: update)
// [
//     "first_name": "John",
//     "last_name": "Doe",
//     "age": 21,
//     "skills": ["Coding", "Reading", "Writing"],
//     "address": [
//         "street": "Front St",
//         "zip": "12342",
//         "city": "New York City"
//     ]
// ]
```

## String representation
There are two options available:
- use the default Swift one
- use a custom one that will handle optionals well and represent `nil` as `"null"`:
```swift
let dict = ["1":2, "2":"two", "3": nil] as [String: Any?]
let json = JSON(dict)
let representation = json.rawString(options: [.castNilToNSNull: true])
// representation is "{\"1\":2,\"2\":\"two\",\"3\":null}", which represents {"1":2,"2":"two","3":null}
```

## Work with [Alamofire](https://github.com/Alamofire/Alamofire)

SwiftyJSON nicely wraps the result of the Alamofire JSON response handler:

```swift
Alamofire.request(url, method: .get).validate().responseJSON { response in
    switch response.result {
    case .success(let value):
        let json = JSON(value)
        print("JSON: \(json)")
    case .failure(let error):
        print(error)
    }
}
```

We also provide an extension of Alamofire for serializing NSData to SwiftyJSON's JSON.

See: [Alamofire-SwiftyJSON](https://github.com/SwiftyJSON/Alamofire-SwiftyJSON)


## Work with [Moya](https://github.com/Moya/Moya)

SwiftyJSON parse data to JSON:

```swift
let provider = MoyaProvider<Backend>()
provider.request(.showProducts) { result in
    switch result {
    case let .success(moyaResponse):
        let data = moyaResponse.data
        let json = JSON(data: data) // convert network data to json
        print(json)
    case let .failure(error):
        print("error: \(error)")
    }
}

```
## CurrencyTextField

The numbers that the user enters in the field are automatically formatted to display in the dollar amount format. For example, if the user enters the numbers 1 and 2, the text in the field is formatted to display $0.12 . If the user enters 3, 4, 5, 6 after that.. the field displays $1,234.56 
If the user presses the delete key, the text field displays $123.45

