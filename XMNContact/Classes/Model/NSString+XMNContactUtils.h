//
//  NSString+XMNContactUtils.h
//  Pods
//
//  Created by XMFraker on 17/3/22.
//
//

#import <XMNContact/XMNContactDefines.h>

#if kContactsFrameworkAvailable

@interface  NSArray (XMNContacts)

/**
 获得联系人所有姓名键值描述
 
 @return 存放姓名描述键值
 */
+ (NSArray <id <CNKeyDescriptor>> *)XMNContactNameKeys;

/**
 获取联系人默认键值描述
 
 所有姓名相关, 组织相关, 手机号, 邮箱, 头像
 @return 默认键值描述
 */
+ (NSArray <id <CNKeyDescriptor>> *)XMNContactDefaultKeys;

/**
 获得联系人所有键值描述
 
 @return 所有键值描述
 */
+ (NSArray <id <CNKeyDescriptor>> *)XMNContactAllKeys;

@end

#else

@interface NSString (XMNAddressBook)

/**
 *  根据属性key获得NSString
 *
 *  @param property     属性key
 *  @param recordRef    引用对象
 *  @return 字符串的值
 */
+ (NSString *)contactStringForProperty:(ABPropertyID)property
                         withRecordRef:(ABRecordRef)recordRef;

@end


@interface NSDictionary (XMNAddressBook)

/**
 根据属性key 获取dictionary
 
 @param property    属性key
 @param recordRef   引用对象
 @return dictionary 对象
 */
+ (NSDictionary *)contactDictionaryForProperty:(ABPropertyID)property
                                 withRecordRef:(ABRecordRef)recordRef;

@end

@interface NSDateComponents (XMNAddressBook)

/**
 *  根据属性key获得NSDate
 *
 *  @param property     属性key
 *  @param calendar     日历
 *  @param recordRef    引用对象
 *  @return NSDate对象
 */
+ (NSDateComponents *)contactDateComponentsForProperty:(ABPropertyID)property
                                              calendar:(NSCalendar *)calendar
                                         withRecordRef:(ABRecordRef)recordRef;

+ (NSDateComponents *)contactDateComponentsForDictionary:(NSDictionary *)dictionary;

+ (NSDateComponents *)contactDateComponentsForDate:(NSDate *)date;

@end

#endif
