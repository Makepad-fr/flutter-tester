# Flutter Tester

A Dart package that lets you test your Flutter apps in headless mode. 

## Notice

This project is under active development. For instance it support only iOS runtime with mono-threaded test running. 
Please check for updates before every use with

```sh
dart pub global activate ft
``` 

## Motivation

Flutter is a great framework for cross-platform app development which gives the possibility to deploy the first version on a record time. The time consuming part of the Flutter development flow is the end to end testing. Currently there's nothing which lets you test your application in a completely automatised way. This package let you to integrate your cross platform end to end tests in your CI/CD workflows. 

## Installing

```sh
dart pub global activate ft
```

## Using

```sh
ft --device=<simulator_uid> --platform=<plaform_name>  --permission=<permission> integration_test/<file_name>
```

### Simulator uid

#### For iOS

You can use following simulators

##### iPhone

- **4s** `com.apple.CoreSimulator.SimDeviceType.iPhone-4s`
- **5** `com.apple.CoreSimulator.SimDeviceType.iPhone-5`
- **5s** `com.apple.CoreSimulator.SimDeviceType.iPhone-5s`
- **6 plus** `com.apple.CoreSimulator.SimDeviceType.iPhone-6-Plus`
- **6** `com.apple.CoreSimulator.SimDeviceType.iPhone-6`
- **6s** `com.apple.CoreSimulator.SimDeviceType.iPhone-6s`
- **6s plus** `com.apple.CoreSimulator.SimDeviceType.iPhone-6s-Plus`
- **se** `com.apple.CoreSimulator.SimDeviceType.iPhone-SE`
- **7** `com.apple.CoreSimulator.SimDeviceType.iPhone-7`
- **7 plus** `com.apple.CoreSimulator.SimDeviceType.iPhone-7-Plus`
- **8** `com.apple.CoreSimulator.SimDeviceType.iPhone-8`
- **8 plus** `com.apple.CoreSimulator.SimDeviceType.iPhone-8-Plus`
- **x** `com.apple.CoreSimulator.SimDeviceType.iPhone-X`
- **xs** `com.apple.CoreSimulator.SimDeviceType.iPhone-XS`
- **xs max** `com.apple.CoreSimulator.SimDeviceType.iPhone-XS-Max`
- **xr** `com.apple.CoreSimulator.SimDeviceType.iPhone-XR`
- **11** `com.apple.CoreSimulator.SimDeviceType.iPhone-11`
- **11 pro** `com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro`
- **11 pro max** `com.apple.CoreSimulator.SimDeviceType.iPhone-11-Pro-Max`
- **iPhone 12 mini** `com.apple.CoreSimulator.SimDeviceType.iPhone-12-mini`
- **iPhone 12** `com.apple.CoreSimulator.SimDeviceType.iPhone-12`
- **iPhone 12 Pro** `com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro`
- **iPhone 12 Pro Max** `com.apple.CoreSimulator.SimDeviceType.iPhone-12-Pro-Max`
- **se 2nd gen**  `com.apple.CoreSimulator.SimDeviceType.iPhone-SE--2nd-generation-`

##### iPad




### Permissions 

#### For iOS

Following permissions are supported:

```
'all'
'calendar'
'contacts-limited'
'contacts'
'location'
'location-always'
'photos-add'
'photos'
'media-library'
'microphone'
'motion'
'reminders'
'siri'
```

## Contribution

This project adheres to the Contributor Covenant [code of conduct](./CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. We appreciate your contribution. Please refer to our [contributing](./CONTRIBUTING.md) guidelines for further information.

For questions, support and general discussion, please use [GitHub Discussions](https://github.com/Makepad-fr/flutter-tester/discussions);

## Documentation

Documentation is hosted live on [project's website](https://ft.makepad.io)
