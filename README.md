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
[[[[[self.httpClient rac_sendRequest:[ELNDemoRequest new]] initially:^{
    @strongify(self);

    self.textView.text = nil;

    [self.activityIndicator startAnimating];
}] finally:^{
    @strongify(self);

    [self.activityIndicator stopAnimating];
}] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray<ELNDemoModel *> *items) {
    @strongify(self);

    NSMutableString *text = [NSMutableString new];

    for (ELNDemoModel *item in items) {
        [text appendString:item.body];
        [text appendString:@"\n\n"];
    }

    self.textView.text = [text copy];
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
