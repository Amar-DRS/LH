//
//  NSObject+AllowAnyRequest.m
//  LearningHouse
//
//  Created by Apple on 16/12/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "NSObject+AllowAnyRequest.h"

@implementation NSObject (AllowAnyRequest)


+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*) host
{
    return YES;
}
@end
