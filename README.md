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

### Headless mode

By default tests will run on headless mode. If you want to disable you can use `--no-headless` flag.

### Simulator uid

#### For iOS

You can use one or more of following simulators.

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

  - **2** `com.apple.CoreSimulator.SimDeviceType.iPad-2`
  - **retina** `com.apple.CoreSimulator.SimDeviceType.iPad-Retina`
  - **air** `com.apple.CoreSimulator.SimDeviceType.iPad-Air`
  - **mini 2** `com.apple.CoreSimulator.SimDeviceType.iPad-mini-2`
  - **mini 3** `com.apple.CoreSimulator.SimDeviceType.iPad-mini-3`
  - **mini 4** `com.apple.CoreSimulator.SimDeviceType.iPad-mini-4`
  - **air 2** `com.apple.CoreSimulator.SimDeviceType.iPad-Air-2`
  - **pro 9.7** `com.apple.CoreSimulator.SimDeviceType.iPad-Pro--9-7-inch-`
  - **pro 12.9** `com.apple.CoreSimulator.SimDeviceType.iPad-Pro`
  - **5th gen** `com.apple.CoreSimulator.SimDeviceType.iPad--5th-generation-`
  - **pro 12.9 2nd gen** `com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---2nd-generation-`
  - **pro 10.5** `com.apple.CoreSimulator.SimDeviceType.iPad-Pro--10-5-inch-`
  - **6th gen** `com.apple.CoreSimulator.SimDeviceType.iPad--6th-generation-`
  - **7th gen** `com.apple.CoreSimulator.SimDeviceType.iPad--7th-generation-`
  - **8th gen** `com.apple.CoreSimulator.SimDeviceType.iPad--8th-generation-`
  - **pro 11** `com.apple.CoreSimulator.SimDeviceType.iPad-Pro--11-inch-`
  - **pro 12.9 3rd gen** `com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---3rd-generation-`
  - **pro 11 2nd gen** `com.apple.CoreSimulator.SimDeviceType.iPad-Pro--11-inch---2nd-generation-`
  - **pro 12.9 4th gen** `com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---4th-generation-`
  - **mini 5th gen** `com.apple.CoreSimulator.SimDeviceType.iPad-mini--5th-generation-`
  - **air 3rd gen** `com.apple.CoreSimulator.SimDeviceType.iPad-Air--3rd-generation-`


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
