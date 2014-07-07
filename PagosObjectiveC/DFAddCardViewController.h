#import <UIKit/UIKit.h>

@class DFConekta;

@interface DFAddCardViewController : UIViewController{
    IBOutlet UITextField* nameField;
    IBOutlet UITextField* numberField;
    IBOutlet UITextField* cvcField;
    IBOutlet UITextField* monthExpField;
    IBOutlet UITextField* yearExpField;
    
    DFConekta* conekta;
}

@property(strong, nonatomic) UITextField* nameField;
@property(strong, nonatomic) UITextField* numberField;
@property(strong, nonatomic) UITextField* cvcField;
@property(strong, nonatomic) UITextField* monthExpField;
@property(strong, nonatomic) UITextField* yearExpField;
@property(strong, nonatomic) DFConekta* conekta;

- (IBAction)addCard:(id)sender;

@end
