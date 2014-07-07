#import <UIKit/UIKit.h>

@class DFClient;
@class DFConekta;

@interface DFAddOrSelectCardViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView* cardsTableView;
    DFClient* localClient;
    DFConekta* conekta;
    
}

@property(nonatomic, strong) UITableView* cardsTableView;
@property(nonatomic, strong) DFConekta* conekta;
@property(nonatomic, strong) DFClient* localClient;

- (IBAction)addCardButtonPressedBy:(id)sender;

@end
