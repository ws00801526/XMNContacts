//
//  XMNContact.m
//  Pods
//
//  Created by XMFraker on 17/3/21.
//
//

#import "XMNContact.h"

#pragma mark - XMNLabeledValue

@interface XMNLabeledValue ()

@property (copy, NS_NONATOMIC_IOSONLY)   NSString *label;
@property (strong, NS_NONATOMIC_IOSONLY) id<NSCopying, NSSecureCoding> value;

@end

@implementation XMNLabeledValue

- (instancetype)initWithLabel:(NSString *)label
                        value:(id<NSCopying,NSSecureCoding>)value {
    
    if (self = [super init]) {
     
        self.label = label;
        self.value = value;
    }
    return self;
}

+ (instancetype)labeledValueWithLabel:(NSString *)label
                                value:(id<NSCopying,NSSecureCoding>)value {
    
    return [[XMNLabeledValue alloc] initWithLabel:label
                                            value:value];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    
    return [[XMNLabeledValue allocWithZone:zone] initWithLabel:self.label
                                                         value:self.value];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    return [XMNLabeledValue labeledValueWithLabel:[aDecoder decodeObjectForKey:@"label"]
                                            value:[aDecoder decodeObjectForKey:@"value"]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.label forKey:@"label"];
    [aCoder encodeObject:self.value forKey:@"value"];
}

@end


#pragma mark - XMNPhoneNumber 

@interface XMNPhoneNumber ()

@property (copy, NS_NONATOMIC_IOSONLY)   NSString *stringValue;

@end

@implementation XMNPhoneNumber

/**
 初始化方法 根据给定的stringValue生成XMNPhoneNumber实例
 
 @param stringValue 给定的手机号字符串
 @return XMNPhoneNumber实例 or nil(stringValue = nil)
 */
- (instancetype)initWithStringValue:(NSString *)stringValue {
    
    if (!stringValue || !stringValue.length) {
        return nil;
    }
    
    if (self = [super init]) {
        
        self.stringValue = stringValue;
    }
    return self;
}

+ (instancetype)phoneNumberWithStringValue:(NSString *)stringValue {
    
    return [[XMNPhoneNumber alloc] initWithStringValue:stringValue];
}

@end


#pragma mark - XMNPostalAddress

@interface XMNPostalAddress ()

/** 街道地址 多个街道地址 以分隔符"\n"分开*/
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *street;
/** 国家 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *country;
/** 国家ISO编号 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *ISOcountryCode;
/** 邮编 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *postalCode;
/** 州,省份 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *state;
/** 城市 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *city;


@end

@implementation XMNPostalAddress

- (instancetype)initWithCountry:(nullable NSString *)country
                 ISOcountryCode:(nullable NSString *)ISOcountryCode
                          state:(nullable NSString *)state
                           city:(nullable NSString *)city
                         street:(nullable NSString *)street
                     postalCode:(nullable NSString *)postalCode {
    
    if (self = [super init]) {
        
        self.country = country;
        self.ISOcountryCode = ISOcountryCode;
        self.state = state;
        self.city = city;
        self.street = street;
        self.postalCode = postalCode;
    }
    return self;
}

#if kContactsFrameworkAvailable
- (instancetype)initWithPostalAddress:(CNPostalAddress *)postalAddress {
    
    if (self = [super init]) {
        
        self.country = postalAddress.country;
        self.ISOcountryCode = postalAddress.ISOCountryCode;
        self.state = postalAddress.state;
        self.city = postalAddress.city;
        self.street = postalAddress.street;
        self.postalCode = postalAddress.postalCode;
    }
    return self;
}
#else
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        self.country = [dictionary objectForKey:kABPersonAddressCountryKey];
        self.city = [dictionary objectForKey:kABPersonAddressCityKey];
        self.state = [dictionary objectForKey:kABPersonAddressStateKey];
        self.street = [dictionary objectForKey:kABPersonAddressStreetKey];
        self.postalCode = [dictionary objectForKey:kABPersonAddressZIPKey];
        self.ISOcountryCode = [dictionary objectForKey:kABPersonAddressCountryCodeKey];
    }
    return self;
}
#endif

@end

#pragma mark - XMNSocialProfile

@interface XMNSocialProfile ()
/** 第三方社交账号服务类型 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *service;
/** 第三方服务账号用户名 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *username;
/** 第三方服务账号唯一标识 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *userIdentifier;
/** 第三方服务账号主页 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *urlString;

@end

@implementation XMNSocialProfile

- (instancetype)initWithService:(nullable NSString *)service
                       username:(nullable NSString *)username
                 userIdentifier:(nullable NSString *)userIdentifier
                      urlString:(nullable NSString *)urlString {
    
    if (self = [super init]) {
        
        self.service = service;
        self.username = username;
        self.userIdentifier = userIdentifier;
        self.urlString = urlString;
    }
    return self;
}

#if kContactsFrameworkAvailable
- (instancetype)initWithSocialProfile:(CNSocialProfile *)socialProfile {
    
    return [self initWithService:[CNSocialProfile localizedStringForService:socialProfile.service]
                        username:socialProfile.username
                  userIdentifier:socialProfile.userIdentifier
                       urlString:socialProfile.urlString];
}
#endif

@end

#pragma mark - XMNInstantMessageAddress

@interface XMNInstantMessageAddress ()

/** 即时通讯服务类型 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *service;
/** 即时通讯账号用户名 */
@property (copy, NS_NONATOMIC_IOSONLY)  NSString *username;

