
@interface TimeZoneWrapper : NSObject {
	NSTimeZone *timeZone;
	NSString *timeZoneLocaleName;
	
	NSDate *date;
	NSCalendar *calendar;
	
	NSString *whichDay;
	NSString *abbreviation;
	NSString *gmtOffset;
	UIImage *image;
}

@property (nonatomic, retain) NSTimeZone *timeZone;
@property (nonatomic, retain) NSString *timeZoneLocaleName;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSCalendar *calendar;

@property (nonatomic, retain) NSString *whichDay;
@property (nonatomic, retain) NSString *abbreviation;
@property (nonatomic, retain) NSString *gmtOffset;
@property (nonatomic, retain) UIImage *image;

- initWithTimeZone:(NSTimeZone *)tz nameComponents:(NSArray *)nameComponents;

@end
