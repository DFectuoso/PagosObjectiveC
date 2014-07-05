#import <UIKit/UIKit.h>

@interface DFSimplePaymentsExampleViewController : UIViewController{
    IBOutlet UITextField* nameField;
    IBOutlet UITextField* numberField;
    IBOutlet UITextField* cvcField;
    IBOutlet UITextField* monthExpField;
    IBOutlet UITextField* yearExpField;
}

@property(strong, nonatomic) UITextField* nameField;
@property(strong, nonatomic) UITextField* numberField;
@property(strong, nonatomic) UITextField* cvcField;
@property(strong, nonatomic) UITextField* monthExpField;
@property(strong, nonatomic) UITextField* yearExpField;

- (IBAction)makePayment:(id)sender;

@end
