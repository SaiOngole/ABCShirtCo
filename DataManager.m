//
//  DataManager.m
//  ABC Shirt Co


#import "DataManager.h"

@interface DataManager ()

@property (nonatomic, strong) NSArray *itemsArray;

@end

@implementation DataManager

+ (DataManager*) sharedInstance
{
    static DataManager *sharedInst = nil;
    static dispatch_once_t onceToken;
    
    // Tell GCD to initialize the shared instance only one time
    dispatch_once(&onceToken, ^{
        sharedInst = [[self alloc] init];
    });
    
    return sharedInst;
}

- (id) init
{
    // Path to item data file
    NSString* path = [[NSBundle mainBundle] pathForResource: @"items" ofType: @"plist"];
    
    NSPropertyListFormat format;
    NSString* errorDesc = nil;
    
    // Load data from plist 
    NSData* plistXML = [[NSFileManager defaultManager] contentsAtPath:path];
    
    // Parse item data and store
    self.itemsArray = (NSArray*)[NSPropertyListSerialization
                                 propertyListFromData:plistXML
                                 mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                 format:&format
                                 errorDescription:&errorDesc];
    
    return self;
}

- (int) getNumItems
{
    return (int)[self.itemsArray count];
}

- (NSDictionary*) getItemAtIndex:(int)index
{
    return [self.itemsArray objectAtIndex:index];
}

@end
