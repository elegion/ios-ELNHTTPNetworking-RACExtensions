//
//  ELNViewController.m
//  ELNHTTPNetworking-RACExtensions
//
//  Created by Geor Kasapidi on 02/17/2016.
//  Copyright (c) 2016 Geor Kasapidi. All rights reserved.
//

#import "ELNHTTPClient+RACExtensions.h"

#import "ELNViewController.h"
#import "ELNDemoNetworkConfig.h"
#import "ELNDemoRequest.h"
#import "ELNDemoModel.h"

@interface ELNViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (strong, nonatomic) ELNHTTPClient *httpClient;

@end

@implementation ELNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.httpClient = [[ELNHTTPClient alloc] initWithConfiguration:[ELNDemoNetworkConfig new]];
}

- (IBAction)sendRequest:(id)sender
{
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
}

@end
