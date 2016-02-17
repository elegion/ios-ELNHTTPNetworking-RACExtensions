# ELNHTTPNetworking-RACExtensions

## Installation

### Installation with CocoaPods

```
source 'https://github.com/elegion/ios-podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

pod 'ELNHTTPNetworking-RACExtensions'
```

## Usage

```objectivec

@weakify(self);
[[[[[self.httpClient rac_sendRequest:[Request new]] initially:^{
    @strongify(self);

    [self.activityIndicator startAnimating];
}] finally:^{
    @strongify(self);

    [self.activityIndicator stopAnimating];
}] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id responseObject) {
    @strongify(self);

    // TODO:
} error:^(NSError *error) {
    @strongify(self);

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.domain message:error.description preferredStyle:UIAlertControllerStyleAlert];

    [self presentViewController:alert animated:YES completion:nil];
}];

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## License

ELNHTTPNetworking-RACExtensions is available under the MIT license. See the LICENSE file for more info.

## Author

e-Legion
