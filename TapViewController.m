//
//  TapViewController.m
//  ABC Shirt Co
//

#import "TapViewController.h"

#import "DemoManager.h"

@interface TapViewController ()

@end

@implementation TapViewController

- (IBAction) onOkayPressed:(id)sender
{
    // Dismiss the promotion
    [self dismissViewControllerAnimated:YES completion:^(void){
        [[DemoManager sharedInstance] setShowingTapView:NO];
    }];
}

@end
