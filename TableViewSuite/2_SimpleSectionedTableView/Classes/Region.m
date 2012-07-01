
#import "Region.h"
#import "TimeZoneWrapper.h"


@interface Region (Private)
- (id)initWithName:(NSString *)regionName;
+ (void)setUpKnownRegions;
- (void)addTimeZoneWrapper:(TimeZoneWrapper *)timeZoneWrapper;
- (void)sortTimeZones;
@end


@implementation Region

@synthesize name, timeZoneWrappers;

static NSMutableArray *knownRegions = nil;


+ (NSArray *)knownRegions {
	
	if (knownRegions == nil) {
		[self setUpKnownRegions];
	}
	return knownRegions;
	
}


#pragma mark -
#pragma mark Memory management.

- (void)dealloc {
	[name release];
	[timeZoneWrappers release];
	[super dealloc];
}


#pragma mark -
#pragma mark Private methods for setting up the regions.

- (id)initWithName:(NSString *)regionName {
	
	if (self = [super init]) {
		name = [regionName copy];
		timeZoneWrappers = [[NSMutableArray alloc] init];
	}
	return self;
}


+ (void)setUpKnownRegions {
	
	NSArray *knownTimeZoneNames = [NSTimeZone knownTimeZoneNames];
	
	NSMutableArray *regions = [[NSMutableArray alloc] initWithCapacity:[knownTimeZoneNames count]];
	
	for (NSString *timeZoneName in knownTimeZoneNames) {
		
		NSArray *nameComponents = [timeZoneName componentsSeparatedByString:@"/"];
		NSString *regionName = [nameComponents objectAtIndex:0];
		
		// Get the region  with the region name, or create it if it doesn't exist.
		Region *region = nil;
		
		for (Region *aRegion in regions) {
			if ([aRegion.name isEqualToString:regionName]) {
				region = aRegion;
				break;
			}
		}
		
		if (region == nil) {
			region = [[Region alloc] initWithName:regionName];
			[regions addObject:region];
			[region release];
		}
		
		NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:timeZoneName];
		TimeZoneWrapper *timeZoneWrapper = [[TimeZoneWrapper alloc] initWithTimeZone:timeZone nameComponents:nameComponents];
		[region addTimeZoneWrapper:timeZoneWrapper];
		[timeZoneWrapper release];
	}
	
	// Now sort the time zones by name
	for (Region *aRegion in regions) {
		[aRegion sortTimeZones];
	}
	
	// Sort the regions
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [regions sortUsingDescriptors:sortDescriptors];
	[sortDescriptor release];
	[sortDescriptors release];
	
	knownRegions = regions;
}	


- (void)addTimeZoneWrapper:(TimeZoneWrapper *)timeZoneWrapper {
	[timeZoneWrappers addObject:timeZoneWrapper];
}


- (void)sortTimeZones {
	
	// Sort the time zones by name
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"localeName" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	[timeZoneWrappers sortUsingDescriptors:sortDescriptors];

	[sortDescriptor release];
	[sortDescriptors release];
}	

@end
