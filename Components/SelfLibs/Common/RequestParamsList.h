//
//  RequestParamsList.h
//  EasyLife
//
//  Created by DingJian on 16/5/18.
//  Copyright © 2016年 CCJ. All rights reserved.
//

//所有网络请求接口参数列表汇总

#ifndef RequestParamsList_h
#define RequestParamsList_h

//登录
static NSString *kFFKartLogin = @"login.do?";

// ========================== Code ========================//

//登录
static NSString * const kFFKartLoginCode =  @"login.do";

#define KEY_CODE  (@"code")
#define KEY_MSG   (@"msg")
#define KEY_DATA  (@"data")
#define KEY_IS_REVIEW (@"isreview")
#define KEY_NEW_VERSION (@"new_version")
#define KEY_NEW_CONTENT (@"new_content")
#define KEY_TOKEN (@"token")

#define KEY_ONLY_ONE_STATE (@"only_one_state")
#define KEY_HTML_CONTENT (@"html_content")
#define KEY_NOW_SERVER_TIME (@"now_server_time")

#define KEY_FEED_VIDEO (@"video")
#define KEY_FEED_COURSEWARE (@"courseware")
#define KEY_FEED_DESC (@"desc")
#define KEY_FEED_REMARK (@"remark")

//用户
#define KEY_USER_ID  (@"user_id")
#define KEY_NICKNAME (@"nick_name")
#define KEY_IMG_BIG  (@"headimg")
#define KEY_GENDER   (@"gender")
#define KEY_STAR     (@"star")
#define KEY_AUTH_KEY (@"ddtoken")
#define KEY_ALL_LESSION_TIMES (@"all_lesson_times")
#define KEY_LEFT_LESSION_TIMES (@"left_lesson_times")

#define KEY_VERSION  (@"ddversion")
#define KEY_CLIENT   (@"ddclient")

#define KEY_SHARE_URL   (@"link")
#define KEY_SHARE_IMAGE (@"img")
#define KEY_SHARE_TITLE (@"title")
#define KEY_SHARE_DESC  (@"desc")

//上传异常
#define KEY_ERROR_TIME (@"time")
#define KEY_ERROR_KEY (@"key")
#define KEY_ERROR_VERSION (@"version")
#define KEY_ERROR_DEVICE (@"device")
#define KEY_ERROR_DEVICE_ID (@"device_id")
#define KEY_ERROR_SYSTEM (@"system")
#define KEY_ERROR_EVENT (@"event")
#define KEY_ERROR_DESCRIBE (@"describe")
#define KEY_ERROR_ERROR (@"error")
#define KEY_ERROR_LEVEL (@"level")
#define KEY_ERROR_KEY  (@"key")
#define KEY_ERROR_FILE (@"file")

#define KEY_IS_FORCE  (@"is_force")

//注册
#define KEY_MOBILE (@"mobile")
#define KEY_VERIGY_CODE_TYPE (@"verify_code_type")
#define KEY_USER_NAME (@"username")
#define KEY_PASSWORD (@"password")
#define KEY_CLIENT_TYPE (@"client_type")
#define KEY_VERIFY_CODE (@"verify_code")
#define KEY_GRADE (@"grade")
#define KEY_PROVINCEID (@"province_id")
#define KEY_CITYID (@"city_id")
#define KEY_CITY (@"city")

#define KEY_PASSWORD1 (@"pwd1")
#define KEY_PASSWORD2 (@"pwd2")

#define KEY_GRADE_NAME (@"grade_name")
#define KEY_GRADE_ID (@"grade_id")

#define KEY_PROVINCE_ID (@"province_id")
#define KEY_PROVINCE_NAME (@"province_name")
#define KEY_DATE_CREATED (@"date_created")
#define KEY_DATE_UPDATED (@"date_updated")

#define KEY_CITY_ID (@"city_id")
#define KEY_CITY_NAME (@"city_name")
#define KEY_ZIP_CODE (@"zip_code")
#define KEY_FIRST_LETTER (@"first_letter")

#define KEY_GENDER (@"gender")
#define KEY_RECOMMEND (@"recommend")
#define KEY_ALL (@"all")
#define KEY_INDEX (@"index")

//课程
#define KEY_COURSE_ID     (@"course_id")
#define KEY_COURSE_TYPE   (@"course_type")
#define KEY_TOTAL_LESSION_NUMBER (@"total_lession_number")
#define KEY_COURSE_CONTENT (@"course_content")
#define KEY_CONTENT_URL   (@"content_url")
#define KEY_COURSE_NAME   (@"course_name")
#define KEY_IMAGE_SMALL   (@"image_small")
#define KEY_CREATE_TIME   (@"create_time")
#define KEY_COURSE_DESC   (@"course_desc")

#define KEY_COURSE_LIST   (@"course_list")
#define KEY_TYPE_ID       (@"type_id")
#define KEY_TYPE_NAME     (@"type_name")

