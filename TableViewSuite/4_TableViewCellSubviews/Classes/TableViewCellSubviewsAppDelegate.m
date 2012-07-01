
#import "TableViewCellSubviewsAppDelegate.h"
#import "RootViewController.h"

#import "Region.h"

@interface TableViewCellSubviewsAppDelegate (Private)
- (NSArray *)regionsWithCalendar:(NSCalendar *)calendar;
@end



@implementation TableViewCellSubviewsAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
			
	// Create the navigation and view controllers
	RootViewController *rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
	self.navigationController = aNavigationController;
	[aNavigationController release];
	
	NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	rootViewController.calendar = calendar;
	rootViewController.displayList = [self regionsWithCalendar:calendar];
	
	[calendar release];
	[rootViewController release];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}



- (NSArray *)regionsWithCalendar:(NSCalendar *)calendar {
	/*
	 Create an array of Region objects.
	 Each object represents a geographical region.  Each region contains time zones.
	 Much of the information required to display a time zone is expensive to compute, so rather than using NSTimeZone objects directly use wrapper objects that calculate the required derived values on demand and cache the results.
	 */
	NSArray *knownTimeZoneNames = [NSTimeZone knownTimeZoneNames];
	
	NSMutableArray *regions = [[NSMutableArray alloc] init];
	
	for (NSString *timeZoneName in knownTimeZoneNames) {
		
		NSArray *components = [timeZoneName componentsSeparatedByString:@"/"];
		NSString *regionName = [components objectAtIndex:0];
		
		Region *region = [Region regionNamed:regionName];
		if (region == nil) {
			region = [Region newRegionWithName:regionName];
			region.calendar = calendar;
			[regions addObject:region];
			[region release];
		}
		
		NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:timeZoneName];
		[region addTimeZone:timeZone nameComponents:components];
		[timeZone release];
	}
	
	// Now sort the time zones by name.
	NSDate *date = [[NSDate alloc] init];
	for (Region *region in regions) {
		[region sortZones];
		[region setDate:date];
	}
	[date release];
	
	// Sort the regions.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSArray *sortedRegions = [regions sortedArrayUsingDescriptors:sortDescriptors];
	
	[sortDescriptor release];
	[sortDescriptors release];

	[regions release];
	
	return sortedRegions;
}



- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
