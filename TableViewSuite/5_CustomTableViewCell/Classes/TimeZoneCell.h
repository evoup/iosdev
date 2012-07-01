

@class TimeZoneWrapper;
@class TimeZoneView;

@interface TimeZoneCell : UITableViewCell {
	TimeZoneView *timeZoneView;
}

- (void)setTimeZoneWrapper:(TimeZoneWrapper *)newTimeZoneWrapper;
@property (nonatomic, retain) TimeZoneView *timeZoneView;

- (void)redisplay;

@end
