

#import "CustomTableViewCellAppDelegate.h"
#import "RootViewController.h"

#import "Region.h"


NSTimeZone *App_defaultTimeZone;

@implementation CustomTableViewCellAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	/*
	 We use these images and the application's time zone a lot, they're also static, so cache them and make them available globally...
	 */
	App_defaultTimeZone = [[NSTimeZone defaultTimeZone] retain];
	
	// Create the navigation and view controllers
	RootViewController *rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
	
	rootViewController.displayList = [self displayList];
	rootViewController.calendar = [self calendar];
	
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
	self.navigationController = aNavigationController;
	[aNavigationController release];
	[rootViewController release];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


#pragma mark -
#pragma mark Setting up the display list

- (NSArray *)displayList {
	/*
	 Return an array of Region objects.
	 Each object represents a geographical region.  Each region contains time zones.
	 Much of the information required to display a time zone is expensive to compute, so rather than using NSTimeZone objects directly use wrapper objects that calculate the required derived values on demand and cache the results.
	 */
	NSArray *knownTimeZoneNames = [NSTimeZone knownTimeZoneNames];
	
	NSMutableArray *regions = [NSMutableArray array];
	
	for (NSString *timeZoneName in knownTimeZoneNames) {
		
		NSArray *components = [timeZoneName componentsSeparatedByString:@"/"];
		NSString *regionName = [components objectAtIndex:0];
		
		Region *region = [Region regionNamed:regionName];
		if (region == nil) {
			region = [Region newRegionWithName:regionName];
			region.calendar = [self calendar];
			[regions addObject:region];
			[region release];
		}
		
		NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:timeZoneName];
		[region addTimeZone:timeZone nameComponents:components];
		[timeZone release];
	}
	
	NSDate *date = [NSDate date];
	// Now sort the time zones by name
	for (Region *region in regions) {
		[region sortZones];
		[region setDate:date];
	}
	// Sort the regions
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	[regions sortUsingDescriptors:sortDescriptors];
	[sortDescriptor release];
	
	return regions;
}


- (NSCalendar *)calendar {
	if (calendar == nil) {
		calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	}
	return calendar;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
    [window release];
    [calendar release];
    [super dealloc];
}

@end
