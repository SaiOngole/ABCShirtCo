//
//  DetailViewController.m
//  ABC Shirt Co
//

#import "DetailViewController.h"

#import "DemoManager.h"



@interface DetailViewController ()

@property (nonatomic, weak)     NSDictionary    *item;
@property (nonatomic)           int             itemIdx;

- (void)configureView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void) initViewWithItem:(NSDictionary *)item withIndex:(int)index
{
    self.item = item;
    self.itemIdx = index;
    
    [self configureView];
}

- (IBAction) onReservePressed:(id)sender
{
    // Show confirmation for the reservation
    [[DemoManager sharedInstance] addReservation:self.itemIdx];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reserved!"
                                                    message:@"Your item will be held and ready for you to try on when you arrive at the store."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)configureView
{
    // Update the user interface for the detail items
    self.imageView.image = [UIImage imageNamed:[self.item objectForKey:@"imagePath"]];
    self.labelName.text = [self.item objectForKey:@"name"];
    self.labelPrice.text = [self.item objectForKey:@"price"];
    self.textViewDescription.text = [self.item objectForKey:@"description"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

@end
