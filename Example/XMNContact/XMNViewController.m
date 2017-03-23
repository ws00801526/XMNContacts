//
//  XMNViewController.m
//  XMNContact
//
//  Created by ws00801526 on 03/20/2017.
//  Copyright (c) 2017 ws00801526. All rights reserved.
//

#import "XMNViewController.h"

#import <XMNContact/XMNContactManager.h>
#import <AddressBook/AddressBook.h>

@import XMNContact;

@interface XMNViewController ()

@end

@implementation XMNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof(*&self) wSelf = self;
    [[XMNContactManager sharedManager] loadContactsWithCompletionBlock:^(NSArray<XMNContact *> * _Nonnull contacts) {
        __strong typeof(*&wSelf) self = wSelf;
        NSLog(@"contact manager did load contacts :%@",contacts);
    }];
}

- (void)dealloc {
    
    NSLog(@"%@  dealloc",self);
}

@end
