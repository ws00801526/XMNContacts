//
//  XMNContactManager.m
//  Pods
//
//  Created by XMFraker on 17/3/20.
//
//

#import "XMNContactManager.h"

NSString *XMNContactDidLoadFinishedNotification = @"com.XMFraker.XMNContact.XMNContactDidLoadFinishedNotification";

#if kContactsFrameworkAvailable
@import Contacts;
#else
@import AddressBook;
#endif

@interface XMNContactManager ()

#if kContactsFrameworkAvailable
@property (strong, nonatomic) CNContactStore *contactStore;
#else
@property (assign, nonatomic) ABAddressBookRef addressBook;
#endif

@property (copy, nonatomic)   NSArray<XMNContact *> *contacts;
@property (strong, nonatomic) dispatch_queue_t loadContactsQueue;

/** 是否已经加载完成过一次 */
@property (assign, nonatomic, getter=isLoaded) BOOL loaded;

@end

@implementation XMNContactManager

#pragma mark - Life Cycle

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.loadContactsQueue = dispatch_queue_create("com.XMFraker.XMNContact.loadContactQueue", DISPATCH_QUEUE_CONCURRENT);
        [self  setup];
    }
    return self;
}

+ (instancetype)sharedManager {
    
    static id sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

- (void)dealloc {
    
#if kContactsFrameworkAvailable
    
    /** 移除通知监听 */
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CNContactStoreDidChangeNotification object:nil];
    self.contactStore = nil;
#else
    /** 移除addressBook监听,释放缓存 */
    ABAddressBookUnregisterExternalChangeCallback(self.addressBook, ABAddressBookUnregisterExternalChangeCallback, (__bridge_retained void *)(self));
    CFRelease(self.addressBook);
    self.addressBook = nil;
#endif
}

#pragma mark - Public Method


#if kContactsFrameworkAvailable

- (void)handleContactDidChanged:(NSNotification *)notification {
    
    self.loaded = NO;
    [self loadContactsWithCompletionBlock:nil];
}

- (void)loadContactsWithCompletionBlock:(void(^)(NSArray<XMNContact *> *contacts))completionBlock {
    
    dispatch_async(self.loadContactsQueue, ^{
        
        NSArray <CNContact *> *originContacts = [self.contactStore unifiedContactsMatchingPredicate:nil
                                                                                        keysToFetch:@[CNContactNamePrefixKey,CNContactNameSuffixKey,CNContactGivenNameKey,CNContactFamilyNameKey,CNContactNamePrefixKey,CNContactNamePrefixKey,CNContactPostalAddressesKey]
                                                                                              error:nil];
        NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:0];
        [self.contactStore enumerateContactsWithFetchRequest:[[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactNamePrefixKey,CNContactNameSuffixKey,CNContactGivenNameKey,CNContactFamilyNameKey,CNContactNamePrefixKey,CNContactNamePrefixKey,CNContactPostalAddressesKey,CNContactJobTitleKey,CNContactPhoneNumbersKey,CNContactMiddleNameKey,CNContactPhoneticGivenNameKey,CNContactPhoneticMiddleNameKey,CNContactPhoneticFamilyNameKey,CNContactOrganizationNameKey,CNContactDepartmentNameKey,CNContactPhoneticOrganizationNameKey,CNContactSocialProfilesKey]]
                                                       error:nil
                                                  usingBlock:^(CNContact * _Nonnull obj, BOOL * _Nonnull stop) {
                                                           
                                                           XMNContact *contact = [[XMNContact alloc] initWithContact:obj];
                                                           [contacts addObject:contact];
                                                       }];

//        [originContacts enumerateObjectsUsingBlock:^(CNContact * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//           
//            XMNContact *contact = [[XMNContact alloc] initWithContact:obj];
//            [contacts addObject:contact];
//        }];
        
        self.contacts = [contacts copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            /** 当主函数内回调,通知加载所有通讯录完成 */
            completionBlock ? completionBlock([contacts copy]) : nil;
            /** 发送通知 */
            [[NSNotificationCenter defaultCenter] postNotificationName:XMNContactDidLoadFinishedNotification object:nil];
        });

    });
}

#else

void addressBookChangedCallBack(ABAddressBookRef addressBook, CFDictionaryRef info, void *context) {
    
    /** 监听contact 是否发生改变,如果发生改变,则重新读取所有通讯录数据 */
    XMNContactManager *contactManager = CFBridgingRelease(context);
    contactManager.loaded = NO;
    [contactManager loadContactsWithCompletionBlock:nil];
}

- (void)loadContactsWithCompletionBlock:(void(^)(NSArray<XMNContact *> *contacts))completionBlock {
    
    if (self.isLoaded) {
        
        completionBlock ? completionBlock(self.contacts) : nil;
        return;
    }
    
    __weak typeof(*&self) wSelf = self;
    dispatch_async(self.loadContactsQueue, ^{
        
        __strong typeof(*&wSelf) self = wSelf;
        CFArrayRef arrayRef = ABAddressBookCopyArrayOfAllPeople(self.addressBook);
        NSMutableArray <XMNContact *> * contacts = [NSMutableArray arrayWithCapacity:CFArrayGetCount(arrayRef)];
        
        for (NSInteger index = 0; index < CFArrayGetCount(arrayRef); index ++) {
            
            ABRecordRef recordRef = CFArrayGetValueAtIndex(arrayRef, index);
            XMNContact *contact = [[XMNContact alloc] initWithRecordRef:recordRef];
            [contacts addObject:contact];
        }
        
        /** 释放内存 */
        CFRelease(arrayRef);
        self.contacts = [contacts copy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            /** 当主函数内回调,通知加载所有通讯录完成 */
            completionBlock ? completionBlock([contacts copy]) : nil;
            /** 发送通知 */
            [[NSNotificationCenter defaultCenter] postNotificationName:XMNContactDidLoadFinishedNotification object:nil];
        });
    });
}
#endif

#pragma mark - Private Method

- (void)setup {
    
#if kContactsFrameworkAvailable
    
    self.contactStore = [[CNContactStore alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleContactDidChanged:) name:CNContactStoreDidChangeNotification object:nil];
#else
    
    self.addressBook = ABAddressBookCreate();
    ABAddressBookRegisterExternalChangeCallback(self.addressBook, addressBookChangedCallBack, (__bridge_retained void *)(self));
#endif
}

#pragma mark - Getter

- (BOOL)isLoaded {
    
    return _loaded && self.contacts && self.contacts.count;
}

@end
