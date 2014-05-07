//
//  DetailViewController.h
//  ABC Shirt Co
//

@interface DetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView    *imageView;
@property (nonatomic, weak) IBOutlet UIButton       *buttonReserve;
@property (nonatomic, weak) IBOutlet UIButton       *buttonAddToCart;
@property (nonatomic, weak) IBOutlet UILabel        *labelName;
@property (nonatomic, weak) IBOutlet UILabel        *labelPrice;
@property (nonatomic, weak) IBOutlet UITextView     *textViewDescription;

-(void) initViewWithItem:(NSDictionary*)item withIndex:(int)index;

- (IBAction) onReservePressed:(id)sender;

@end
