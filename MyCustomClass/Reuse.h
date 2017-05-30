

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Reuse : NSObject
{
    
}
+ (Reuse *)sharedInstance;
- (BOOL)validInt:(NSString *)textString;
- (NSString *)trim:(NSString *)string;
- (BOOL)validateEmailID:(NSString *)string;
@end