@end

@implementation XMNInstantMessageAddress

- (instancetype)initWithService:(nullable NSString *)service
                       username:(nullable NSString *)username {
    
    if (self = [super init]) {
        
        self.service    = service;
        self.username   = username;
    }
    return self;
}

#if kContactsFrameworkAvailable
- (instancetype)initWithInstantMessageAddress:(CNInstantMessageAddress *)instantMessageAddress {
    
    return [self initWithService:instantMessageAddress.service
                        username:instantMessageAddress.username];
}
#endif
@end


#pragma mark - XMNContact

@interface XMNContact ()

#if kContactsFrameworkAvailable
/** 联系人的唯一标识符 */
@property (copy, NS_NONATOMIC_IOSONLY)   NSString *identifier;
#else
/** 联系人的唯一标识符 */
@property (assign, NS_NONATOMIC_IOSONLY)   ABRecordID recordID;
#endif
/** 联系人类型 */
@property (assign, NS_NONATOMIC_IOSONLY) XMNContactType contactType;

/** 姓名前缀 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *namePrefix;
/** 名字 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *givenName;
/** 中间名 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *middleName;
/** 姓氏 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *familyName;

/** 姓氏前缀 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *previousFamilyName;

/** 名字后缀 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *nameSuffix;
/** 昵称 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *nickname;

/** 姓名首字母 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticGivenName;
/** 中间名首字母 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticMiddleName;
/** 姓氏首字母 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticFamilyName;

/// ========================================
/// @name   公司相关信息
/// ========================================

/** 公司,组织名称 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *organizationName;
/** 公司部门 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *departmentName;
/** 公司职称 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *jobTitle;
/** 公司首字母 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticOrganizationName NS_AVAILABLE(10_12, 10_0);

/// ========================================
/// @name   日期相关属性
/// ========================================

/** 生日 */
@property (copy, NS_NONATOMIC_IOSONLY) NSDateComponents *birthday;
/** 其他类型日历生日, 农历,希伯来,阿拉伯等 */
@property (copy, NS_NONATOMIC_IOSONLY) NSDateComponents *nonGregorianBirthday;
/** 其他类型日期 纪念日,其他自定义标签等 */
@property (copy, NS_NONATOMIC_IOSONLY) NSArray<XMNLabeledValue<NSDateComponents *> *> *dates;


/// ========================================
/// @name   相关labeledValue
/// ========================================

/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY) NSArray<XMNLabeledValue<XMNPhoneNumber *> *> *phoneNumbers;
/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY) NSArray<XMNLabeledValue<NSString *> *> *emailAddresses;
/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY) NSArray<XMNLabeledValue<XMNPostalAddress *> *> *postalAddresses;
/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY) NSArray<XMNLabeledValue<NSString *> *> *urlAddresses;
/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY) NSArray<XMNLabeledValue<NSString *> *> *contactRelations;

