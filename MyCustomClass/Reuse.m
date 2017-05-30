//
//  Reuse.m
//  Okler
//
//  Created by prem on 14/07/15.
//  Copyright (c) 2015 Pradeep Dahiya. All rights reserved.
//

#import "Reuse.h"
static Reuse *resuseObj = nil;
@implementation Reuse
+ (Reuse *)sharedInstance {
    
    @synchronized(self) {
        if (!resuseObj)
            [Reuse alloc];
    }
    return resuseObj;
}

+ (id)alloc {
    
    @synchronized(self) {
        NSAssert(resuseObj == nil, @"Attempted to allocate a second instance of a singleton LocationController.");
        resuseObj = [[super alloc] init];
    }
    return resuseObj;
}

- (NSString *)trim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] ;
}
- (BOOL)validateEmailID:(NSString *)string {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:string];
}
- (BOOL)validInt:(NSString *)textString
{
    if (!textString) {
        return NO;
    }
    
    BOOL valid = NO;
    // the following commentted line checks only for integer value.
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:textString];
    
    if ([textString length]) {
        valid = [alphaNums isSupersetOfSet:inStringSet];
    }
    return valid;

}

@end
