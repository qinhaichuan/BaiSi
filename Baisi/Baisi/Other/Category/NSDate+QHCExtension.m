//
//  NSDate+QHCExtension.m
//  Baisi
//
//  Created by QHC on 5/5/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "NSDate+QHCExtension.h"

@implementation NSDate (QHCExtension)

-(BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfComp = [calendar components:unit fromDate:self];
    NSDateComponents *nowComp = [calendar components:unit fromDate:[NSDate date]];
    
    return selfComp.year == nowComp.year && selfComp.month == nowComp.month && selfComp.day == nowComp.day;

}

-(BOOL)isYesterday
{
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    dateForm.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [dateForm stringFromDate:self];
    NSDate *selfDate = [dateForm dateFromString:selfStr];
    NSString *nowStr = [dateForm stringFromDate:[NSDate date]];
    NSDate *nowDate = [dateForm dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComp = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return dateComp.year == 0 && dateComp.month == 0 && dateComp.day == 1;

}

-(BOOL)isTomorrow
{
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    dateForm.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [dateForm stringFromDate:self];
    NSDate *selfDate = [dateForm dateFromString:selfStr];
    NSString *nowStr = [dateForm stringFromDate:[NSDate date]];
    NSDate *nowDate = [dateForm dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comp.year == 0 && comp.month == 0 && comp.day == -1;


}

-(BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear fromDate:self toDate:[NSDate date] options:0];
    
    return comp.year == 0;

}


@end