/** 社交账号 例如facebook,SinaWeibo,TencentWeibo,Twitter*/
@property (copy, NS_NONATOMIC_IOSONLY) NSArray<XMNLabeledValue<XMNSocialProfile*>*> *socialProfiles;
/** 即时通讯数据 如facebook,QQ,Wechat,Linkin */
@property (copy, NS_NONATOMIC_IOSONLY) NSArray<XMNLabeledValue<XMNInstantMessageAddress*>*>   *instantMessageAddresses;

/// ========================================
/// @name   其他信息 -- 头像,备注
/// ========================================

/** 备注信息 */
@property (copy, NS_NONATOMIC_IOSONLY) NSString *note;

/** 头像图片数据 */
@property (copy, NS_NONATOMIC_IOSONLY) NSData *imageData;
/** 头像缩略图数据 */
@property (copy, NS_NONATOMIC_IOSONLY) NSData *thumbnailImageData;
/** 是否有可用头像 */
@property (assign, NS_NONATOMIC_IOSONLY) BOOL imageDataAvailable;

@end

#import "NSArray+XMNUtils.h"
#import "NSString+XMNContactUtils.h"

#if kContactsFrameworkAvailable

@implementation XMNContact (Contacts)

- (instancetype)initWithContact:(CNContact *)contact {
    
    if (!contact) {
        return nil;
    }
    if (self = [super init]) {

        [self configIdentifierWithContact:contact];
        [self configNamesWithContact:contact];
        [self configDatesWithContact:contact];
        
        [self configOrganizationWithContact:contact];

        /** 手机号 */
        if ([contact isKeyAvailable:CNContactPhoneNumbersKey]) {
            self.phoneNumbers = [contact.phoneNumbers xmn_map:^id _Nonnull(CNLabeledValue<CNPhoneNumber *> * _Nonnull obj, NSInteger index) {
                
                return [XMNLabeledValue labeledValueWithLabel:obj.label
                                                        value:[XMNPhoneNumber phoneNumberWithStringValue:obj.value.stringValue]];
            }];
        }
        
        /** email */
        if ([contact isKeyAvailable:CNContactEmailAddressesKey]) {
            
            self.emailAddresses = [contact.emailAddresses xmn_map:^id _Nonnull(CNLabeledValue<NSString *> * _Nonnull obj, NSInteger index) {
                
                return [XMNLabeledValue labeledValueWithLabel:obj.label
                                                        value:obj.value];
            }];
        }
        
        /** url addresses */
        if ([contact isKeyAvailable:CNContactUrlAddressesKey]) {
            self.urlAddresses = [contact.urlAddresses xmn_map:^id _Nonnull(CNLabeledValue<NSString *> * _Nonnull obj, NSInteger index) {
               
                return [XMNLabeledValue labeledValueWithLabel:obj.label
                                                        value:obj.value];
            }];
        }
        
        /** social profiles */
        if ([contact isKeyAvailable:CNSocialProfileServiceKey]) {
            self.socialProfiles = [contact.socialProfiles xmn_map:^id _Nonnull(CNLabeledValue<CNSocialProfile *> * _Nonnull obj, NSInteger index) {

                return [XMNLabeledValue labeledValueWithLabel:obj.label
                                                        value:[[XMNSocialProfile alloc] initWithSocialProfile:obj.value]];
            }];
        }
        
        /** instant message */
        if ([contact isKeyAvailable:CNContactInstantMessageAddressesKey]) {
        
            self.instantMessageAddresses = [contact.instantMessageAddresses xmn_map:^id _Nonnull(CNLabeledValue<CNInstantMessageAddress *> * _Nonnull obj, NSInteger index) {
               
                return [XMNLabeledValue labeledValueWithLabel:obj.label
                                                        value:[[XMNInstantMessageAddress alloc] initWithInstantMessageAddress:obj.value]];
            }];
        }
        
        /** postal addresses  */
        if ([contact isKeyAvailable:CNContactPostalAddressesKey]) {
        
            self.postalAddresses = [contact.postalAddresses xmn_map:^id _Nonnull(CNLabeledValue<CNPostalAddress *> * _Nonnull obj, NSInteger index) {
               
                return [XMNLabeledValue labeledValueWithLabel:obj.label
                                                        value:[[XMNPostalAddress alloc] initWithPostalAddress:obj.value]];
            }];
        }
        
        /** contact relation */
        if ([contact isKeyAvailable:CNContactRelationsKey]) {
            
            self.contactRelations = [contact.contactRelations xmn_map:^id _Nonnull(CNLabeledValue<CNContactRelation *> * _Nonnull obj, NSInteger index) {

                return [XMNLabeledValue labeledValueWithLabel:obj.label
                                                        value:obj.value.name];
            }];
        }
        
        /** avatar */
        if ([contact areKeysAvailable:@[CNContactImageDataKey,CNContactThumbnailImageDataKey,CNContactImageDataAvailableKey]]) {
            
            if (contact.imageDataAvailable) {
                self.imageData = contact.imageData;
                self.thumbnailImageData = contact.thumbnailImageData;
            }
        }
        /** note */
        if ([contact isKindOfClass:CNContactNoteKey]) {
            self.note = contact.note;
        }
    }
    return self;
}

