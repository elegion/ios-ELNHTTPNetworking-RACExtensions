//
//  Tests.m
//  Tests
//
//  Created by Dmitry Nesterenko on 12.04.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ELNHTTPClient+RACExtensions.h"
#import "DemoClientConfiguration.h"
#import "DemoRequest.h"
#import "DemoModel.h"

@interface ELNHTTPClientTests : XCTestCase

@property (nonatomic, strong) ELNHTTPClient *client;

@end

@implementation ELNHTTPClientTests

- (void)setUp {
    self.client = [[ELNHTTPClient alloc] initWithConfiguration:[DemoClientConfiguration new]];
}

- (void)testRequestSignalHandling {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    
    RACSignal *signal = [self.client rac_sendRequest:[DemoRequest new]];
    [signal subscribeNext:^(id x) {
        NSArray *array = x;
        XCTAssertTrue([array isKindOfClass:[NSArray class]]);
        
        DemoModel *model = array.firstObject;
        XCTAssertTrue([model isKindOfClass:[DemoModel class]]);
    } error:^(NSError *error) {
        XCTAssert(error == nil, @"Invalid request");
    } completed:^{
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
