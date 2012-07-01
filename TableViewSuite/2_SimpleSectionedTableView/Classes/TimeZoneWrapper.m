
#import "TimeZoneWrapper.h"


@implementation TimeZoneWrapper

@synthesize localeName, timeZone;

- (id)initWithTimeZone:(NSTimeZone *)aTimeZone nameComponents:(NSArray *)nameComponents {
	
	if (self = [super init]) {
		
		timeZone = [aTimeZone retain];
		
		NSString *name = nil;
		if ([nameComponents count] == 2) {
			name = [[nameComponents objectAtIndex:1] retain];
		}
		else {
			name = [[NSString alloc] initWithFormat:@"%@ (%@)", [nameComponents objectAtIndex:2], [nameComponents objectAtIndex:1]];
		}
		
		localeName = [[name stringByReplacingOccurrencesOfString:@"_" withString:@" "] retain];
		[name release];
	}
	return self;
}


- (void)dealloc {
	[localeName release];
	[timeZone release];
	
	[super dealloc];
}


@end
