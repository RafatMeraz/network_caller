<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Network caller for the api based application with the help of http package

## Features

- get request
- post request
- multipart file support & conversion
- logger

## Getting started
Add these line into ```pubspec.yaml``` file as dependency and run ```flutter pub get```

```puml
 network_caller:
    git:
      url: git://github.com/RafatMeraz/network_caller.git
      ref: version
```

## Usage

```dart

final response = await BaseNetworkCaller.getRequest(
    'url', 
    token: 'your_token_here_if_necessary', 
    onUnAuthorized: () {
      // your desired action you want to do
    }
);
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
