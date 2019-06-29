# STBookTransition
A custom view transition that provides 3D book fold and unfold animation for view display and hide

[![CI Status](http://img.shields.io/travis/Sa74/STCubeTransition.svg?style=flat)](https://travis-ci.org/Sa74/STBookTransition)
[![Version](https://img.shields.io/cocoapods/v/STCubeTransition.svg?style=flat)](http://cocoapods.org/pods/STBookTransition)
[![License](https://img.shields.io/cocoapods/l/STCubeTransition.svg?style=flat)](http://cocoapods.org/pods/STBookTransition)
[![Platform](https://img.shields.io/cocoapods/p/STCubeTransition.svg?style=flat)](http://cocoapods.org/pods/STBookTransition)

# Screenshot
![STBookTransition](https://github.com/Sa74/STBookTransition/blob/master/STBookTransition/STBookTransition/screenShot/bookTransition.gif)

## Installation

### Cocoapods
STBookTransition is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'STBookTransition'
```
You want to add pod 'STBookTransition', '~> 1.1' similar to the following to your Podfile:

```
target 'MyApp' do
  pod 'STBookTransition', '~> 1.1'
  use_frameworks!
end
```
Then run a pod install inside your terminal, or from CocoaPods.app.

Alternatively to give it a test run, run the command:

```
pod try STBookTransition
```
### Manual
- Drag and drop `STBookTransition.swift` class into your project in Xcode.
- Make sure you select all the targets required.

## Usage

It is much simpler than performing an UIView animation. 

If you use `Cocoapods`, First of all, import the framework:

```
import STBookTransition
```

Then, init `STBookTransition` with delegate as follows,

```
let bookTranstion:STBookTransition = STBookTransition()
bookTranstion.delegate = self
```

next, perform cube transition between your views as follows,

```
self.bookTransition?.animateView(displayView, 			// View that you want to transit
				 style: transitionStyle, 	// any available BookTransitionStyle
				 duration: 0.5)			// animation duration
```

Finally, implement the `BookTransitionDelegate` optional method if you would like to perform any additional actions,

```
func animationDidFinishWithView(displayView: UIView) {
        // Do any additional work if required
    }
```

Here you go you are all setup for performing cool Book Transition in you app 👍

## Author

[Sasi Moorthy](https://twitter.com/Sasi3726), 📧 msasi7274@gmail.com. Looking out for freelance work, if interested feel free to contact me.

#### Contributing
I :heart: pull requests. If you'd like to see new features, fix bugs, or lodge
issues then please do so via Github.


## License

[STBookTransition](https://cocoapods.org/pods/STBookTransition) is available under the MIT license. See the LICENSE file for more info.
