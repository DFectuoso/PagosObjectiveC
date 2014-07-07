#import <UIKit/UIKit.h>

@class DFCharge;

@interface DFPaidViewController : UIViewController{
    DFCharge* charge;
    
    IBOutlet UILabel* confirmationLabel;
}

@property(nonatomic, strong) DFCharge* charge;

- (IBAction)backToMainMenu:(id)sender;

@end
