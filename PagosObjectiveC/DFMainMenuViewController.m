#import "DFMainMenuViewController.h"

#import "DFSimplePaymentsExampleViewController.h"
#import "DFAddOrSelectCardViewController.h"

#import "DFConekta.h"

@interface DFMainMenuViewController ()

@end

@implementation DFMainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationController] setNavigationBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO];
}

- (IBAction)simplePaymentMenuClickedBy:(id)sender{
    DFSimplePaymentsExampleViewController* c = [[DFSimplePaymentsExampleViewController alloc] init];
    [[self navigationController] pushViewController:c animated:YES];
}

- (IBAction)complexPaymentMenuClickedBy:(id)sender{
    DFAddOrSelectCardViewController* c = [[DFAddOrSelectCardViewController alloc] init];
    [[self navigationController] pushViewController:c animated:YES];
}

- (IBAction)clearSession:(id)sender{
    DFConekta* conekta = [[DFConekta alloc] initWithApiKey:PUBLIC_API_KEY];
    [conekta clearLocalClient];
    NSLog(@"Cleared");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
