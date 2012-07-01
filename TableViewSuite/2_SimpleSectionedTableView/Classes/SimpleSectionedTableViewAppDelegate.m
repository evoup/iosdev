

#import "SimpleSectionedTableViewAppDelegate.h"
#import "RootViewController.h"
#import "Region.h"


@implementation SimpleSectionedTableViewAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize list;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Create the navigation and view controllers
	RootViewController *rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
	self.navigationController = aNavigationController;
	[aNavigationController release];
	[rootViewController release];
	
	[rootViewController setRegions:[Region knownRegions]];
	
	// Configure and display the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)dealloc {
	[navigationController release];
    [window release];
	[list release];
    [super dealloc];
}


@end

