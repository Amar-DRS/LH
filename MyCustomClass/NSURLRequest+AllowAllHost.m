//
//  NSURLRequest+AllowAllHost.m
//  LearningHouse
//
//  Created by Apple on 16/12/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "NSURLRequest+AllowAllHost.h"

@implementation NSURLRequest (AllowAllHost)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*) host
{
    return YES;
}
@end
