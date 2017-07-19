//
//  UtilTools.h
//  xiaoyixiu
//
//  Created by 赵岩 on 16/6/14.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <UIKit/UIKit.h>

@interface UtilTools : NSObject


#pragma mark   判空方法
/**
 *  判断字符串是否为空
 *
 *  @param string 传入要判断的字符串
 *
 *  @return 返回的bool值为YES则为空
 */
+ (BOOL)isBlankString:(id)string;

/**
 *  判断数组是否为空
 *
 *  @param array 传入要判断的数组
 *
 *  @return 返回的bool值为YES则为空
 */
+ (BOOL)isBlankArray:(NSArray *)array;

/**
 *  身份证判断
 *
 *  @param identityCard 身份证
 *
 *  @return YES 身份证合法
 */
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

/**
 *  邮箱判断
 *
 *  @param email 邮箱
 *
 *  @return YES 邮箱合法
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  密码判断
 *
 *  @param password 密码
 *
 *  @return YES 密码合法
 */
+ (BOOL)password:(NSString *)password;



/**
 *  判断时间间隔是否超过1天，如果超过则静默登录
 *
 *  @param oneTime 上一次时间
 *  @param twoTime 现在时间
 *
 *  @return YES 静默登录
 */
+ (BOOL)isLogin:(NSString *)oneTime andTwoTime:(NSString *)twoTime;

/**
 *  判断字典是否为空
 *
 *  @param dictionary 传入要判断的字典
 *
 *  @return 返回的bool值为YES则为空
 */
+(BOOL)isBlankDictionary:(NSDictionary *)dictionary;

#pragma  mark   转换方法

//url转义
+(NSString *)URLEncodedString:(NSString *)string;

/**
 *  日期转换成倒计时字符串
 *
 *  @param aTimeString 日期
 *
 *  @return 日期转换的字符串
 */
+(NSString *)getNowTimeWithString:(NSString *)aTimeString;
/**
 *  日期转换成字符串
 *
 *  @param date 数组
 *
 *  @return 日期转换的字符串
 */
+ (NSString *)dateConvertToString:(NSDate *)date;
/**
 *  将图片转换成NSdata
 *
 *  @param image              要转换的image
 *  @param compressionQuality 压缩比例
 *
 *  @return 转换的NSdata
 */
+(NSData *)NSdataConvertToImage:(UIImage *)image compress:(CGFloat)compressionQuality;
/**
 *  压缩、裁剪图片
 *
 *  @param image 要转换的image
 *  @param size                转换完成的image

 *
 *  @return UIimage
 */
+ (UIImage *)cutImage:(UIImage*)image andSize:(CGSize)size;

/**
 *  caf转换成.mp3
 *
 *  @param array caf
 *
 *  @return 音频格式
 */

//+ (NSString *)toMp3:(NSString *)inputStringPath;
/**
 *  字典转成NSString
 *
 *  @param dic 要转换的字典
 *
 *  @return NSString
 */
+(NSString *)jsonString:(NSDictionary *)dic;


/**
 *  数组转换成字符串
 *
 *  @param array 数组
 *
 *  @return 数组转换的字符串
 */
+ (NSString *)arrayConvertToString:(NSArray *)array;


/**
 *  字符串转换成数组
 *
 *  @param string 字符串
 *
 *  @return 字符串转换成的数组
 */
+ (NSArray *)stringConvertToArray:(NSString *)string;


/**
 *  获取相差的天数
 *
 *  @return 获取相差的天数
 */
+ ( int)getDifferenceNumberDays:(NSString *)format dataString:(NSString*)dataString;
/**
 *  把时间戳转换成日期
 *
 *  @param dateLine 时间戳
 *  @param format   所要转换日期的格式（YYYY:MM:dd-HH:mm:ss）
 *
 *  @return 日期
 */