- (void)configIdentifierWithContact:(CNContact *)contact {
    
    /** contact 唯一标识 */
    if ([contact isKeyAvailable:CNGroupIdentifierKey]) {
        self.identifier = contact.identifier;
    }
    
    /** contact - type */
    if ([contact isKeyAvailable:CNContactTypeKey]) {
        self.contactType = contact.contactType;
    }
}

- (void)configNamesWithContact:(CNContact *)contact {
    
    if ([contact areKeysAvailable:[NSString XMNContactNameKeys]]) {
        /** 姓名相关 */
        self.givenName = contact.givenName;
        self.middleName = contact.middleName;
        self.familyName = contact.familyName;
        self.previousFamilyName = contact.previousFamilyName;
        self.namePrefix = contact.namePrefix;
        self.nameSuffix = contact.nameSuffix;
        self.nickname = contact.nickname;
        
        self.phoneticGivenName = contact.phoneticGivenName;
        self.phoneticFamilyName = contact.phoneticFamilyName;
        self.phoneticMiddleName = contact.phoneticMiddleName;
#if __IPHONE_10_0
        /** iOS10+ 支持公司拼音首字母 */
        self.phoneticOrganizationName = contact.phoneticOrganizationName;
#endif
    }
}

- (void)configOrganizationWithContact:(CNContact *)contact {
    
    if ([contact areKeysAvailable:@[CNContactOrganizationNameKey,CNContactDepartmentNameKey,CNContactJobTitleKey]]) {
        /** 组织 */
        self.organizationName = contact.organizationName;
        self.departmentName = contact.departmentName;
        self.jobTitle = contact.jobTitle;
    }
}

- (void)configDatesWithContact:(CNContact *)contact {
    
    if ([contact isKeyAvailable:CNContactBirthdayKey]) {
        self.birthday = contact.birthday;
    }
    
    if ([contact isKeyAvailable:CNContactNonGregorianBirthdayKey]) {
        self.nonGregorianBirthday = contact.nonGregorianBirthday;
    }
    
    if ([contact isKeyAvailable:CNContactDatesKey]) {
        self.dates = [contact.dates xmn_map:^id _Nonnull(CNLabeledValue<NSDateComponents *> * _Nonnull obj, NSInteger index) {

            return [XMNLabeledValue labeledValueWithLabel:obj.label
                                                    value:obj.value];
        }];
    }
}

@end

#else

@implementation XMNContact (AddressBook)

