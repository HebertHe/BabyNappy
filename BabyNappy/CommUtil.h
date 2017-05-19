//
//  CommUtil.h
//  jdmobile
//
//  Created by Hebert on 2017/3/17.
//  Copyright © 2017年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CommUtil : NSObject
+ (NSString *)dateConvertWithTimeInterval:(NSInteger)dateCount;
+ (NSString *)dateHadelWithTimeInterval:(NSInteger)dateCount;
+ (NSString *)dateTimeConvertWithTimeInterval:(NSInteger)dateCount;
+ (NSString *)dateConvertString:(NSDate *)date;
+ (NSString *)dateHandelString:(NSDate *)date;
+(id)isNullObject:(id)object;
+(NSNumber *)isNullNumber:(id)object;
+(NSString *)stringToMD5:(NSString *)string;
+ (BOOL)checkIfPhoneNumberIsSuit:(NSString *)phoneNumber;
@end


@interface UIColor (Util)
- (UIImage *)colorToImage;
- (UIImage *)colorToImageSized:(CGSize)size;
@end
