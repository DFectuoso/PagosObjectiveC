#import "DFAddCardViewController.h"

#import "DFCard.h"
#import "DFConekta.h"
#import "DFPaymentServer.h"
#import "DFClient.h"

@interface DFAddCardViewController ()

@end

@implementation DFAddCardViewController

@synthesize nameField, numberField, monthExpField, yearExpField, cvcField, conekta;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)addCard:(id)sender{
    DFAddCardViewController* thisController = self;;
    
    DFCard* card = [[DFCard alloc] init];
    
    card.name = nameField.text;
    card.number = numberField.text;
    card.monthExp = monthExpField.text;
    card.yearExp = yearExpField.text;
    card.cvc = cvcField.text;

    [conekta tokenizeCard:card withSuccess:^(DFToken *token) {
        [conekta.paymentServer addCardToken:token toClient:conekta.getLocalClient withSuccess:^(DFCard* card) {
            DFClient* localClient = thisController.conekta.getLocalClient;
            [[localClient cards] addObject:card];
            [thisController.conekta setLocalClient:localClient];

            dispatch_async(dispatch_get_main_queue(), ^{
                [thisController dismissViewControllerAnimated:YES completion:^{}];
            });

            
        } fail:^(NSError *error) {
            NSLog(@"There has been an error on payment server:%@",error);
        }];
    } fail:^(NSError *error) {
        NSLog(@"There has been an error:%@",error);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
