#import "DFSimplePaymentsExampleViewController.h"

#import "DFCharge.h"
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
    NSLog(@"Starting to make a Payment in the View Controller");
    
    DFConekta* conekta = [[DFConekta alloc] initWithApiKey:@"Qfw4ZozppXFtvDqaUdt1"];

    DFCard* card = [[DFCard alloc] init];
    
    card.name = nameField.text;
    card.number = numberField.text;
    card.monthExp = monthExpField.text;
    card.yearExp = yearExpField.text;
    card.cvc = cvcField.text;

    DFCharge* charge = [[DFCharge alloc] init];

    charge.description = @"Test charge from iOS";
    charge.amount = @"5000";
    charge.currency = @"MXN";
    
    // Random string
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:20];
    for (NSUInteger i = 0U; i < 20; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    charge.referenceId = s;
    
    [conekta simpleCharge:card charge:charge withSuccess:^(DFCharge *charge) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cargo realizado"
                                                        message:[NSString stringWithFormat:@"Referencia: %@", [charge conektaId]]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
            [alert show];
        });
        NSLog(@"Succesfully charged:%@", charge);
    } fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cargo invalido"
                                                        message:[NSString stringWithFormat:@"Error: %@", [error userInfo]]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
            [alert show];
        });

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
