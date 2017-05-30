//
//  historyModel.m
//  Patient
//
//  Created by Alok Singh on 5/20/16.
//  Copyright © 2016 mithun ravi. All rights reserved.
//

#import "historyModel.h"

@implementation historyModel

static historyModel* _sharedhistoryModel = nil;

+(historyModel*)sharedhistoryModel
{
    @synchronized([historyModel class])
    {
        if (!_sharedhistoryModel)
            _sharedhistoryModel = [[self alloc] init];
        
        return _sharedhistoryModel;
    }
    
    return nil;
}



@end
