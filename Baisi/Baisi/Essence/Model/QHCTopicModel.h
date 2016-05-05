//
//  QHCTopicModel.h
//  Baisi
//
//  Created by QHC on 5/4/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    QHCtopicPicture = 10,
    QHCtopicWord = 29,
    QHCtopicVoice = 31,
    QHCtopicVideo = 41
} QHCTopicType;

@interface QHCTopicModel : NSObject

/*
 bimageuri = "http://wimg.spriteapp.cn/picture/2016/0501/5725de90c33ec__b.jpg";
 bookmark = 208;
 "cache_version" = 2;
 cai = 139;
 "cdn_img" = "http://wimg.spriteapp.cn/picture/2016/0501/5725de90c33ec__b.jpg";
 comment = 34;
 "create_time" = "2016-05-01 18:46:40";
 "created_at" = "2016-05-04 09:39:04";
 ding = 1137;
 favourite = 208;
 hate = 139;
 height = 360;
 id = 18319476;
 image0 = "http://wimg.spriteapp.cn/picture/2016/0501/5725de90c33ec__b.jpg";
 image1 = "http://wimg.spriteapp.cn/picture/2016/0501/5725de90c33ec__b.jpg";
 image2 = "http://wimg.spriteapp.cn/picture/2016/0501/5725de90c33ec__b.jpg";
 "image_small" = "http://wimg.spriteapp.cn/picture/2016/0501/5725de90c33ec__b.jpg";
 "is_gif" = 0;
 love = 1137;
 name = "\U738b\U514b\U514b";
 "original_pid" = 0;
 passtime = "2016-05-04 09:39:04";
 playcount = 26669;
 playfcount = 842;
 "profile_image" = "http://wimg.spriteapp.cn/profile/large/2016/04/11/570b4f3220c1b_mini.jpg";
 repost = 268;
 "screen_name" = "\U738b\U514b\U514b";
 status = 4;
 t = 1462325944;
 tag = "";
 text = "\U4f60\U4ece\U8fdc\U65b9\U5954\U8dd1\U6765\U62e5\U62b1\U6211\U7684\U65f6\U5019\Uff0c\U6211\U7684\U5fc3\U90fd\U5316\U4e86";
 "theme_id" = 0;
 "theme_name" = "";
 "theme_type" = 0;
 themes =             (
 );
 "top_cmt" =             (
 );
 type = 41;
 "user_id" = 18025217;
 videotime = 204;
 videouri = "http://wvideo.spriteapp.cn/video/2016/0501/5725de912fd63_wpd.mp4";
 voicelength = 0;
 voicetime = 0;
 voiceuri = "";
 "weixin_url" = "http://b.f.winapp111.com.cn/share/18319476.html?wx.qq.com&appname=";
 width = 480;
 
 */


/*
 最热评论
 "top_cmt" = (
    {
         content = "\U4f60\U518d\U8fd9\U6837\U8086\U65e0\U5fcc\U60ee\U7684\U8bf4\U5927\U5b9e\U8bdd\U6211\U53ef\U8a00\U70b9\U8d5e\U4e86";
         ctime = "2016-05-04 22:03:11";
         "data_id" = 18360753;
         id = 50729664;
         "like_count" = 499;
         precid = 0;
         precmt = ( );
         preuid = 0;
         status = 0;
 
         user =  {
             id = 15702078;
             "is_vip" = 0;
             "personal_page" = "http://t.qq.com/a77442111/";
             "profile_image" = "http://app.qlogo.cn/mbloghead/6188aded58410c98d24c/50";
             "qq_uid" = a77442111;
             "qzone_uid" = "";
             sex = m;
             username = "\U674e\U6676P7K";
             "weibo_uid" = "";
         };
 
         voicetime = 0;
         voiceuri = "";
     }
 );
 */


@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *profile_image;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, copy) NSString *created_at;
@property(nonatomic, assign) NSInteger ding;
@property(nonatomic, assign) NSInteger cai;
@property(nonatomic, assign) NSInteger repost;
@property(nonatomic, assign) NSInteger comment;
@property(nonatomic, strong) NSArray *top_cmt;
@property(nonatomic, copy) NSString *large_image;
@property(nonatomic, copy) NSString *middle_image;
@property(nonatomic, copy) NSString *small_image;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) BOOL is_gif;
@property(nonatomic, assign) QHCTopicType type;

@property(nonatomic, assign) CGFloat cellHeight;
@property(nonatomic, assign) CGRect profileImageViewFrame;
@property(nonatomic, assign) CGRect nameLblFrame;
@property(nonatomic, assign) CGRect createdAtLblFrame;
@property(nonatomic, assign) CGRect moreBtnFrame;
@property(nonatomic, assign) CGRect textLblFrame;
@property(nonatomic, assign) CGRect topCmtLblFrame;
@property(nonatomic, assign) CGRect cmtLbFrame;
@property(nonatomic, assign) CGRect bottomLineFrame;
@property(nonatomic, assign) CGRect dingBtnFrame;
@property(nonatomic, assign) CGRect caiBtnFrame;
@property(nonatomic, assign) CGRect repostBtnFrame;
@property(nonatomic, assign) CGRect commentBtnFrame;

@property(nonatomic, assign) CGRect centerFrame;
@property(nonatomic, assign, getter=isBigPicture) BOOL isBigPicture;







@end
