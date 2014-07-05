#import "DFSimplePaymentsExampleViewController.h"

#import "DFPayment.h"
#import "DFConekta.h"
#import "DFCard.h"

@interface DFSimplePaymentsExampleViewController ()

@end

@implementation DFSimplePaymentsExampleViewController

@synthesize nameField, numberField, monthExpField, yearExpField, cvcField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)makePayment:(id)sender{
    
    /*
    DFConekta* conekta = [[DFConekta alloc] initWithApiKey:@"key_EVryd61Uhsq9d6Z2"]

    DFCard* card = [[DFCard alloc] init];
    card.name = nameField.text;
    card.number = numberField.text;
    card.expMonth = expMonthField.text;
    card.expYear = expYearField.text;
    card.cvc = ccField.text;

    DFPayment* payment = [[DFPayment alloc] init];
    */

//    [conekta chargeCard:card withPayment:payment withSuccess: and Failure: ]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
