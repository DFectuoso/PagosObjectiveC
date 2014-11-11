#import "DFPaymentSummaryViewController.h"

#import "DFPaidViewController.h"

#import "DFConekta.h"
#import "DFClient.h"
#import "DFCard.h"
#import "DFCharge.h"
#import "DFPaymentServer.h"

@interface DFPaymentSummaryViewController ()

@end

@implementation DFPaymentSummaryViewController

@synthesize conekta, card, client, charge;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        charge = [[DFCharge alloc] init];
        
        charge.description = @"Test charge from iOS";
        charge.amount = @"50000";
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
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [referenceIdLabel setText:[charge referenceId]];
    [cardLabel setText:[NSString stringWithFormat:@"**** **** **** %@", card.last4]];

    [[self navigationController] setNavigationBarHidden:YES];
}

- (IBAction)confirmPayment:(id)sender{
    
    [conekta.paymentServer chargeCustomer:client withCard:card charge:charge withSuccess:^(DFCharge *newCharge) {
        dispatch_async(dispatch_get_main_queue(), ^{
            DFPaidViewController* c = [[DFPaidViewController alloc] init];
            c.charge = newCharge;
            [[self navigationController] pushViewController:c animated:YES];
        });
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

- (IBAction)cancelPayment:(id)sender{
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end