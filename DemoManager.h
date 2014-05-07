//
//  DemoManager.h
//  ABC Shirt Co
//


@interface DemoManager : NSObject

/** Returns singleton instance of DemoManager */
+ (DemoManager*) sharedInstance;

/** Currently displaying the view controller spawned from tapping a beacon */
@property (nonatomic) BOOL showingTapView;

/** User has received a notification about his/her clothing reservation */
@property (nonatomic) BOOL notifiedAboutReservations;

/** Add an item to the user's reservation list */
- (void) addReservation:(int)itemIdx;

//Intialize the Nomi SDK


@end
