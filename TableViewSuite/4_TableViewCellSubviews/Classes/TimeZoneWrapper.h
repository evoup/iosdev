
@interface TimeZoneWrapper : NSObject {
	NSString *localeName;
	NSTimeZone *timeZone;
	
	NSDate *date;
	NSCalendar *calendar;
	
	NSString *whichDay;
	NSString *abbreviation;
	NSString *gmtOffset;
	UIImage *image;
}

@property (nonatomic, retain) NSString *localeName;
@property (nonatomic, retain) NSTimeZone *timeZone;

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSCalendar *calendar;

@property (nonatomic, retain) NSString *whichDay;
@property (nonatomic, retain) NSString *abbreviation;
@property (nonatomic, retain) NSString *gmtOffset;
@property (nonatomic, retain) UIImage *image;

- (id)initWithTimeZone:(NSTimeZone *)aTimeZone nameComponents:(NSArray *)nameComponents;

@end
