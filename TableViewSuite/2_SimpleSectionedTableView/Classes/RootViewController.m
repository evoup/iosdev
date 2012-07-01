

#import "RootViewController.h"
#import "SimpleSectionedTableViewAppDelegate.h"
#import "Region.h"
#import "TimeZoneWrapper.h"

NSString *localeNameForTimeZoneNameComponents(NSArray *nameComponents);
NSMutableDictionary *regionDictionaryWithNameInArray(NSString *name, NSArray *array);


@implementation RootViewController


@synthesize regions;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	self.title = NSLocalizedString(@"Time Zones", @"Time Zones title");
}


#pragma mark -
#pragma mark Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Number of sections is the number of regions.
	return [regions count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Number of rows is the number of time zones in the region for the specified section.
	Region *region = [regions objectAtIndex:section];
	return [region.timeZoneWrappers count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	// The header for the section is the region name -- get this from the region at the section index.
	Region *region = [regions objectAtIndex:section];
	return [region name];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Get the section index, and so the region for that section.
	Region *region = [regions objectAtIndex:indexPath.section];
	TimeZoneWrapper *timeZoneWrapper = [region.timeZoneWrappers objectAtIndex:indexPath.row];
	
	// Set the cell's text to the name of the time zone at the row
	cell.textLabel.text = timeZoneWrapper.localeName;
	return cell;
}


#pragma mark -
#pragma mark Table view delegate method

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[regions release];
    [super dealloc];
}


@end