+ (NSString *)getDateFromDateLine:(NSString *)dateLine format:(NSString *)format;
/**
 *  获取当前时区的时间
 *
 *  @return 当前时区的时间
 */
+ (NSString *)getCurrentDate2:(NSString *)format;
/**
 *  将NSDate转换成NSString
 *
 *  @param date NSDate
 *
 *  @return NSString
 */
+(NSString*)stringFromDate:(NSDate*)date;

/**
 *  将NSData转换成NSString
 *
 *  @param data NSData
 *
 *  @return NSString
 */
+(NSString*)stringFromData:(NSData*)data;
/**
 *  计算文本的高度
 *
 *  @param text  文本
 *  @param width 固定宽度
 *  @param font  文本字体
 *
 *  @return 文本的高度
 */
+ (CGSize)getTextHeight:(NSString *)text width:(CGFloat)width font:(UIFont *)font;
/**
 *  计算文本的大小
 *
 *  @param text  文本
 *  @param hight 固定高度

 *  @param font  文本字体
 *
 *  @return 文本的大小
 */

+ (CGSize)getTextHeight:(NSString *)text hight:(CGFloat)hight font:(UIFont *)font;


/**
 *  计算textView的宽度
 *
 *  @param text  textView的内容
 *  @param font  textView的字体
 *  @param width textView的高度
 *
 *  @return textView的宽度
 */
+ (CGFloat)getTextViewHeight:(NSString *)text font:(UIFont*)font width:(CGFloat)width;
/**
 *  获取当前的时间戳
 *
 *  @return 时间戳
 */


+(NSString *)intervalSinceNow: (NSString *) theDate;

#pragma  mark  封装方法
 //检测是否安装qq
+(BOOL)haveQQ;
//检测是否安装微信
+(BOOL)haveWeiXin;
//获取一个随机整数，范围在[from,to），包括from，包括to
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 *  刷新UITableView指定cell
 *
 *  @param tableview UITableView
 *  @param interger  NSInteger
 */
+(void)refresh:(UITableView *)tableview Integer:(NSInteger)interger;
/**
 *  打电话
 *
 *  @param phoneAccount 手机号
 *
 *  @return UIWebView
 */
+ (UIWebView *)call:(NSString *)phoneAccount;


/**
 *  获取用户昵称
 *
 *  @param rootUser rootUser
 *
 *  @return  用户的昵称
 */
//+(NSString *)stringFrom:(id)rootUser;

/**
 *  获取用户头像
 *
 *  @param phone 好友账号
 *
 *  @return 好友的头像
 */
//+(NSString *)headImageFromPhone:(NSString *)phone;

/**
 *  获取好友名字
 *
 *  @param phone 好友账号
 *
 *  @return 好友名字
 */
//+(NSString *)nameFromPhone:(NSString *)phone;

/**
 *  获取视频封面
 *
 *  @param videoURL 视频url
 *
 *  @return 视频封面
 */
+(UIImage*)thumbnailImageForVideo:(NSURL *)videoURL;
/**
 *  封装播放声音的方法
 *
 *  @param filename 文件名
 *  @param filetype 文件类型
 */
+(void)PlaySoundFilename:(NSString *)filename FileType:(NSString *)filetype;
/**
 *  停止播放声音
 */
+(void)StopPlaySound;
/*
 震动方法
 */
+(void)vibrate;

/**
 *  获取扫描区域的比例关系
 *
 *  @param rect             设置扫描区域
 *  @param readerViewBounds 设置被扫描区域的Bounds
 *
 *  @return 返回区域
 */
+(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds;


#pragma mark 加密算法
+ (NSString *) encode:(NSString *)str key:(NSString *)key;

+ (NSString *) decode:(NSString *)str key:(NSString *)key;

#pragma mark 获取当前视图控制器
+ (UIViewController *)getCurrentVC;

#pragma mark - 获取字符串的字符数
+ (NSInteger)characterCountOfStr:(NSString *)str;



@end
