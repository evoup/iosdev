
#import "TimeZoneWrapper.h"
#import "CustomTableViewCellAppDelegate.h"


static NSString *today;
static NSString *tomorrow;
static NSString *yesterday;

static UIImage *q1Image;
static UIImage *q2Image;
static UIImage *q3Image;
static UIImage *q4Image;


@implementation TimeZoneWrapper

@synthesize timeZone;
@synthesize timeZoneLocaleName;
@synthesize date;
@synthesize calendar;

@synthesize whichDay;
@synthesize abbreviation;
@synthesize gmtOffset;
@synthesize image;


+ (void)initialize {
	// Unlikely to have any subclasses, but check class nevertheless.
	if (self == [TimeZoneWrapper class]) {
		today = [NSLocalizedString(@"Today", "Today") retain];
		tomorrow = [NSLocalizedString(@"Tomorrow", "Tomorrow") retain];
		yesterday = [NSLocalizedString(@"Yesterday", "Yesterday") retain];
		
		q1Image = [[UIImage imageNamed:@"12-6AM.png"] retain];
		q2Image = [[UIImage imageNamed:@"6-12AM.png"] retain];
		q3Image = [[UIImage imageNamed:@"12-6PM.png"] retain];
		q4Image = [[UIImage imageNamed:@"6-12PM.png"] retain];	
	}
}


- initWithTimeZone:(NSTimeZone *)aTimeZone nameComponents:(NSArray *)nameComponents {
	
	if (self = [super init]) {
		timeZone = [aTimeZone retain];
		if ([nameComponents count] == 2) {
			timeZoneLocaleName = [[nameComponents objectAtIndex:1] copy];
		} else {
			timeZoneLocaleName = [[NSString alloc] initWithFormat:@"%@ (%@)", [nameComponents objectAtIndex:2], [nameComponents objectAtIndex:1]];
		}
	}
	return self;
}


/*
 By default, we don't actually calculate whichDay, abreviation, gmtOffset or image.
 They're expensive to compute, and consume memory.  Calculate them on demand, then cache them.
 */

- (NSString *)whichDay {
	
    // Return "today", "tomorrow", or "yesterday" as appropriate for the time zone.
	
	if (whichDay == nil) {
		NSDateComponents *dateComponents;
		NSInteger myDay, tzDay;
		
		// Set the calendar's time zone to the default time zone.
		[calendar setTimeZone:App_defaultTimeZone];
		dateComponents = [calendar components:NSWeekdayCalendarUnit fromDate:date];
		myDay = [dateComponents weekday];
		
		[calendar setTimeZone:timeZone];
		dateComponents = [calendar components:NSWeekdayCalendarUnit fromDate:date];
		tzDay = [dateComponents weekday];
		
		NSRange dayRange = [calendar maximumRangeOfUnit:NSWeekdayCalendarUnit];
		NSInteger maxDay = NSMaxRange(dayRange) - 1;
		
		if (myDay == tzDay) {
			self.whichDay = today;
		} else {
			if ((tzDay - myDay) > 0) {
				self.whichDay = tomorrow;
			} else {
				self.whichDay = yesterday;
			}
			// Special cases for days at the end of the week
			if ((myDay == maxDay) && (tzDay == 1)) {
				self.whichDay = tomorrow;				
			}
			if ((myDay == 1) && (tzDay == maxDay)) {
				self.whichDay = yesterday;				
			}
		}
	}
	return whichDay;
}


- (NSString *)abbreviation {
    // Return the abbreviation for the time zone.
	if (abbreviation == nil) {
		self.abbreviation = [timeZone abbreviationForDate:date];
	}
	return abbreviation;
}


- (NSString *)gmtOffset {
    // Return the offset from GMT for the time zone.
	if (gmtOffset == nil) {
		self.gmtOffset = [timeZone localizedName:NSTimeZoneNameStyleShortStandard locale:[NSLocale currentLocale]];	
	}
	return gmtOffset;
}


- (UIImage *)image {
    // Return an image that illustrates the quarter of the current day in the time zone.
	if (image == nil) {
		[calendar setTimeZone:timeZone];
		NSDateComponents *dateComponents = [calendar components:NSHourCalendarUnit fromDate:date];
		NSInteger hour = [dateComponents hour];
		if (hour > 17) {
			self.image = q4Image;
		} else {
			if (hour > 11) {
				self.image = q3Image;
			} else {
				if (hour > 5) {
					self.image = q2Image;
				} else {
					self.image = q1Image;
				}
			}
		}
	}
	return image;
}


- (void)setDate:(NSDate *)newDate {
	/*
	 Recalculating all the details is expensive.
	 Only change the date if it is not actually equal to the current date.
	 If the date is different, "fault" the receiver: nill out all the cached values -- if accessed, they will be recaulculated.
	 */
	if ([newDate isEqualToDate:date]) {
		return;
	}
	[date release];
	date = [newDate retain];
	self.abbreviation = nil;
	self.abbreviation = nil;
	self.gmtOffset = nil;
	self.image = nil;
}


- (void)dealloc {
	[timeZone release];
	[timeZoneLocaleName release];
	[date release];
	[calendar release];
	
	[whichDay release];
	[abbreviation release];
	[gmtOffset release];
	[image release];
	
	[super dealloc];
}


@end
