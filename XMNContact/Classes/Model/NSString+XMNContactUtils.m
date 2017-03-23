//
//  NSString+XMNContactUtils.m
//  Pods
//
//  Created by XMFraker on 17/3/22.
//
//

#import "NSString+XMNContactUtils.h"

#if kContactsFrameworkAvailable

@implementation NSArray (XMNContacts)

/**
 获得联系人所有描述姓名键的便利方法
 
 @return 存放姓名描述姓名键的便利方法
 */
+ (NSArray <id <CNKeyDescriptor>> *)XMNContactNameKeys {
    
    return @[
             CNContactIdentifierKey,
#ifdef __IPHONE_10_0
             CNContactPhoneticOrganizationNameKey,
#endif
             CNContactNamePrefixKey,
             CNContactGivenNameKey,
             CNContactMiddleNameKey,
             CNContactFamilyNameKey,
             CNContactPreviousFamilyNameKey,
             CNContactNameSuffixKey,
             CNContactNicknameKey,
             CNContactPhoneticGivenNameKey,
             CNContactPhoneticMiddleNameKey,
             CNContactPhoneticFamilyNameKey
             ];
}


/**
 获取联系人默认键值描述
 
 所有姓名相关, 组织相关, 手机号, 邮箱, 头像
 @return 默认键值描述
 */
+ (NSArray <id <CNKeyDescriptor>> *)XMNContactDefaultKeys {
    
    return @[
             //identifier 标识符
             CNContactIdentifierKey,
             //type  类型
             CNContactTypeKey,
             
             //name 姓名相关
             CNContactNamePrefixKey,
             CNContactGivenNameKey,
             CNContactMiddleNameKey,
             CNContactFamilyNameKey,
             CNContactPreviousFamilyNameKey,
             CNContactNameSuffixKey,
             CNContactNicknameKey,
             
             //phonetic 姓名首字母
             CNContactPhoneticGivenNameKey,
             CNContactPhoneticMiddleNameKey,
             CNContactPhoneticFamilyNameKey,
             
             //number 手机号相关
             CNContactPhoneNumbersKey,
             
             //email  email相关
             CNContactEmailAddressesKey,
             
             //job    组织相关
             CNContactJobTitleKey,
             CNContactDepartmentNameKey,
             CNContactOrganizationNameKey,
#ifdef __IPHONE_10_0
             CNContactPhoneticOrganizationNameKey,
#endif
             
             ];
    
}

/**
 获得联系人所有描述所有键值方法
 
 @return 存放所有键值
 */
+ (NSArray <id <CNKeyDescriptor>> *)XMNContactAllKeys {
    
    return @[
             //identifier 标识符
             CNContactIdentifierKey,
             //type  类型
             CNContactTypeKey,
             
             //name 姓名相关
             CNContactNamePrefixKey,
             CNContactGivenNameKey,
             CNContactMiddleNameKey,
             CNContactFamilyNameKey,
             CNContactPreviousFamilyNameKey,
             CNContactNameSuffixKey,
             CNContactNicknameKey,
             
             //phonetic 姓名首字母
             CNContactPhoneticGivenNameKey,
             CNContactPhoneticMiddleNameKey,
             CNContactPhoneticFamilyNameKey,
             
             //number 手机号相关
             CNContactPhoneNumbersKey,
             
             //email  email相关
             CNContactEmailAddressesKey,
             
             //job    组织相关
             CNContactJobTitleKey,
             CNContactDepartmentNameKey,
             CNContactOrganizationNameKey,
#ifdef __IPHONE_10_0
             CNContactPhoneticOrganizationNameKey,
#endif
             
             
             //birthday  生日,日期相关
             CNContactBirthdayKey,
             CNContactNonGregorianBirthdayKey,
             CNContactDatesKey,
             
             //instantMessageAddresses 即时通讯账号
             CNContactInstantMessageAddressesKey,
             
             //relation  关系
             CNContactRelationsKey,
             
             //SocialProfiles 社交账号
             CNContactSocialProfilesKey,
             //网址信息配置
             CNContactUrlAddressesKey,
             ];
}

@end

#else

@implementation NSString (XMNAddressBook)

+ (NSString *)contactStringForProperty:(ABPropertyID)property
                         withRecordRef:(ABRecordRef)recordRef {
    
    return (__bridge NSString *)(ABRecordCopyValue(recordRef, property));
}

@end

@implementation NSDictionary (XMNAddressBook)

+ (NSDictionary *)contactDictionaryForProperty:(ABPropertyID)property
                                 withRecordRef:(ABRecordRef)recordRef {
    
    return  (__bridge NSDictionary *)(ABRecordCopyValue(recordRef, kABPersonAlternateBirthdayProperty));;
}

@end

@implementation NSDateComponents (XMNAddressBook)

+ (NSDateComponents *)contactDateComponentsForProperty:(ABPropertyID)property
                                              calendar:(NSCalendar *)calendar
                                         withRecordRef:(ABRecordRef)recordRef {
    
    NSDate * date = (__bridge NSDate *)(ABRecordCopyValue(recordRef, property));
    
    if (date) {
        return [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitEra | NSCalendarUnitTimeZone fromDate:date];
    }
    return nil;
}

+ (NSDateComponents *)contactDateComponentsForDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary) {
        return nil;
    }

    NSDateComponents *components = [[NSDateComponents alloc] init];
    /** 生日日历标识 */
    components.calendar = [NSCalendar calendarWithIdentifier:[dictionary objectForKey:kABPersonAlternateBirthdayCalendarIdentifierKey]];
    
    /** 公元纪年 */
    components.era = [[dictionary objectForKey:kABPersonAlternateBirthdayEraKey] integerValue];
    
    components.era = [[dictionary objectForKey:kABPersonAlternateBirthdayEraKey] integerValue];
    components.year = [[dictionary objectForKey:kABPersonAlternateBirthdayYearKey] integerValue];
    components.month = [[dictionary objectForKey:kABPersonAlternateBirthdayMonthKey] integerValue];
    components.day = [[dictionary objectForKey:kABPersonAlternateBirthdayDayKey] integerValue];
    components.leapMonth = [[dictionary objectForKey:kABPersonAlternateBirthdayIsLeapMonthKey] boolValue];
    
    return components;
}

+ (NSDateComponents *)contactDateComponentsForDate:(NSDate *)date {
    
    if (!date) {
        return nil;
    }
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitEra | NSCalendarUnitTimeZone fromDate:date];
}
#endif
@end
