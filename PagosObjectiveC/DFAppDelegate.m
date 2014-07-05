#import "DFAppDelegate.h"
#import "DFMainMenuViewController.h"

@implementation DFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    DFMainMenuViewController* vc = [[DFMainMenuViewController alloc] init];
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = nc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end