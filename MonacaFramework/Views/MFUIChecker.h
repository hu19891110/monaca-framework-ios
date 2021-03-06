//
//  MFUIChecker.h
//  MonacaFramework
//
//  Created by yasuhiro on 13/05/23.
//  Copyright (c) 2013年 ASIAL CORPORATION. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFUIChecker : NSObject

+ (void)checkUI:(NSDictionary *)uidict;
+ (NSString *)valueType:(id)object;
+ (NSString *)dictionaryKeysToString:(NSDictionary *)dict;
+ (NSString *)arrayToString:(NSArray *)array;

@end

