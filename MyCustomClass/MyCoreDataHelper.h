//
//  MyCoreDataHelper.h
//  imagetest
//
//  Created by t on 11/20/14.
//  Copyright (c) 2014 Thajmeel Ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MyCustomClass.h"

#define CoreDataFileName @"MyCore"

// Note:- You need to create .xcdatamodeld core datafile using add new file -> choose coredata option -> set any name -> create after that put the name of file in place of coreDataFileName.

@interface MyCoreDataHelper : NSObject
{
    
}
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void)saveContext;
-(NSURL *)applicationDocumentsDirectory;
-(void)initCoreDataSetup;

-(void)createEntity :(NSString *)entityName attributeInfo: (NSMutableDictionary *)columnInfo;
-(NSMutableArray *)attributeName:(NSString *)tableName;

-(BOOL)insertValuesInTable:(NSString *)tableName datadic:(NSDictionary *) datadic;
-(BOOL)deleteAllValuesInTable:(NSString *)tableName;
-(BOOL)deleteOneRowFromTable:(NSString *)tableName predicateQuery:(NSString *) predicateQuery;
-(BOOL)updateOneRowFromTable:(NSString *)tableName predicateQuery:(NSString *) predicateQuery dataDic:(NSMutableDictionary *)dataDic;
-(NSMutableArray *)fetchAllData:(NSString *)tableName;


@end
