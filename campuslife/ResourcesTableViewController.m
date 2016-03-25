//
//  ResourcesTableViewController.m
//  LCSC
//
//  Created by Computer Science on 2/8/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

#import "ResourcesTableViewController.h"
#import "WebViewViewController.h"
#import "SWRevealViewController.h"
#import "LCSC-swift.h"
#import "WarriorWebProfileViewController.h"

@interface ResourcesTableViewController ()
{
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@end

@implementation ResourcesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuButton.target = [self revealViewController];
    _menuButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:[[self revealViewController] panGestureRecognizer]];
    [self.view addGestureRecognizer:[[self revealViewController] tapGestureRecognizer]];
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"scriptExecuted"];
    Authentication* auth = [[Authentication alloc] init];
//    NSLog(@"%d and %d",[self checkProfile], (![auth userHaveEverBeenAtResourcesPage]));
    if ([self checkProfile] && ![auth userHaveEverBeenAtResourcesPage]){
        [auth setUserHaveEverBeenAtResourcesPage:@"true"];
        [self promptAlert:@"Your Profile is not set!" message:@"Some functions may not work.\nDo you want to set you profile now?"];
    }
}

- (BOOL)checkProfile{
    Authentication* auth = [[Authentication alloc] init];
    return [[auth getWarriorWebPassword] isEqualToString:@""] || [[auth getWarriorWebUsername] isEqualToString:@""] || [[auth getBlackBoardPassword] isEqualToString:@"" ] || [[auth getBlackBoardUsername] isEqualToString:@""];
}

- (void)promptAlert:(NSString *)title message:(NSString *)message{
    UIAlertView* alert = [[UIAlertView alloc] init];
    alert.title = title;
    alert.message = message;
    alert.delegate = self;
    [alert addButtonWithTitle:@"No"];
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ( buttonIndex == 1){
       [self performSegueWithIdentifier:@"Profile Alert" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Profile"]) {
        
    }
    else if([segue.identifier isEqualToString:@"Profile Alert"]){
    }
    else {
        WebViewViewController *dest = (WebViewViewController *)[segue destinationViewController];
        NSString *url, *title;
        if([segue.identifier  isEqualToString: @"LCSC"]) {
            url = @"http://www.lcsc.edu";
            title = @"LCSC";
        
        } else if([segue.identifier isEqualToString:@"Athletics"]) {
            url = @"http://www.lcwarriors.com";
            title = @"Warrior Athletics";
            
        } else if([segue.identifier isEqualToString:@"WarriorWeb"]) {
            url = @"https://warriorwebss.lcsc.edu/Student/Account/Login?ReturnUrl=%2fStudent%2fPlanning%2fDegreePlans";
            title = @"Warrior Web";
            
        } else if ([segue.identifier isEqualToString:@"LCMail"]) {
            url = @"https://accounts.google.com/AddSession?continue=https%3A%2F%2Faccounts.google.com%2Fb%2F0%2FAddMailService#identifier";
            title = @"LC Mail";
        } else if([segue.identifier isEqualToString:@"blackboard"]){
            url = @"https://lcsc.blackboard.com";
            title = @"BlackBoard";
        }
        [dest setUrl:[NSURL URLWithString:url]];
        [dest setTitle:title];
    }

}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/






- (IBAction)goBack:(id)sender {
    [self setTitle:@"Important Links 'n Shit"];
}


@end
