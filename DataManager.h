//
//  DataManager.h
//  ABC Shirt Co

@interface DataManager : NSObject

/** Returns singleton instance of DataManager */
+ (DataManager*) sharedInstance;

/** Returns number of items stored by DataManager */
- (int) getNumItems;

/** Returns item data at given index */
- (NSDictionary*) getItemAtIndex:(int)index;

@end
