//
//  CardScore500AppDelegate.m
//  CardScore500
//
//  Created by Joe Bonniwell on 9/30/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "CardScore500AppDelegate.h"

@implementation CardScore500AppDelegate

#pragma mark -
#pragma mark Application lifecycle

+(void)initialize
{
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *pListPath = [path stringByAppendingPathComponent:@"Settings.bundle/Root.plist"];
	NSDictionary *pList = [NSDictionary dictionaryWithContentsOfFile:pListPath];
	NSMutableArray *prefsArray = [pList objectForKey:@"PreferenceSpecifiers"];
	NSMutableDictionary *regDictionary = [NSMutableDictionary dictionary];
	for (NSDictionary *dict in prefsArray)
	{
		NSString *key = [dict objectForKey:@"Key"];
		if (key)
		{
			id value = [dict objectForKey:@"DefaultValue"];
			[regDictionary setObject:value forKey:key];
		}
	}
	[[NSUserDefaults standardUserDefaults] registerDefaults:regDictionary];	
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{   
	// GamesViewController
    GamesViewController *mainGamesViewController = [[GamesViewController alloc] init];
	[mainGamesViewController setManagedObjectContext:[self managedObjectContext]];
	[self setGamesViewController:mainGamesViewController];
	[mainGamesViewController release];
	// NavigationController
	UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:[self gamesViewController]];
	[[mainNavigationController navigationBar] setTintColor:[UIColor brownColor]];
	[self setNavigationController:mainNavigationController];
	[mainNavigationController release];
	// Window
	[window addSubview:[[self navigationController] view]];
    [window makeKeyAndVisible];
	// Settings
	gFirstRun = NO;
	// Get current version ("Bundle Version") from the default Info.plist file
	NSString *currentVersion = (NSString*)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
	NSArray *prevStartupVersions = [[NSUserDefaults standardUserDefaults] arrayForKey:@"prevStartupVersions"];
	if (prevStartupVersions == nil) 
	{
		// Starting up for first time with NO pre-existing installs (e.g., fresh install of some version)
		gFirstRun = YES;
		[[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:currentVersion] forKey:@"prevStartupVersions"];
	}
	else
	{
		if (![prevStartupVersions containsObject:currentVersion]) 
		{
			// Starting up for first time with this version of the app. This means a different version of the app was alread installed once and started.
			NSMutableArray *updatedPrevStartVersions = [NSMutableArray arrayWithArray:prevStartupVersions];
			[updatedPrevStartVersions addObject:currentVersion];
			[[NSUserDefaults standardUserDefaults] setObject:updatedPrevStartVersions forKey:@"prevStartupVersions"];
		}
	}
	// Save changes to disk
	[[NSUserDefaults standardUserDefaults] synchronize];
	// Import Settings
	gEnableMisdeals = [[NSUserDefaults standardUserDefaults] boolForKey:@"enableMisdeals"];
	gPlaySixBids = [[NSUserDefaults standardUserDefaults] boolForKey:@"playSixBids"];
	g8SpadesOutbidsNula = [[NSUserDefaults standardUserDefaults] boolForKey:@"eightSpadesOutbidsNula"];
	gEnableSlams = [[NSUserDefaults standardUserDefaults] boolForKey:@"enableSlams"];
	gRequireBidPointsForWin = [[NSUserDefaults standardUserDefaults] boolForKey:@"requireBidPointsForWin"];
	gEnableNegativeScoreLoss = [[NSUserDefaults standardUserDefaults] boolForKey:@"enableNegativeScoreLoss"];
	gEnableTournamentMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"enableTournamentMode"];
	gTournamentModeNumberOFHands = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfHands"];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application 
{
	[[NSUserDefaults standardUserDefaults] setBool:gEnableMisdeals forKey:@"enableMisdeals"];
	[[NSUserDefaults standardUserDefaults] setBool:gPlaySixBids forKey:@"playSixBids"];
	[[NSUserDefaults standardUserDefaults] setBool:g8SpadesOutbidsNula forKey:@"eightSpadesOutbidsNula"];
	[[NSUserDefaults standardUserDefaults] setBool:gEnableSlams	forKey:@"enableSlams"];
	[[NSUserDefaults standardUserDefaults] setBool:gRequireBidPointsForWin forKey:@"requireBidPointsForWin"];
	[[NSUserDefaults standardUserDefaults] setBool:gEnableNegativeScoreLoss	forKey:@"enableNegativeScoreLoss"];
	[[NSUserDefaults standardUserDefaults] setBool:gEnableTournamentMode forKey:@"enableTournamentMode"];
	[[NSUserDefaults standardUserDefaults] setInteger:gTournamentModeNumberOFHands forKey:@"numberOfHands"];	
	[[NSUserDefaults standardUserDefaults] synchronize];
    [self saveContext];
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
    [[NSUserDefaults standardUserDefaults] synchronize];
	gEnableMisdeals = [[NSUserDefaults standardUserDefaults] boolForKey:@"enableMisdeals"];
	gPlaySixBids = [[NSUserDefaults standardUserDefaults] boolForKey:@"playSixBids"];
	g8SpadesOutbidsNula = [[NSUserDefaults standardUserDefaults] boolForKey:@"eightSpadesOutbidsNula"];
	gEnableSlams = [[NSUserDefaults standardUserDefaults] boolForKey:@"enableSlams"];
	gRequireBidPointsForWin = [[NSUserDefaults standardUserDefaults] boolForKey:@"requireBidPointsForWin"];
	gEnableNegativeScoreLoss = [[NSUserDefaults standardUserDefaults] boolForKey:@"enableNegativeScoreLoss"];
	gEnableTournamentMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"enableTournamentMode"];
	gTournamentModeNumberOFHands = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfHands"];
}

