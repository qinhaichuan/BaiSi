//
//  Definer.h
//  Baisi
//
//  Created by QHC on 4/30/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#ifndef Definer_h
#define Definer_h

#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


#define BASE_URL @"http://api.budejie.com/api/api_open.php"


#ifdef DEBUG
#define QHCLog(...) NSLog(__VA_ARGS__)
#else
#define QHCLog(...)
#endif

#define QHCLogFunc QHCLog(@"%s", __func__);

// 颜色
#define QHCColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)];
#define QHCRandom_Color [UIColor colorWithRed:arc4random_uniform(255.0f)/255.0f green:arc4random_uniform(255.0f)/255.0f blue:arc4random_uniform(255.0f)/255.0f alpha:1];
#define QHCColorI(C) [UIColor colorWithRed:((C>>16)&0xff/255.0f) green:((C>>8)&0xff/255.0f) blue:(C&0xff/255.0f) alpha:1.0];
#define QHCBgColor QHCColor(206, 206, 206, 1)

// 屏幕宽度比例适配
//#define QHCScreen_WRtio [UIScreen mainScreen].bounds.size.width / 414.0f
#define QHCScreen_WRtio 1
//#define QHCScreen_HRtio [UIScreen mainScreen].bounds.size.height / 736.0f
#define QHCScreen_HRtio 1
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

//#define MarginX 10.0*QHCScreen_WRtio
#define MarginX 10.0f


// 字符判断
#define QHCStr(s)     ((s!=nil) && [s isKindOfClass:[NSString class]] && ![s isEqualToString:@""])
#define QHCArr(s) ((s!=nil) && [s isKindOfClass:[NSArray class]] && [s count]>0)
//#define QHCDict(s) (s!=nil && [s isKindOfClass:[NSDictionary class]] && [s count]>0)
#define QHCDict(s) (s!=nil && [s isKindOfClass:[NSDictionary class]])
#define QHCNum(s) ((s!=nil) && [s isKindOfClass:[NSNumber class]])
#define QHCData(s) ((s!=nil) && [s isKindOfClass:[NSData class]])
#define QHCNull(s) (![s isKindOfClass:[NSNull class]])









#endif /* Definer_h */