- (instancetype)initWithRecordRef:(ABRecordRef)recordRef {
    
    if (recordRef == nil) {
        return nil;
    }
    
    if (self = [super init]) {
        
        [self configIdentifierWithRecordRef:recordRef];
        
        [self configNamesWithRecordRef:recordRef];
        [self configOrganizationWithRecordRef:recordRef];
        [self configDatesWithRecordRef:recordRef];
        [self configOtherWithRecordRef:recordRef];
        
        self.emailAddresses = [self labeledValuesWithProperty:kABPersonEmailProperty
                                                    recordRef:recordRef];
        self.urlAddresses = [self labeledValuesWithProperty:kABPersonURLProperty
                                                    recordRef:recordRef];
        self.postalAddresses = [self labeledValuesWithProperty:kABPersonAddressProperty
                                                    recordRef:recordRef];
        self.phoneNumbers = [self labeledValuesWithProperty:kABPersonPhoneProperty
                                                    recordRef:recordRef];
        self.contactRelations = [self labeledValuesWithProperty:kABPersonRelatedNamesProperty
                                                    recordRef:recordRef];
        self.socialProfiles = [self labeledValuesWithProperty:kABPersonSocialProfileProperty
                                                      recordRef:recordRef];
        self.instantMessageAddresses = [self labeledValuesWithProperty:kABPersonInstantMessageProperty
                                                             recordRef:recordRef];
    }
    return self;
}


- (void)dealloc {
    
    NSLog(@"%@  dealloc",self);
    self.recordID = nil;
}

- (void)configIdentifierWithRecordRef:(ABRecordRef)recordRef {
    
    self.recordID = ABRecordGetRecordID(recordRef);
    
    CFNumberRef typeIndex = ABRecordCopyValue(recordRef, kABPersonKindProperty);
    self.contactType = CFNumberCompare(typeIndex, kABPersonKindOrganization, nil) == kCFCompareEqualTo ? XMNContactTypeOrganization : XMNContactTypePerson;
    CFRelease(typeIndex);
}

- (void)configNamesWithRecordRef:(ABRecordRef)recordRef {

    /** 姓名 */
    self.givenName = [NSString contactStringForProperty:kABPersonFirstNameProperty withRecordRef:recordRef];
    /** 姓氏 */
    self.familyName = [NSString contactStringForProperty:kABPersonLastNameProperty withRecordRef:recordRef];
    /** 名字中的信仰名称 */
    self.middleName = [NSString contactStringForProperty:kABPersonMiddleNameProperty withRecordRef:recordRef];
    /** 名字前缀 */
    self.namePrefix = [NSString contactStringForProperty:kABPersonPrefixProperty withRecordRef:recordRef];
    /** 名字后缀 */
    self.nameSuffix = [NSString contactStringForProperty:kABPersonSuffixProperty withRecordRef:recordRef];
    /** 名字昵称 */
    self.nickname = [NSString contactStringForProperty:kABPersonNicknameProperty withRecordRef:recordRef];

    /** 名字的拼音音标 */
    self.phoneticGivenName = [NSString contactStringForProperty:kABPersonFirstNamePhoneticProperty withRecordRef:recordRef];
    /** 姓氏的拼音音标 */
    self.phoneticFamilyName = [NSString contactStringForProperty:kABPersonLastNamePhoneticProperty withRecordRef:recordRef];
    /** 英文信仰缩写字母的拼音音标 */
    self.phoneticMiddleName = [NSString contactStringForProperty:kABPersonMiddleNamePhoneticProperty withRecordRef:recordRef];
}

- (void)configOrganizationWithRecordRef:(ABRecordRef)recordRef {
    
    /** 公司(组织)名称 */
    self.organizationName = [NSString contactStringForProperty:kABPersonOrganizationProperty withRecordRef:recordRef];
    /** 部门 */
    self.departmentName = [NSString contactStringForProperty:kABPersonDepartmentProperty withRecordRef:recordRef];
    /** 职位 */
    self.jobTitle = [NSString contactStringForProperty:kABPersonJobTitleProperty withRecordRef:recordRef];
}

