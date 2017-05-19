//
//  BaseModel.m
//  jdmobile
//
//  Created by Hebert on 2017/3/21.
//  Copyright © 2017年 SYETC02. All rights reserved.
//  基类 Model  建议所有 Model 继承该类
//

#import "BaseModel.h"

@implementation BaseModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return  YES;
}
@end
