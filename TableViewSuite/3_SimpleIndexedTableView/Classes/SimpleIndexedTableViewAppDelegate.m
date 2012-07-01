
#import "SimpleIndexedTableViewAppDelegate.h"
#import "RootViewController.h"

#import "TimeZoneWrapper.h"


@implementation SimpleIndexedTableViewAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	// Create the navigation and view controllers.
	RootViewController *rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
	self.navigationController = aNavigationController;
	[rootViewController release];
	[aNavigationController release];
	
	/*
	 Create an array of time zone wrappers and pass to the root view controller.
	 */
	NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
	NSMutableArray *timeZones = [[NSMutableArray alloc] initWithCapacity:[timeZoneNames count]];
	
	for (NSString *timeZoneName in timeZoneNames) {
		
		NSArray *nameComponents = [timeZoneName componentsSeparatedByString:@"/"];
		// For this example, the time zone itself isn't needed.
		TimeZoneWrapper *timeZoneWrapper = [[TimeZoneWrapper alloc] initWithTimeZone:nil nameComponents:nameComponents];
		
		[timeZones addObject:timeZoneWrapper];
		[timeZoneWrapper release];
	}
	
	rootViewController.timeZonesArray = timeZones;
	[timeZones release];
	
	// Configure and display the window.
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

