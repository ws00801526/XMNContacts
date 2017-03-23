//
//  XMNContact.h
//  Pods
//
//  Created by XMFraker on 17/3/21.
//
//

#import <Foundation/Foundation.h>
#import <XMNContact/XMNContactDefines.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - XMNLabeledValue

/**
 *  提供给contact使用, 具有标签,值的联系人属性
 *
 *  @discussion XMNLabeledValue 线程安全
 */
@interface XMNLabeledValue<ValueType : id <NSCopying, NSSecureCoding>> : NSObject <NSCopying, NSSecureCoding>

/** 标签 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)   NSString *label;
/** 标签对应的值 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly)   ValueType value;

/**
 初始化方法
 
 @param label 标签
 @param value 值
 @return XMNLabeledValue 实例
 */
- (instancetype)initWithLabel:(nullable NSString *)label
                        value:(ValueType)value;

/**
 初始化方法
 
 @param label 标签
 @param value 值
 @return XMNLabeledValue 实例
 */
+ (instancetype)labeledValueWithLabel:(nullable NSString *)label
                                value:(ValueType)value;

+ (NSString *)localizedStringForLabel:(NSString *)label;

@end

#pragma mark - XMNPhoneNumber

/** @abstract 实现手机号协议类,联系人手机号属性
 *  
 *  @discussion XMNPhoneNumber 线程安全
 **/
@interface XMNPhoneNumber : NSObject  <NSCopying, NSSecureCoding>

@property (copy, NS_NONATOMIC_IOSONLY, readonly)  NSString *stringValue;

/**
 初始化方法 根据给定的stringValue生成XMNPhoneNumber实例

 @param stringValue 给定的手机号字符串
 @return XMNPhoneNumber实例 or nil(stringValue = nil)
 */
- (nullable instancetype)initWithStringValue:(NSString *)stringValue;
+ (nullable instancetype)phoneNumberWithStringValue:(NSString *)stringValue;

@end

#pragma mark - XMNPostalAddress


/**
 *  @abstract   联系人地址属性
 *
 *  @discussion 线程安全
 */
@interface XMNPostalAddress : NSObject <NSCopying, NSSecureCoding>

/** 街道地址 多个街道地址 以分隔符"\n"分开*/
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *street;
/** 国家 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *country;
/** 国家ISO编号 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *ISOcountryCode;
/** 邮编 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *postalCode;
/** 州,省份 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *state;
/** 城市 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *city;

- (instancetype)initWithCountry:(nullable NSString *)country
                 ISOcountryCode:(nullable NSString *)ISOcountryCode
                          state:(nullable NSString *)state
                           city:(nullable NSString *)city
                         street:(nullable NSString *)street
                     postalCode:(nullable NSString *)postalCode;
#if kContactsFrameworkAvailable
- (instancetype)initWithPostalAddress:(CNPostalAddress *)postalAddress;
#else
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
#endif

@end

#pragma mark - XMNSocialProfile

/**
 *  @abstract   联系人社交账号属性
 *  例如Facebook,SinaWeibo,TencentWeibo,Twitter,LinkedIn等
 *  @discussion 线程安全
 */
@interface XMNSocialProfile : NSObject <NSCopying, NSSecureCoding>

/** 第三方社交账号服务类型 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *service;
/** 第三方服务账号用户名 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *username;
/** 第三方服务账号唯一标识 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *userIdentifier;
/** 第三方服务账号主页 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *urlString;

- (instancetype)initWithService:(nullable NSString *)service
                       username:(nullable NSString *)username
                 userIdentifier:(nullable NSString *)userIdentifier
                      urlString:(nullable NSString *)urlString;

#if kContactsFrameworkAvailable
- (instancetype)initWithSocialProfile:(CNSocialProfile *)socialProfile;
#endif

@end

#pragma mark - XMNInstantMessageAddress
/**
 *  @abstract   联系人即时联系方式属性
 *  例如QQ,Facebook,MSN,Yahoo等
 *  @discussion 线程安全
 */
@interface XMNInstantMessageAddress : NSObject <NSCopying, NSSecureCoding>

