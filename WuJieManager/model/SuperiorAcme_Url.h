//
//  SuperiorAcme_Url.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#ifndef SuperiorAcme_Url_h
#define SuperiorAcme_Url_h


//#define Url_header @"test"
//#define Url_header @"test3"
//#define Url_header @"test2"
#define Url_header @"dev"
//#define Url_header @"api"



#define canyin_Base_url [NSString stringWithFormat:@"http://%@.canyin.wujiemall.com", Url_header]





#pragma mark 无界优品老接口
#define Base_url [NSString stringWithFormat:@"http://%@.wujiemall.com/index.php/Api/", Url_header]
////拜师码的BaseUrl
#define BaiShi_Base_url [NSString stringWithFormat:@"http://%@.wujiemall.com/index.php/Api/", [Url_header isEqualToString:@"api"] ? @"www" : Url_header]
////商家码的BaseUrl
#define Merchant_Base_url(stage_merchant_id) [NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/confirmation/stage_merchant_id/%@%@.html", [Url_header isEqualToString:@"api"] ? @"www" : Url_header, stage_merchant_id, [SRegisterLogin shareAppendInviteCode]]

////登录用户的邀请码
#define INVITE_CODE @"INVITE_CODE"
//
#define AUTH_CODE @"auth_code"


#endif /* SuperiorAcme_Url_h */
