//
//  CardScore500AppDelegate.h
//  CardScore500
//
//  Created by Joe Bonniwell on 9/30/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GamesViewController.h"
@interface CardScore500AppDelegate : NSObject <UIApplicationDelegate> 
{
    
    UIWindow *window;
    GamesViewController *gamesViewController;
	UINavigationController *navigationController;
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) GamesViewController *gamesViewController;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

@end

