
#import "SimpleTableViewAppDelegate.h"
#import "RootViewController.h"


@implementation SimpleTableViewAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
		
	/*
	 Create and configure the navigation and view controllers.
     */	
	
	RootViewController *rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
	
	// Retrieve the array of known time zone names, then sort the array and pass it to the root view controller.
	NSArray *timeZones = [NSTimeZone knownTimeZoneNames];
	rootViewController.timeZoneNames = [timeZones sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
		
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
	self.navigationController = aNavigationController;
	[aNavigationController release];
	[rootViewController release];
	
	// Configure and display the window.
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}



- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