- (void)applicationWillTerminate:(UIApplication *)application 
{
	[[NSUserDefaults standardUserDefaults] setBool:gEnableMisdeals forKey:@"enableMisdeals"];
	[[NSUserDefaults standardUserDefaults] setBool:gPlaySixBids forKey:@"playSixBids"];
	[[NSUserDefaults standardUserDefaults] setBool:g8SpadesOutbidsNula forKey:@"eightSpadesOutbidsNula"];
	[[NSUserDefaults standardUserDefaults] setBool:gEnableSlams	forKey:@"enableSlams"];
	[[NSUserDefaults standardUserDefaults] setBool:gRequireBidPointsForWin forKey:@"requireBidPointsForWin"];
	[[NSUserDefaults standardUserDefaults] setBool:gEnableNegativeScoreLoss	forKey:@"enableNegativeScoreLoss"];
	[[NSUserDefaults standardUserDefaults] setBool:gEnableTournamentMode forKey:@"enableTournamentMode"];
	[[NSUserDefaults standardUserDefaults] setInteger:gTournamentModeNumberOFHands forKey:@"numberOfHands"];	
	[[NSUserDefaults standardUserDefaults] synchronize];
    [self saveContext];
}

- (void)saveContext 
{
    NSError *error = nil;
    if (managedObjectContext_ != nil) 
	{
        if ([managedObjectContext_ hasChanges] && ![managedObjectContext_ save:&error]) 
		{
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext*)managedObjectContext 
{
    if (managedObjectContext_ != nil) 
	{
        return managedObjectContext_;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) 
	{
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel 
{
    if (managedObjectModel_ != nil) 
	{
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"CardScore500" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator 
{
    if (persistentStoreCoordinator_ != nil) 
	{
        return persistentStoreCoordinator_;
    }
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"CardScore500.sqlite"]];
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    return persistentStoreCoordinator_;
}

#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory 
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc 
{
	[gamesViewController release];
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    [window release];
    [super dealloc];
}

@synthesize gamesViewController;
@synthesize navigationController;
@synthesize window;
@end

