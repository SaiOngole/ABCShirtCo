//
//  DemoManager.m
//  ABC Shirt Co
//

#import "DemoManager.h"

#import <NomiBeaconSDK/NomiBeaconSDK.h>

#import "AppDelegate.h"
#import "TapViewController.h"

@interface DemoManager () <NomiBeaconManagerDelegate>

/** List of items currently reserved by the user */
@property (nonatomic, strong) NSMutableArray    *reservedList;

@end

@implementation DemoManager

+ (DemoManager*) sharedInstance
{
    static DemoManager *sharedInst = nil;
    static dispatch_once_t onceToken;
    
    // Tell GCD to initialize the shared instance only one time
    dispatch_once(&onceToken, ^{
        sharedInst = [[self alloc] init];
    });
    
    return sharedInst;
}

- (id) init
{
    self.reservedList = [[NSMutableArray alloc] init];
    self.showingTapView = NO;
    self.notifiedAboutReservations = NO;
    
    // Initialize Nomi SDK
    NomiBeaconManager *beaconManager = [NomiBeaconManager sharedInstance];
    [beaconManager setDelegate:self];
    //[beaconManager setNomiEnvironment:NOMI_SDK_DEV];
    [beaconManager startBeaconMonitoringWithAppID:@"S534408ebf1f70e14d526fcda" authKey:@"191b7e68b49795133f18a64f072ee9eb"];
        NSDictionary *userInfo = @{ @"user_id"  : @"nomi@suburban.com",
                                @"name"     : @"Nomi",
                                @"dob"      : @"10/22/13",
                                @"sex"      : @"male" };
    [beaconManager submitUserInfo:userInfo];
    
    return self;
}

- (void) addReservation:(int)itemIdx
{
    [self.reservedList addObject:[NSNumber numberWithInt:itemIdx]];
}

#pragma mark - NomiBeaconManagerDelegate protocol implementations

- (void)didEnterLocation:(NomiLocation*)location;
{
    // Make sure they reserved something
    NSString *message = ([self.reservedList count] > 0) ?
                            @"We have your reserved items waiting for you at the fitting rooms." :
                            @"Welcome to ABC Shirt Co. Check out our new collection.";

    
    // Send alert if app is active or local notification otherwise
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        // present local notification
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = message;
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
    
    // Clear list so we can do this again
    [self.reservedList removeAllObjects];
}

- (void)didExitLocation:(NomiLocation*)location afterTime:(NSTimeInterval)seconds;
{
    NSString *message = @"We at ABC Shirt Co. hope you found everything you were looking for. Come back soon to see our latest fashions!";
    
    //sending an alert if the user is there for 10 seconds
    if (location.stats.visits.count >= 1 && seconds > 10)
    {
        UILocalNotification *notification = [[UILocalNotification alloc] init]; notification.alertBody = @"Farewell"; notification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
    // Send alert if app is active or local notification otherwise
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank You!"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        // present local notification
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = message;
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}

- (void)didRangeBeacon:(NomiBeacon*)beacon inZone:(NomiZone*)zone;
{
    if (beacon.proximity == PROXIMITY_TAP && self.showingTapView == NO)
    {
        self.showingTapView = YES;
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        UIViewController *vc = [[appDelegate window] rootViewController];
        [vc performSegueWithIdentifier:@"tapView" sender:vc];
    }
}

@end
