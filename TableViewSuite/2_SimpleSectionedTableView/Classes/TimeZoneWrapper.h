
@interface TimeZoneWrapper : NSObject {
	NSString *localeName;
	NSTimeZone *timeZone;
}

@property (nonatomic, copy) NSString *localeName;
@property (nonatomic, retain) NSTimeZone *timeZone;

- (id)initWithTimeZone:(NSTimeZone *)aTimeZone nameComponents:(NSArray *)nameComponents;

@end
