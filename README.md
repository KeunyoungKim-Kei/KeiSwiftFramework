# KeiSwiftFramework

[![Version](https://img.shields.io/cocoapods/v/KeiSwiftFramework.svg?style=flat)](http://cocoapods.org/pods/KeiSwiftFramework)
[![License](https://img.shields.io/cocoapods/l/KeiSwiftFramework.svg?style=flat)](http://cocoapods.org/pods/KeiSwiftFramework)
[![Platform](https://img.shields.io/cocoapods/p/KeiSwiftFramework.svg?style=flat)](http://cocoapods.org/pods/KeiSwiftFramework)

## Usage

### Date
##### Time Interval
```Swift
// 1 hour 30 min
let interval = 1.hour + 30.minute       // 5400.0
let min = interval.minuteInterval       // 90.0
let hour = interval.hourInterval        // 1.5

let yesterday = Yesterday.startDate
let now = Today.now
let minInterval = (now - yesterday).minuteInterval
let hourInterval = (now - yesterday).hourInterval
```

##### Date Components
```Swift
let now = NSDate()
let tenMinutesBefore = now - 10.minute
let twoHoursAfter = now + 2.hour

let month = now.month
```

##### Compare NSDate
```Swift
let date1 = NSDate(timeIntervalSince1970: 0)
let date2 = NSDate()

if date1 < date2 {
    print("asc")
} else if date1 > date2 {
    print("desc")
} else {
    print("same")
}
// Supported Operators : ==, !=, <, <=, >, >=


let now = Today.now
if now == KWeekday.Sunday {
    // ...
}

if now == KMonth.March {
    // ...
}
```

### Color
##### Parse Hex Color String #RGB, #ARGB, #RRGGBB, #AARRGGBB
```Swift
let hexString = "#03a9f4"
let color = UIColor(hexString: hexString)
let color2 = hexString.UIColorValue

if hexString.isHexColorString {
    // ...
}

if let color = hexString.parseHexColorString() {
    // ...
}
```

### CoreData Setup
```Swift
class AppDelegate: KApp {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupCoreData(modelName: "Model Name")
        // or
        setupCoreData(modelName: "Model Name", storeType: NSSQLiteStoreType, useLightweightMigration: true)

        return true
    }
}
```

### Time Profiler
```Swift
KTimeProfiler.start()                       // Required
// ...
KTimeProfiler.checkpoint()
// ...
KTimeProfiler.checkpoint("Create File")
// ...
KTimeProfiler.checkpoint("Save to DB")
// ...
KTimeProfiler.report(verbose: true)

// Verbose Report
// KTimeProfiler: application(_:didFinishLaunchingWithOptions:) in 0.801861s
// ==================================================
// Start            0
// Checkpoint 1    +0.100269
// Create File     +0.301065
// Save to DB      +0.200434
// End             +0.200093
// ==================================================
// total            0.801861
// ==================================================
```

### File & Directory
##### NSURL Extension
```Swift
let url = NSURL(fileURLWithPath: ...)

// read only
url.name
url.exist
url.isDirectory
url.fileSize
url.creationDate
url.lastAccessDate
url.modificationDate

// read/write
url.hidden
url.excludedFromBackup
```
##### Prevent files from being backed up to iCloud and iTunes
```Swift
url.excludedFromBackup = true
// or
url.addSkipBackupAttribute()
// or
NSFileManager.defaultManager().addSkipBackupAttributeToItemAtURL(url)
// or
do {
    try url.addSkipBackupAttributeOrThrows()
    // or
    try NSFileManager.defaultManager().addSkipBackupAttributeToItemAtURLOrThrows(url)
} catch {}
```

## Requirements
iOS 8 or higher

## Installation

KeiSwiftFramework is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KeiSwiftFramework"
```

## Author

Keun young Kim, app@meetkei.com

## License

KeiSwiftFramework is available under the MIT license. See the LICENSE file for more info.