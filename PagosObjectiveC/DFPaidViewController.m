#import "DFPaidViewController.h"

#import "DFCharge.h"

@interface DFPaidViewController ()

@end

@implementation DFPaidViewController

@synthesize charge;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [confirmationLabel setText:charge.conektaId];
}

- (IBAction)backToMainMenu:(id)sender{
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
