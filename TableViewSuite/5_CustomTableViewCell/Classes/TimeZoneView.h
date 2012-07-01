

@class TimeZoneWrapper;

@interface TimeZoneView : UIView {
	TimeZoneWrapper *timeZoneWrapper;
	NSDateFormatter *dateFormatter;
	NSString *abbreviation;
	BOOL highlighted;
	BOOL editing;
}

@property (nonatomic, retain) TimeZoneWrapper *timeZoneWrapper;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSString *abbreviation;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;
@property (nonatomic, getter=isEditing) BOOL editing;

@end
