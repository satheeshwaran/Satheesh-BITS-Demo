//
//  CXTYCoreDataHelper.h
//  FitNFine
//
//  Created by Satheeshwaran on 11/28/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXTYCoreDataHelper : NSObject

/**
 *  <#Description#>
 *
 *  @param helper <#helper description#>
 */
+ (void)setSharedHelper:(id)helper;
+ (instancetype)sharedHelper;
+ (instancetype)sharedHelperWithModelName:(NSString *)modelName;
- (instancetype)initWithModelName:(NSString *)mName;
- (void)createPersistentStoreCoordinator;
- (void)createManagedObjectContexts;
- (NSManagedObjectContext *)masterManagedObjectContext;
- (NSManagedObjectContext *)backgroundManagedObjectContext;
- (NSManagedObjectContext *)newManagedObjectContext;
- (void)saveContextToPersistentStore;
- (BOOL)checkAttributeWithAttributeName:(NSString *)attributeName InEntityWithEntityName:(NSString *)entityName ForPreviousItems:(NSString *)itemValue inContext:(NSManagedObjectContext *)context;

@end
