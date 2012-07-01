

#import "TimeZoneCell.h"
#import "TimeZoneWrapper.h"
#import "TimeZoneView.h"
#import "CustomTableViewCellAppDelegate.h"


@implementation TimeZoneCell

@synthesize timeZoneView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
		
		// Create a time zone view and add it as a subview of self's contentView.
		CGRect tzvFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
		timeZoneView = [[TimeZoneView alloc] initWithFrame:tzvFrame];
		timeZoneView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self.contentView addSubview:timeZoneView];
	}
	return self;
}


- (void)setTimeZoneWrapper:(TimeZoneWrapper *)newTimeZoneWrapper {
	// Pass the time zone wrapper to the view
	timeZoneView.timeZoneWrapper = newTimeZoneWrapper;
}


- (void)redisplay {
	[timeZoneView setNeedsDisplay];
}


- (void)dealloc {
	[timeZoneView release];
    [super dealloc];
}


@end