- (void)configDatesWithRecordRef:(ABRecordRef)recordRef {

    /** 格林威治 生日 */
    self.birthday = [NSDateComponents contactDateComponentsForProperty:kABPersonBirthdayProperty
                                                              calendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]
                                                         withRecordRef:recordRef];
    
    /** 其他纪元生日  农历,阿拉伯历等 */
    self.nonGregorianBirthday = [NSDateComponents contactDateComponentsForDictionary:[NSDictionary contactDictionaryForProperty:kABPersonAlternateBirthdayProperty withRecordRef:recordRef]];
    
    /** 纪念日等 */
    ABMultiValueRef values = ABRecordCopyValue(recordRef, kABPersonDateProperty);
    NSMutableArray<XMNLabeledValue *> *dates = [NSMutableArray arrayWithCapacity:ABMultiValueGetCount(values)];
    
    for (int i = 0; i < ABMultiValueGetCount(values); i ++) {
        
        NSDate *date = (__bridge NSDate *)(ABMultiValueCopyValueAtIndex(values, i));

        XMNLabeledValue *dateLabeledValue = [XMNLabeledValue labeledValueWithLabel:(__bridge NSString *)(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(values, i)))
                                                                             value:[NSDateComponents contactDateComponentsForDate:date]];
        
    }
    CFRelease(values);
    self.dates = [dates copy];
}

- (void)configOtherWithRecordRef:(ABRecordRef)recordRef {
    
    /** 获取头像 */
    if (ABPersonHasImageData(recordRef)) {
        //开始获得头像信息
        self.thumbnailImageData = CFBridgingRelease(ABPersonCopyImageDataWithFormat(recordRef, kABPersonImageFormatThumbnail));
        self.imageData = CFBridgingRelease(ABPersonCopyImageDataWithFormat(recordRef, kABPersonImageFormatOriginalSize));
        self.imageDataAvailable = YES;
    }

    self.note = [NSString contactStringForProperty:kABPersonNoteProperty
                                     withRecordRef:recordRef];
}

- (NSArray<XMNLabeledValue *> *)labeledValuesWithProperty:(ABPropertyID)property
                                                recordRef:(ABRecordRef)recordRef {
    
    ABMultiValueRef values = ABRecordCopyValue(recordRef, property);
    NSMutableArray<XMNLabeledValue *> *labeledValues = [NSMutableArray arrayWithCapacity:ABMultiValueGetCount(values)];
    
    for (int i = 0; i < ABMultiValueGetCount(values); i ++) {
        
        NSString *localizedLabel = (__bridge NSString *)(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(values, i)));
        id value;
        if (property == kABPersonPhoneProperty) {
            
            value = [XMNPhoneNumber phoneNumberWithStringValue:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(values, i))];
        }else if (property == kABPersonEmailProperty || property == kABPersonURLProperty || property == kABPersonRelatedNamesProperty) {
            
            value = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(values, i));
        }else if (property == kABPersonAddressProperty) {

            NSDictionary *dictionary = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(values, i);
            if (!dictionary) {
                continue;
            }
            value =  [[XMNPostalAddress alloc] initWithDictionary:dictionary];
        }else if (property == kABPersonSocialProfileProperty) {
            
            NSDictionary *dictionary = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(values, i);
            if (!dictionary) {
                continue;
            }
            value = [[XMNSocialProfile alloc] initWithService:[dictionary objectForKey:kABPersonSocialProfileServiceKey]
                                                     username:[dictionary objectForKey:kABPersonSocialProfileUsernameKey]
                                               userIdentifier:[dictionary objectForKey:kABPersonSocialProfileUserIdentifierKey]
                                                    urlString:[dictionary objectForKey:kABPersonSocialProfileURLKey]];
        }else if (property == kABPersonInstantMessageProperty) {
            
            NSDictionary *dictionary = (__bridge NSDictionary *)ABMultiValueCopyValueAtIndex(values, i);
            if (!dictionary) {
                continue;
            }
            value = [[XMNInstantMessageAddress alloc] initWithService:[dictionary objectForKey:kABPersonInstantMessageServiceKey]
                                                             username:[dictionary objectForKey:kABPersonInstantMessageUsernameKey]];
        }else {
            continue;
        }
        
        if (value && localizedLabel) {
            XMNLabeledValue *labeledValue = [XMNLabeledValue labeledValueWithLabel:localizedLabel
                                                                             value:value];
            [labeledValues addObject:labeledValue];
        }else {
            continue;
        }
    }
    CFRelease(values);
    return [labeledValues copy];
}

@end

#endif


@implementation XMNContact

@end

