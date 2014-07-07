#import "DFAddOrSelectCardViewController.h"

#import "DFAddCardViewController.h"
#import "DFPaymentSummaryViewController.h"

#import "DFConekta.h"
#import "DFClient.h"
#import "DFCard.h"

#import "DFPaymentServer.h"

@interface DFAddOrSelectCardViewController ()

@end

@implementation DFAddOrSelectCardViewController

@synthesize cardsTableView, localClient, conekta;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    conekta = [[DFConekta alloc] initWithApiKey:@"Qfw4ZozppXFtvDqaUdt1"];
    DFPaymentServer* paymentServer = [[DFPaymentServer alloc] initWithBaseUrl:@"http://127.0.0.1:3000"];
    
    [conekta setPaymentServer:paymentServer];
    
    localClient = [conekta getLocalClient];
    

    if (!localClient) {
        
        [conekta.paymentServer generateNewClientWithSuccess:^(DFClient *client) {

            [conekta setLocalClient:client];
            dispatch_async(dispatch_get_main_queue(), ^{
                DFAddCardViewController* c = [[DFAddCardViewController alloc] initWithNibName:@"DFAddCardViewController" bundle:nil];
                c.conekta = conekta;
                [[self navigationController] presentViewController:c animated:YES completion:^{
                    NSLog(@"Finished presenting");
                }];
            });
        } fail:^(NSError *error) {
            NSLog(@"There was an error:%@", error);
        }];
    } else {
        NSLog(@"We had a client");
    }
}

- (IBAction)addCardButtonPressedBy:(id)sender{
    DFAddCardViewController* c = [[DFAddCardViewController alloc] init];
    c.conekta = conekta;
    [self presentViewController:c animated:YES completion:^{
        [cardsTableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    localClient = [conekta getLocalClient];
    [cardsTableView reloadData];
}

#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [localClient.cards count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    DFCard* card = [localClient.cards objectAtIndex:indexPath.row];
	[[cell textLabel] setText:[NSString stringWithFormat:@"**** **** **** %@", card.last4]];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Selected [localClient.cards objectAtIndex:indexPath.row]
    
    DFPaymentSummaryViewController* c = [[DFPaymentSummaryViewController alloc] init];
    [c setCard:[localClient.cards objectAtIndex:indexPath.row]];
    [c setConekta:conekta];
    [c setClient:localClient];
    
    [[self navigationController] pushViewController:c animated:YES];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
