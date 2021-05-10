# Purpose 
To get simple chart view easily.
You can drag on chart in order to see specific data.

![chartView](source/easyChartView.gif)


## Requirements
iOS 13.0

## Installation

EasyChart is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EasyChart'
```


# Usage 

In order to create ``EasyChart``, first you should have data array conforming ``EasyChartObjectProtocol``. 
- ``value`` is meaning each line height.  this should need.
- ``row``is meaning each line bottom name. this is optional. 

```swift
public protocol EasyChartObjectProtocol {
    var value: CGFloat { get set }
    var row: String? { get set }
}
```
Or you can just make ``Object`` already made in project conforming ``EasyChartObjectProtocol``

then just create EasyChartView with data. 
- you can set frame or constraint. 

```swift 
import EasyChart 
...
let data: [EasyChartObjectProtocol] = [] 
let easyChartView = EasyChartView(objects: data )
...
view.addSubview(easyChartView)
```
you can again draw chart with animation. 

```swift
easyChartView.chartView.drawChart()
```


Also, you can see that process in ``DemoApp`` project. 




## Author

gustn3965, gustn3965@gmail.com
