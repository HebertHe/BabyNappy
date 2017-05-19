//
//  CommUtil.m
//  jdmobile
//
//  Created by Hebert on 2017/3/17.
//  Copyright © 2017年 SYETC02. All rights reserved.
//  常用工具类
//

#import "CommUtil.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation CommUtil

/**
 根据毫秒数转换为 yyyy-MM-dd 日期
 
 @param dateCount 毫秒数
 @return string
 */
+ (NSString *)dateConvertWithTimeInterval:(NSInteger)dateCount {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:dateCount];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr=[dateFormater stringFromDate:date];
    return dateStr?dateStr:@"";
}


/**
 根据毫秒数转换为 yyyy-MM-dd HH:mm:ss 日期
 
 @param dateCount 毫秒数
 @return string
 */
+ (NSString *)dateTimeConvertWithTimeInterval:(NSInteger)dateCount {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:dateCount];
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr=[dateFormater stringFromDate:date];
    return dateStr?dateStr:@"";
}

/**
 根据毫秒数转换为几天前 日期
 
 @param dateCount 毫秒数
 @return string
 */
+ (NSString *)dateHadelWithTimeInterval:(NSInteger)dateCount {
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:dateCount/1000];
    return [self dateHandelString:date];
}

/**
 日期转换 为 yyyy-MM-dd 字符串
 
 @param date 日期
 @return  string
 */
+ (NSString *)dateConvertString:(NSDate *)date {
    if (date) {
        NSDateFormatter *dateFormater=[[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr=[dateFormater stringFromDate:date];
        return dateStr?dateStr:@"";
    }
    return @"";
}

/**
 时间处理
 
 @param date 日期
 @return  string
 */
+ (NSString *)dateHandelString:(NSDate *)date {
    if (date) {
        NSDate *currentDate = [NSDate date];
        NSTimeZone *timezone = [NSTimeZone systemTimeZone];
        NSInteger timeZoneInterval=[timezone secondsFromGMTForDate:currentDate];
        NSDate *localdate=[currentDate dateByAddingTimeInterval:timeZoneInterval];
        NSTimeInterval interval = [date timeIntervalSinceDate:localdate];
        interval = -interval;
        long temp = 0;
        if (interval < 60) {
            return [NSString stringWithFormat:@"%0.f秒前",interval];
        }
        else if ((temp = interval / 60) < 60){
            return [NSString stringWithFormat:@"%ld分前",temp];
        }
        else if ((temp = temp / 60) < 24){
            return [NSString stringWithFormat:@"%ld小时前",temp];
        }
        else if ((temp = temp / 24) < 30){
            return [NSString stringWithFormat:@"%ld天前",temp];
        }
        else {
            return [self dateConvertString:date];
        }
    }
    return @"";
}

#pragma mark - 对象为 NSNull 处理

/**
 *  对象 Null处理
 *
 *  @param object 对象
 *
 *  @return 为 null 返回空字符串 否则不处理
 */
+(id)isNullObject:(id)object
{
    return ([object isEqual:[NSNull null]]||!object)?@"":object;
}

/**
 *  对象 null 值处理
 *
 *  @param object 对象
 *
 *  @return 为 null 时返回 0 否则不处理
 */
+(NSNumber *)isNullNumber:(id)object
{
    return ([object isEqual:[NSNull null]]||!object)?@0:object;
}

/**
 *  检查手机号是否合法
 */
+ (BOOL)checkIfPhoneNumberIsSuit:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";;
    
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phonePredicate evaluateWithObject:phoneNumber];
    
}

/**
 MD5加密
 
 @param string 要加密的字符串
 @return 加密字符串
 */
+(NSString *)stringToMD5:(NSString *)string {
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [string UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}

@end


@implementation UIColor (Util)

/**
 根据颜色值生成图片
 
 @return 图片
 */
- (UIImage *)colorToImage {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 根据颜色值生成图片
 
 @param size  size
 @return 图片
 */
- (UIImage *)colorToImageSized:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
