//
//  XMNAddressBookTest.m
//  XMNContact
//
//  Created by XMFraker on 17/3/20.
//  Copyright © 2017年 ws00801526. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <XMNContact/XMNContactManager.h>
#import <AddressBook/AddressBook.h>

@interface XMNAddressBookTest : XCTestCase

@property (assign, nonatomic) ABAddressBookRef bookRef;


@end

@implementation XMNAddressBookTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.bookRef = ABAddressBookCreate();
    ABAddressBookRequestAccessWithCompletion(self.bookRef,  ^(bool granted, CFErrorRef error){
        
        
    });
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
