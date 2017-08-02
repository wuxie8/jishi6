//
//  Serve.h
//  xiaoyixiu
//
//  Created by 柯南 on 16/6/12.
//  Copyright © 2016年 柯南. All rights reserved.
//

#ifndef Serve_h
#define Serve_h

#pragma mark 域名端口

///**
// *  正式域名
// *
// *  @return 正式服务器
// */
#define SERVERE @"http://app.jishiyu11.cn/index.php?g=app"

#define SERVEREURL SERVERE

#define IMG_PATH  @"http://app.jishiyu11.cn/data/upload/"//品牌logo
//贷款
#define loan @"&m=business&a=index"
//换一批
#define exchange @"&m=business&a=change_list"
//登陆验证码
#define verificationCodeLogin  @"&m=login&a=send_code"
//注册验证码
#define verificationCoderegister  @"&m=register&a=send_code"
//注册
#define doregister  @"&m=register&a=doregister"
//无密码注册
#define bycode  @"&m=register&a=bycode"

#define USER_APPID           @"596d63d5"

//登陆
#define dologin  @"&m=login&a=dologin"
//重置密码
#define reset_password  @"&m=register&a=reset_password"
//贷款参数
#define filter_para @"&m=business&a=filter_para"

#define filter @"&m=business&a=filter"

//贷款
#define appcode @"xianjinkadai"

#define appNo @"QD0100"



#endif /* Serve_h */
