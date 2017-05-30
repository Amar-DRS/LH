//
//  NSObject+AllowAnyRequest.h
//  LearningHouse
//
//  Created by Apple on 16/12/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AllowAnyRequest)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*) host;

@end
