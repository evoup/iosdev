

#import "RootViewController.h"
#import "TimeZoneCell.h"
#import "TimeZoneWrapper.h"
#import "Region.h"

#import "CustomTableViewCellAppDelegate.h"

#define ROW_HEIGHT 60

@implementation RootViewController

@synthesize displayList;
@synthesize calendar;
@synthesize minuteTimer;
@synthesize regionsTimer;


#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		self.title = NSLocalizedString(@"Time Zones", @"Time Zones title");
		
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		self.tableView.rowHeight = ROW_HEIGHT;
	}
	return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
	
	/*
	 Set up two timers, one that fires every minute, the other every fifteen minutes.

	 1/ The time displayed for each time zone must be updated every minute on the minute.
	 2/ Time zone data is cached. Some time zones are based on 15 minute differences from GMT, so update the cache every 15 minutes, on the "quarter".
    */
	
	NSTimer *timer;
    NSDate *date = [NSDate date];
    
    /*
	 Set up a timer to update the table view every minute on the minute so that it shows the current time.
	 */
    NSDate *oneMinuteFromNow = [date addTimeInterval:60];
    
	NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
	NSDateComponents *timerDateComponents = [calendar components:unitFlags fromDate:oneMinuteFromNow];
	// Add 1 second to make sure the minute update has passed when the timer fires.
	[timerDateComponents setSecond:1];
	NSDate *minuteTimerDate = [calendar dateFromComponents:timerDateComponents];
    
	timer = [[NSTimer alloc] initWithFireDate:minuteTimerDate interval:60 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	self.minuteTimer = timer;	
	[timer release];

	/*
	 Set up a timer to update the region data every 15 minutes on the quarter, so that the regions show the current date.
	 */    
    NSInteger minutesToNextQuarter = 15 - ([timerDateComponents minute] % 15);
    NSDateComponents *minutesToNextQuarterComponents = [[NSDateComponents alloc] init];
    [minutesToNextQuarterComponents setMinute:minutesToNextQuarter];
	NSDate *regionTimerDate = [calendar dateByAddingComponents:minutesToNextQuarterComponents toDate:minuteTimerDate options:0];
	[minutesToNextQuarterComponents release];
    
	timer = [[NSTimer alloc] initWithFireDate:regionTimerDate interval:15*60 target:self selector:@selector(updateRegions:) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	self.regionsTimer = timer;	
	[timer release];
}


- (void)viewWillDisappear:(BOOL)animated {
	self.minuteTimer = nil;	
	self.regionsTimer = nil;	
}


#pragma mark -
#pragma mark Table view datasource and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	// Number of sections is the number of regions
	return [displayList count];
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	// Number of rows is the number of time zones in the region for the specified section
	Region *region = [displayList objectAtIndex:section];
	NSArray *regionTimeZones = region.timeZoneWrappers;
	return [regionTimeZones count];
}


- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
	// Section title is the region name
	Region *region = [displayList objectAtIndex:section];
	return region.name;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
		
	static NSString *CellIdentifier = @"TimeZoneCell";
		
	TimeZoneCell *timeZoneCell = (TimeZoneCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (timeZoneCell == nil) {
		timeZoneCell = [[[TimeZoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		timeZoneCell.frame = CGRectMake(0.0, 0.0, 320.0, ROW_HEIGHT);
	}
	
	// Get the time zones for the region for the section
	Region *region = [displayList objectAtIndex:indexPath.section];
	NSArray *regionTimeZones = region.timeZoneWrappers;
	
	// Get the time zone wrapper for the row
	[timeZoneCell setTimeZoneWrapper:[regionTimeZones objectAtIndex:indexPath.row]];
	return timeZoneCell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	/*
	 To conform to the Human Interface Guidelines, selections should not be persistent --
	 deselect the row after it has been selected.
	 */
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Update events

- (void)updateTime:(NSTimer *)timer {
    /*
     To display the current time, redisplay the time labels.
     Don't reload the table view's data as this is unnecessarily expensive -- it recalculates the number of cells and the height of each item to determine the total height of the view etc.  The external dimensions of the cells haven't changed, just their contents.
     */
    NSArray *visibleCells = self.tableView.visibleCells;
    for (TimeZoneCell *cell in visibleCells) {
        [cell redisplay];
    }
}


- (void)updateRegions:(id)sender {
	/*
	 The following sets the date for the regions, hence also for the time zone wrappers. This has the side-effect of "faulting" the time zone wrappers (see TimeZoneWrapper's setDate: method), so can be used to relieve memory pressure.
	 */
	NSDate *date = [NSDate date];
	for (Region *region in displayList) {
		[region setDate:date];
	}
}


#pragma mark -
#pragma mark Timer set accessor methods

- (void)setMinuteTimer:(NSTimer *)newTimer {
	
	if (minuteTimer != newTimer) {
		[minuteTimer invalidate];
		minuteTimer = newTimer;
	}
}


- (void)setRegionsTimer:(NSTimer *)newTimer {
	
	if (regionsTimer != newTimer) {
		[regionsTimer invalidate];
		regionsTimer = newTimer;
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	
	[super didReceiveMemoryWarning];
	[self updateRegions:self];
}


- (void)dealloc {
	[minuteTimer invalidate];
	[regionsTimer invalidate];
	[displayList release];
	[calendar release];
	[super dealloc];
}


@end
