#import <UIKit/UIKit.h>

@class DFConekta;
@class DFCard;
@class DFClient;
@class DFCharge;

@interface DFPaymentSummaryViewController : UIViewController{
    DFConekta* conekta;
    DFClient* client;
    DFCard* card;
    DFCharge* charge;
    
    IBOutlet UILabel* referenceIdLabel;
    IBOutlet UILabel* cardLabel;
}

@property(nonatomic, strong) DFConekta* conekta;
@property(nonatomic, strong) DFClient* client;
@property(nonatomic, strong) DFCard* card;
@property(nonatomic, strong) DFCharge* charge;

- (IBAction)confirmPayment:(id)sender;
- (IBAction)cancelPayment:(id)sender;

@end
