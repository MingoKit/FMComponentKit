
#import "NSDateComponents+FMCategory.h"

@implementation NSDateComponents (FMCategory)

+(NSDateComponents *)fm_dateComponentsFromDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal fromDate:date];
    return components;
    
}

@end
