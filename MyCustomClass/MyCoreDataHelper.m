//
//  MyCoreDataHelper.m
//  imagetest
//
//  Created by t on 11/20/14.
//  Copyright (c) 2014 Thajmeel Ahmed. All rights reserved.
//

#import "MyCoreDataHelper.h"

@implementation MyCoreDataHelper

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
-(void)initCoreDataSetup
{
    [self saveContext];
}

- (NSURL *)applicationDocumentsDirectory
{
    // The directory the application uses to store the Core Data store file. This code uses a directory named "ICTC.Album" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:CoreDataFileName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",CoreDataFileName]];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext
{
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Method List
-(void)createEntity :(NSString *)entityName attributeInfo: (NSMutableDictionary *)columnInfo
{
   // NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
   // NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
  //  NSManagedObject *newManagedObject = [NSEntityDescription  insertNewObjectForEntityForName:entity inManagedObjectContext:_managedObjectContext];
}
-(NSMutableArray *)attributeName:(NSString *)tableName
{
    NSDictionary *attDic =[[NSDictionary alloc] init];
    NSMutableArray *attName=[[NSMutableArray alloc] init];
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:managedObjectContext];
    attDic = [entity attributesByName];
    for (NSString *key in attDic)
    {
        NSMutableDictionary *attributeDatadic = [[NSMutableDictionary alloc] init];
        NSAttributeDescription *attributeDesObj = [attDic objectForKey:key];
        [attributeDatadic setValue:key forKey:@"AttributeName"];
        [attributeDatadic setValue:[attributeDesObj attributeValueClassName] forKey:@"AttributeType"];
        [attName addObject:attributeDatadic];
    }
    return attName;
}

-(BOOL)insertValuesInTable:(NSString *)tableName datadic:(NSDictionary *) datadic
{
    _managedObjectContext =  [self managedObjectContext];
    NSManagedObject *newRow = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:_managedObjectContext];
    NSMutableArray *attributeName = [self attributeName:tableName];
    for (int i = 0; attributeName.count; i++)
    {
        id typeCasting =[[attributeName objectAtIndex:i] objectForKey:@"AttributeType"];
        if ([typeCasting isKindOfClass:[NSNumber class]])
        {
            
        }
        [newRow setValue:(id )[datadic objectForKey:[[attributeName objectAtIndex:i] objectForKey:@"AttributeName"]] forKey:[[attributeName objectAtIndex:i] objectForKey:@"AttributeName"]];
    }
    NSError *error=nil;
    if (![_managedObjectContext save:&error])
    {
        return false;
    }
    return true;
}

-(BOOL)deleteAllValuesInTable:(NSString *)tableName
{
    _managedObjectContext =  [self managedObjectContext];
    NSFetchRequest * allCars = [[NSFetchRequest alloc] init];
    [allCars setEntity:[NSEntityDescription entityForName:tableName inManagedObjectContext:_managedObjectContext]];
    [allCars setIncludesPropertyValues:NO];
    
    NSError * error = nil;
    NSArray * dataArray = [_managedObjectContext executeFetchRequest:allCars error:&error];
    for (NSManagedObject * data in dataArray)
    {
        [_managedObjectContext deleteObject:data];
    }
    
    NSError *saveError = nil;
    [_managedObjectContext save:&saveError];
    if (saveError!=nil)
    {
        return NO;
    }
    return YES;
}

-(BOOL)deleteOneRowFromTable:(NSString *)tableName predicateQuery:(NSString *) predicateQuery
{
    _managedObjectContext =  [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateQuery];
    NSError *error=nil;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray* results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject * singleRow in results)
    {
        [_managedObjectContext deleteObject:singleRow];
    }
    if (![_managedObjectContext save:&error])
    {
        return NO;
    }
    return YES;
}

-(BOOL)updateOneRowFromTable:(NSString *)tableName predicateQuery:(NSString *) predicateQuery dataDic:(NSMutableDictionary *)dataDic
{
    _managedObjectContext =  [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateQuery];
    NSError *error=nil;
    BOOL update=NO;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray* results = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject * updateRow in results)
    {
        for (NSString *key in dataDic)
        {
            [updateRow setValue:[dataDic objectForKey:key] forKey:key];
            update=YES;
        }
    }
    if (update)
    {
        if (![_managedObjectContext save:&error])
        {
            return NO;
        }
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)updateUserProfile :(NSMutableDictionary *)dataDic
{
    NSString *keyValue = nil;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"SecuUserProfile"] ;
    NSError *error = nil;
    
    for (NSString *key in dataDic)
    {
        keyValue =key;
        id value = [dataDic objectForKey:keyValue];
        NSArray *results = [context executeFetchRequest:request error:&error];
        for(NSManagedObject *curObject in results)
        {
            if ([value isKindOfClass:[NSNumber class]])
            {
                int intvalue =[(NSNumber *)value intValue];
                [curObject setValue:[NSNumber numberWithInt:intvalue] forKey:keyValue];
            }
            else if ([value isKindOfClass:[NSData class]])
            {
                [curObject setValue:value forKey:keyValue];
            }
            else
                [curObject setValue:[NSString stringWithFormat:@"%@",value] forKey:keyValue];
        }
        
        if (![context save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

-(NSMutableArray *)fetchAllData:(NSString *)tableName
{
    _managedObjectContext =  [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSError *error = nil;
    NSMutableArray *dataArray=[[NSMutableArray alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray* results = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(results !=0 )
    {
        [dataArray arrayByAddingObject:results];
        return dataArray;
    }
    return nil;
}



@end
