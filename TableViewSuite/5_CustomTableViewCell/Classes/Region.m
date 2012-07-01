

#import "Region.h"
#import "TimeZoneWrapper.h"


static NSMutableDictionary *regions;

@implementation Region

@synthesize name;
@synthesize  timeZoneWrappers;
@synthesize  calendar;

/*
 Class methods to manage global regions.
 */
+ (void)initialize {
	regions = [[NSMutableDictionary alloc] init];	
}


+ (Region *)regionNamed:(NSString *)name {
	return [regions objectForKey:name];
}


+ (Region *)newRegionWithName:(NSString *)regionName {
    // Create a new region with a given name; add it to the regions dictionary.
	Region *newRegion = [[Region alloc] init];
	newRegion.name = regionName;
	NSMutableArray *array = [[NSMutableArray alloc] init];
	newRegion.timeZoneWrappers = array;
	[array release];
	[regions setObject:newRegion forKey:regionName];
	return newRegion;
}


- (void)addTimeZone:(NSTimeZone *)timeZone nameComponents:(NSArray *)nameComponents {
    // Add a time zone to the region; use nameComponents since that's expensive to compute.
	TimeZoneWrapper *timeZoneWrapper = [[TimeZoneWrapper alloc] initWithTimeZone:timeZone nameComponents:nameComponents];
	timeZoneWrapper.calendar = calendar;
	[timeZoneWrappers addObject:timeZoneWrapper];
	[timeZoneWrapper release];
}


- (void)sortZones {
    // Sort the zone wrappers by locale name.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeZoneLocaleName" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	[timeZoneWrappers sortUsingDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
}


// Sets the date for the time zones, which has the side-effect of "faulting" the wrappers (see TimeZoneWrapper's setDate: method).
- (void)setDate:(NSDate *)date {
	for (TimeZoneWrapper *wrapper in timeZoneWrappers) {
		wrapper.date = date;
	}
}


- (void)dealloc {
	[name release];
	[timeZoneWrappers release];
	[calendar release];
	[super dealloc];
}


@end
