//
//  MFJSInterfaceProtocol.h
//  MonacaFramework
//
//  Created by Katsuya Saitou on 13/01/21.
//  Copyright (c) 2013年 ASIAL CORPORATION. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFJSInterfaceProtocol : NSURLProtocol

+ (NSString *)buildLog:(NSURLRequest *)request;

@end