#define KEY_IMAGE_ID      (@"img_id")
#define KEY_IMAGE_REMARK  (@"img_remark")
#define KEY_IMAGE_PATH    (@"img_path")
#define KEY_IMAGE_HREF    (@"img_href")
#define KEY_SORT_ASC_NUM  (@"sort_asc_num")

//购买课程
#define KEY_PURCHASE_TYPE (@"type")
#define KEY_PURCHASE_STATE (@"state")

#define KEY_ORDER_ID (@"order_id")
#define KEY_ORDER_NO (@"order_no")
#define KEY_PURCHASE_TITLE (@"title")
#define KEY_SUP_TITLE (@"title_sup")
#define KEY_PURCHASE_BIG_IMAGE (@"img_new")
#define KEY_OLD_PRICE (@"old_price")
#define KEY_CUR_PRICE (@"price")
#define KEY_CUR_SUPER_PRICE (@"super_price")
#define KEY_PURCHASE_TIMES (@"times")
#define KEY_CARD_IMG (@"card_img")
#define KEY_CARD_TIMES (@"card_times")
#define KEY_MONEY  (@"money")
#define KEY_PURCHASE_CREATE_TIME (@"create_time")

#define KEY_ENCODE_STR (@"encode_str")
#define KEY_TRANSACTION_ID (@"transaction_id")

//课时
#define KEY_LESSION_INFO (@"lession_info")
#define KEY_LESSION_ID  (@"lession_id")
#define KEY_LESSION_INDEX (@"lession_index")
#define KEY_LESSION_NAME (@"lession_name")
#define KEY_LESSION_DESC (@"lession_desc")
#define KEY_LESSION_CONTENT (@"lession_content")
#define KEY_BESPEAK_ID (@"bespeak_id")
#define KEY_BESPEAK_START_TIME (@"bespeak_start_time")
#define KEY_BESPEAK_END_TIME (@"bespeak_end_time")
#define KEY_TEACHER_NAME (@"teacher_name")
#define KEY_STATE (@"state")
#define KEY_CLIENT_START_TIME (@"client_start_time")
#define KEY_SERVER_NOW_TIME (@"server_now_time")
#define KEY_SERVER_END_TIME (@"server_now_time")
#define KEY_ANSWER_STAR (@"award_star")

#define KEY_CLASS_STATE (@"class_state")
#define KEY_CUR_SERVER_TIME (@"cur_server_time")
#define KEY_PREVIEW_ZIP  (@"preview_zip")
#define KEY_LESSION_ZIP  (@"lesson_zip")
#define KEY_VIDEO_ZIP    (@"video_zip")
#define KEY_JS_VERSION   (@"js_version")

#define KEY_LESSION_OPEN (@"is_open")
#define KEY_EXIST_PREVIEW (@"exist_preview")

//#define
#define KEY_FINISH (@"finish")
#define KEY_START (@"start")
#define KEY_HTML (@"html")
#define KEY_SEQ (@"seq")
#define KEY_TIMES (@"times")

//待丢弃
#define KEY_IS_LEARNING (@"is_learning")
#define KEY_IS_END (@"is_end")
#define KEY_IS_BESPEAK (@"is_bespeak")

//预约课程
#define KEY_DAY (@"day")
#define KEY_DAYS (@"days")
#define KEY_TIMES (@"times")
#define KEY_START_TIME (@"start_time")
#define KEY_END_TIME (@"end_time")
#define KEY_TIME_ID (@"timetable_id")
#define KEY_TIME_TYPE (@"timetable_type")

#define KEY_DATETIME_START (@"dateTimeStart")
#define KEY_DATETIME_END (@"dateTimeEnd")
#define KEY_COURSEID (@"course_id")
#define KEY_LESSIONID (@"lession_id")

//修改用户信息
#define KEY_ACT (@"act")
#define KEY_VALUE (@"value")
#define KEY_OTHER_VALUE (@"other_value")
#define KEY_HEAD_IMG (@"headimg")
#define KEY_HEAD_IMG_URL (@"headimg_url")
#define KEY_HEAD_IMG (@"headimg")
#define KEY_ADDRESS (@"address")

//礼物兑换
#define KEY_GIFT_ID (@"id")
#define KEY_GIFT_NAME (@"gift_name")
#define KEY_GIFT_TITLE (@"gift_title")
#define KEY_GIFT_IMG (@"gift_img")
#define KEY_GIFT_PRICE (@"gift_price")
#define KEY_GIFT_STAR (@"gift_star")
#define KEY_GIFT_INDEX (@"gift_index")
#define KEY_GIFT_REMARK (@"remark")
#define KEY_IS_ONLINE (@"is_online")
#define KEY_CREATE_TIME (@"create_time")
#define KEY_UPDATE_TIME (@"update_time")
#define KEY_GIFT_LOGISTICS_STATE (@"state")
#define KEY_GIFT_POST_ORDER (@"post_order")

#define KEY_CONTENT (@"content")
/*********************本地保存配置************************/
//保存本地信息
#define KEY_CUR_USER_MODEL (@"key_cur_user_model")
#define KEY_CUR_USER_PHONE (@"key_cur_user_phone")

#endif /* RequestParamsList_h */