/** 即时通讯服务类型 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *service;
/** 即时通讯账号用户名 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable)  NSString *username;

- (instancetype)initWithService:(nullable NSString *)service
                       username:(nullable NSString *)username;

#if kContactsFrameworkAvailable
- (instancetype)initWithInstantMessageAddress:(CNInstantMessageAddress *)instantMessageAddress;
#endif

@end


@interface XMNContact : NSObject

#if kContactsFrameworkAvailable
/** 联系人的唯一标识符 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly)   NSString *identifier;
#else
/** 联系人的唯一标识符 */
@property (assign, NS_NONATOMIC_IOSONLY, readonly)   ABRecordID recordID;
#endif

/** 联系人类型 */
@property (assign, NS_NONATOMIC_IOSONLY, readonly) XMNContactType contactType;

/// ========================================
/// @name   姓名相关属性
/// ========================================

/** 姓名前缀 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *namePrefix;
/** 名字 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *givenName;
/** 中间名 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *middleName;
/** 姓氏 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *familyName;

/** 姓氏前缀 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *previousFamilyName;

/** 名字后缀 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *nameSuffix;
/** 昵称 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *nickname;

/** 姓名首字母 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *phoneticGivenName;
/** 中间名首字母 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *phoneticMiddleName;
/** 姓氏首字母 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *phoneticFamilyName;

/// ========================================
/// @name   公司相关信息
/// ========================================
/** 公司,组织名称 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *organizationName;
/** 公司部门 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *departmentName;
/** 公司职称 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *jobTitle;
/** 公司首字母 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *phoneticOrganizationName NS_AVAILABLE(10_12, 10_0);

/// ========================================
/// @name   日期相关属性
/// ========================================

/** 生日 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSDateComponents *birthday;
/** 其他类型日历生日, 农历,希伯来,阿拉伯等 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSDateComponents *nonGregorianBirthday;
/** 其他类型日期 纪念日,其他自定义标签等 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSArray<XMNLabeledValue<NSDateComponents *> *> *dates;


/// ========================================
/// @name   相关labeledValue
/// ========================================

/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSArray<XMNLabeledValue<XMNPhoneNumber *> *> *phoneNumbers;
/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSArray<XMNLabeledValue<NSString *> *> *emailAddresses;
/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSArray<XMNLabeledValue<XMNPostalAddress *> *> *postalAddresses;
/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSArray<XMNLabeledValue<NSString *> *> *urlAddresses;
/** 用户手机号 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSArray<XMNLabeledValue<NSString *> *> *contactRelations;

/** 社交账号 例如facebook,SinaWeibo,TencentWeibo,Twitter*/
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSArray<XMNLabeledValue<XMNSocialProfile*>*> *socialProfiles;
/** 即时通讯数据 如facebook,QQ,Wechat,Linkin */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSArray<XMNLabeledValue<XMNInstantMessageAddress*>*>   *instantMessageAddresses;

/// ========================================
/// @name   其他信息 -- 头像,备注
/// ========================================

/** 备注信息 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSString *note;
/** 头像图片数据 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSData *imageData;
/** 头像缩略图数据 */
@property (copy, NS_NONATOMIC_IOSONLY, readonly, nullable) NSData *thumbnailImageData;
/** 是否有可用头像 */
@property (assign, NS_NONATOMIC_IOSONLY, readonly) BOOL imageDataAvailable;

#if kContactsFrameworkAvailable
- (nullable instancetype)initWithContact:(CNContact *)contact;
#else
- (nullable instancetype)initWithRecordRef:(ABRecordRef)recordRef;
#endif

@end

#pragma mark - XMNContact Deprecated Method

@interface XMNContact (Deprecated)

#if kContactsFrameworkAvailable
- (instancetype)init DEPRECATED_MSG_ATTRIBUTE("use initWithContact: insteaded");
#else
- (instancetype)init DEPRECATED_MSG_ATTRIBUTE("use initWithRecordRef: insteaded");
#endif
@end
NS_ASSUME_NONNULL_END
