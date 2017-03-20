//
//  UtilTools.m
//  xiaoyixiu
//
//  Created by 赵岩 on 16/6/14.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import "UtilTools.h"
@implementation UtilTools
static SystemSoundID shake_sound_enter_id = 0;

#pragma mark   判空方法

+ (BOOL)isBlankString:(id)string
{
    string = [NSString stringWithFormat:@"%@",string];
    
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if([string isEqualToString:@"<null>"])
    {
        return YES;
    }
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isBlankArray:(NSArray *)array
{
    if (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
    {
        return YES;
    }
    return NO;
}

+(BOOL)isBlankDictionary:(NSDictionary *)dictionary;
{
    if (dictionary == nil || [dictionary isKindOfClass:[NSNull class]] || dictionary.count == 0)
    {
        return YES;
    }
    return NO;
}

//身份证号
+ (BOOL)validateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//密码
+(BOOL)password:(NSString *)password
{
    NSString * regex = @"^[A-Za-z0-9]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}




+ (BOOL)isLogin:(NSString *)oneTime andTwoTime:(NSString *)twoTime {
    
    //时间戳转换成日期
    NSDate *oneDate = [NSDate dateWithTimeIntervalSince1970:[oneTime intValue]];
    NSDate *twoDate = [NSDate dateWithTimeIntervalSince1970:[twoTime intValue]];
    //系统自带计算时间，返回的是秒
    NSTimeInterval time = [twoDate timeIntervalSinceDate:oneDate];
    double valiableTime = time;
    //计算天数
    NSInteger val_days = valiableTime/60/60/24;
    
    if (labs(val_days)>=1) {
        return YES;
    }
    
    return NO;
}



#pragma  mark   转换方法
//格式化时间字符串
+(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate *data = [expireDate dateByAddingTimeInterval:24.0*60*60];
    
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    
    NSTimeInterval timeInterval =[data timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
//    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
//    NSString *dayStr;
    NSString *hoursStr;NSString *minutesStr;
//    NSString *secondsStr;
    //天
//    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
//    if(seconds < 10)
//        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
//    else
//        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    
    if (hours<=0&&minutes<=0) {
        return @"超过24小时";
    }
    if (days) {
        return [NSString stringWithFormat:@"剩%@小时 %@分",hoursStr, minutesStr];
    }
    return [NSString stringWithFormat:@"剩%@小时 %@分",hoursStr , minutesStr];
}

+ (NSString *)dateConvertToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+(NSData *)NSdataConvertToImage:(UIImage *)image compress:(CGFloat)compressionQuality
{
    NSData *data;
    if (UIImagePNGRepresentation(image)) {
        data=UIImagePNGRepresentation(image);
    }
    else
    {
        data=UIImageJPEGRepresentation(image, compressionQuality);
    }
    return data;
}
+ (UIImage *)cutImage:(UIImage*)image andSize:(CGSize)size
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (size.width / size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * size.height / size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * size.width / size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    }
    
    UIImage* smallImage = [UIImage imageWithCGImage:imageRef];   //注意蓝色的部分
    CGImageRelease(imageRef);
    
    return smallImage;
}
//录音格式转换（.caf > .mp3）
//+ (NSString *)toMp3:(NSString *)inputStringPath
//{
//    NSString *cafFilePath = inputStringPath;
//    
//    NSDateFormatter *fileNameFormat=[[NSDateFormatter alloc] init];
//    [fileNameFormat setDateFormat:@"yyyyMMddhhmmss"];
//    NSString *mp3FileName = [fileNameFormat stringFromDate:[NSDate date]];
//    mp3FileName = [mp3FileName stringByAppendingString:@".mp3"];
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *strMp3Path = [[NSString alloc] initWithFormat:@"%@",documentsDirectory];
//    NSString *mp3FilePath = [strMp3Path stringByAppendingPathComponent:mp3FileName];
//    
//    @try {
//        int read, write;
//        
//        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");//被转换的文件
//        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");//转换后文件的存放位置
//        
//        const int PCM_SIZE = 8192;
//        const int MP3_SIZE = 8192;
//        short int pcm_buffer[PCM_SIZE*2];
//        unsigned char mp3_buffer[MP3_SIZE];
//        
//        lame_t lame = lame_init();
//        lame_set_in_samplerate(lame, 44100);
//        lame_set_VBR(lame, vbr_default);
//        lame_init_params(lame);
//        
//        do {
//            read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
//            if (read == 0)
//                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
//            else
//                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
//            
//            fwrite(mp3_buffer, write, 1, mp3);
//            
//        } while (read != 0);
//        
//        lame_close(lame);
//        fclose(mp3);
//        fclose(pcm);
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//        
//        NSString *voiceOutPutPath = [NSString stringWithFormat:@"file://%@",mp3FilePath];
//        return voiceOutPutPath;
//        
//    }
//}
+ (NSString *)jsonString:(NSDictionary *)dic;
{
    NSError *error =nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+ (NSString *)arrayConvertToString:(NSArray *)array
{
    //把数组转换为字符串
    NSError *error;
    NSData *textData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *textString = [[NSString alloc] initWithData:textData encoding:NSUTF8StringEncoding];
    return textString;
}
+ (NSArray *)stringConvertToArray:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return array;
}

//时间戳转换成当前时区的日期
+ (NSString *)getDateFromDateLine:(NSString *)dateLine format:(NSString *)format
{
    //上传时的时间戳（格林尼治时间戳）
    NSString *timeIntervalSince1970 = dateLine;
    //把时间戳转换成日期（格林尼治日期）
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeIntervalSince1970 intValue]];
    //初始化时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //给时间格式设置时区（中国 东八区时区）
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    //给时间格式设置格式参数
    //YYYY:MM:dd-HH:mm:ss
    [dateFormatter setDateFormat:format];
    
    //获取date对应dateFormatter格式的字符串（中国 东八区日期）
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;
}
/**
 *  获取相差的天数
 *
 *  @return 获取相差的天数
 */
+ ( int)getDifferenceNumberDays:(NSString *)format dataString:(NSString*)dataString
{
    
    //给时间格式设置时区（中国 东八区）
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setTimeZone:timeZone];
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:format];
    NSDate* inputDate = [inputFormatter dateFromString:dataString];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: inputDate];
    
    NSDate *localeDate = [inputDate dateByAddingTimeInterval: interval];
    NSLog(@"date = %@", localeDate);
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[[NSDate date] timeIntervalSinceDate:localeDate];
    
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}
/**
 *  获取当前时区的时间
 *
 *  @return 当前时区的时间
 */
+ (NSString *)getCurrentDate2:(NSString *)format
{
    //格林尼治日期
    NSDate *date = [NSDate date];
    //初始化时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //给时间格式设置时区（中国 东八区）
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    //给时间格式设置格式参数
    //YYYY:MM:dd-HH:mm:ss
    [dateFormatter setDateFormat:format];
    //获取date对应dateFormatter格式的字符串
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;
}

+(NSString*)stringFromDate:(NSDate*)date
{
    //用于格式化NSDate对象
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate转NSString
    NSString*currentDateString=[dateFormatter stringFromDate:date];
    //输出currentDateString
    return currentDateString;
}

+(NSString *)stringFromData:(NSData *)data
{
    NSString *result  =[[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return result;
}
//计算文本高度
+ (CGSize)getTextHeight:(NSString *)text width:(CGFloat)width font:(UIFont *)font
{
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return textRect.size;
}
//计算文本宽度
+ (CGSize)getTextHeight:(NSString *)text hight:(CGFloat)hight font:(UIFont *)font
{
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, hight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return textRect.size;
}
//计算textView的高度
+ (CGFloat)getTextViewHeight:(NSString *)text font:(UIFont*)font width:(CGFloat)width;
{
    //初始化textView
    UITextView *textView = [[UITextView alloc] init];
    [textView setText:text];
    [textView setFont:font];
    
    CGSize size = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return size.height;
}
+(NSString *)intervalSinceNow: (NSString *) theDate
{
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    if (cha/60<=1) {
        timeString=@"刚刚";
    }
    if (1<cha/60&&cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>=1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400<2&&cha/86400>=1)
    {
        timeString=@"昨天";
        
    }
    if (cha/86400>=2) {
        timeString=[theDate substringWithRange:NSMakeRange(11, 5)];
        
    }
    return timeString;
}
#pragma  mark  封装方法


+(void)refresh:(UITableView *)tableview Integer:(NSInteger)interger
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:interger inSection:0];
    
    [tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

//打电话
+ (UIWebView *)call:(NSString *)phoneAccount
{
    NSString *callPhone = phoneAccount;
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",callPhone]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    return  callWebView;
}

//确定昵称

////好友头像
//+(NSString *)headImageFromPhone:(NSString *)phone
//{
//    if (Context.subUsers.count>0) {
//        for (int i = 0; i<Context.subUsers.count; i++) {
//            SubUser *user = Context.subUsers[i];
//            if ([user.account isEqualToString:phone]) {
//                return user.md5Photo;
//            }
//        }
//        return @"";
//    } else {
//        return @"";
//    }
//}
//
////好友名字
//+(NSString *)nameFromPhone:(NSString *)phone
//{
//    if (Context.subUsers.count>0) {
//        for (int i = 0; i<Context.subUsers.count; i++) {
//            SubUser *user = Context.subUsers[i];
//            
//            if ([user.account isEqualToString:phone]) {
//                
//                return [self stringFrom:user];
//            }
//        }
//        return phone;
//    } else {
//        return phone;
//    }
//}

//获取视频封面，本地视频，网络视频都可以用

+(UIImage*)thumbnailImageForVideo:(NSURL *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 1);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if(error){
        NSLog(@"截取视频缩略图时发生错误，错误信息：%@",error.localizedDescription);
    }
    CMTimeShow(actualTime);
    UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
    return thumbImg;
    
}
+(void)PlaySoundFilename:(NSString *)filename FileType:(NSString *)filetype
{
    BOOL VoiceOn=  [[NSUserDefaults standardUserDefaults] boolForKey:@"kVoiceOn"];
    if (VoiceOn) {
        //播放自己的本地来电提示文件
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:filetype];
        if (path) {
            
            //扬声器 (WLS)
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            
            //注册声音到系统
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_enter_id);
            AudioServicesPlaySystemSound(shake_sound_enter_id);
            
            
        }
        
    }
}

+(void)StopPlaySound
{
    BOOL kShockOn=  [[NSUserDefaults standardUserDefaults] boolForKey:@"kShockOn"];
    if (kShockOn) {

    AudioServicesDisposeSystemSoundID(shake_sound_enter_id);
        
    }
}
//震动方法
+(void)vibrate{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark-> 获取扫描区域的比例关系
+(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}
#pragma mark 加密算法

+ (NSString *) encode:(NSString *)str key:(NSString *)key
{
    // doCipher 不能编汉字，所以要进行 url encode
    NSMutableString* str1 = [self urlEncode:str];
    NSMutableString* encode = [NSMutableString stringWithString:[self doCipher:str1 key:key context:kCCEncrypt]];
    //    [self formatSpecialCharacters:encode];
    return encode;
}
+ (NSMutableString *)urlEncode:(NSString*)str
{
    NSMutableString* encodeStr = [NSMutableString stringWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
   
    [encodeStr replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSWidthInsensitiveSearch range:NSMakeRange(0, [encodeStr length])];
    [encodeStr replaceOccurrencesOfString:@"/" withString:@"%2F" options:NSWidthInsensitiveSearch range:NSMakeRange(0, [encodeStr length])];
    return encodeStr;
}

+ (NSString *) decode:(NSString *)str key:(NSString *)key
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    //    [self reformatSpecialCharacters:str1];
    NSString *rt = [self doCipher:str1 key:key context:kCCDecrypt];
    return rt;
}
+ (NSString *)doCipher:(NSString *)sTextIn key:(NSString *)sKey
               context:(CCOperation)encryptOrDecrypt {
    NSStringEncoding EnC = NSUTF8StringEncoding;
    
    NSMutableData *dTextIn;
    if (encryptOrDecrypt == kCCDecrypt) {
        dTextIn = [[UtilTools decodeBase64WithString:sTextIn] mutableCopy];
    }
    else{
        dTextIn = [[sTextIn dataUsingEncoding: EnC] mutableCopy];
    }
    NSMutableData * dKey = [[sKey dataUsingEncoding:EnC] mutableCopy];
    [dKey setLength:kCCBlockSizeDES];
    uint8_t *bufferPtr1 = NULL;
    size_t bufferPtrSize1 = 0;
    size_t movedBytes1 = 0;
    //uint8_t iv[kCCBlockSizeDES];
    //memset((void *) iv, 0x0, (size_t) sizeof(iv));
    //    Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    bufferPtrSize1 = ([sTextIn length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    bufferPtr1 = malloc(bufferPtrSize1 * sizeof(uint8_t));
    memset((void *)bufferPtr1, 0x00, bufferPtrSize1);
    
    CCCrypt(encryptOrDecrypt, // CCOperation op
            kCCAlgorithmDES, // CCAlgorithm alg
            kCCOptionPKCS7Padding, // CCOptions options
            [dKey bytes], // const void *key
            [dKey length], // size_t keyLength //
            [dKey bytes], // const void *iv
            [dTextIn bytes], // const void *dataIn
            [dTextIn length],  // size_t dataInLength
            (void *)bufferPtr1, // void *dataOut
            bufferPtrSize1,     // size_t dataOutAvailable
            &movedBytes1);
    
    //[dTextIn release];
    //[dKey release];
    
    NSString * sResult;
    if (encryptOrDecrypt == kCCDecrypt){
        sResult = [[NSString alloc] initWithData:[NSData dataWithBytes:bufferPtr1 length:movedBytes1] encoding:EnC];
        free(bufferPtr1);
    }
    else {
        NSData *dResult = [NSData dataWithBytes:bufferPtr1 length:movedBytes1];
        free(bufferPtr1);
        sResult = [self encodeBase64WithData:dResult];
    }
    return sResult;
}
+ (NSString *)encodeBase64WithData:(NSData *)objData
{
    NSString *encoding = nil;
    unsigned char *encodingBytes = NULL;
    @try {
        static char encodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        static NSUInteger paddingTable[] = {0,2,1};
        
        NSUInteger dataLength = [objData length];
        NSUInteger encodedBlocks = (dataLength * 8) / 24;
        NSUInteger padding = paddingTable[dataLength % 3];
        if( padding > 0 ) encodedBlocks++;
        NSUInteger encodedLength = encodedBlocks * 4;
        
        encodingBytes = malloc(encodedLength);
        if( encodingBytes != NULL ) {
            NSUInteger rawBytesToProcess = dataLength;
            NSUInteger rawBaseIndex = 0;
            NSUInteger encodingBaseIndex = 0;
            unsigned char *rawBytes = (unsigned char *)[objData bytes];
            unsigned char rawByte1, rawByte2, rawByte3;
            while( rawBytesToProcess >= 3 ) {
                rawByte1 = rawBytes[rawBaseIndex];
                rawByte2 = rawBytes[rawBaseIndex+1];
                rawByte3 = rawBytes[rawBaseIndex+2];
                encodingBytes[encodingBaseIndex] = encodingTable[((rawByte1 >> 2) & 0x3F)];
                encodingBytes[encodingBaseIndex+1] = encodingTable[((rawByte1 << 4) & 0x30) | ((rawByte2 >> 4) & 0x0F) ];
                encodingBytes[encodingBaseIndex+2] = encodingTable[((rawByte2 << 2) & 0x3C) | ((rawByte3 >> 6) & 0x03) ];
                encodingBytes[encodingBaseIndex+3] = encodingTable[(rawByte3 & 0x3F)];
                
                rawBaseIndex += 3;
                encodingBaseIndex += 4;
                rawBytesToProcess -= 3;
            }
            rawByte2 = 0;
            switch (dataLength-rawBaseIndex) {
                case 2:
                    rawByte2 = rawBytes[rawBaseIndex+1];
                case 1:
                    rawByte1 = rawBytes[rawBaseIndex];
                    encodingBytes[encodingBaseIndex] = encodingTable[((rawByte1 >> 2) & 0x3F)];
                    encodingBytes[encodingBaseIndex+1] = encodingTable[((rawByte1 << 4) & 0x30) | ((rawByte2 >> 4) & 0x0F) ];
                    encodingBytes[encodingBaseIndex+2] = encodingTable[((rawByte2 << 2) & 0x3C) ];
                    // we can skip rawByte3 since we have a partial block it would always be 0
                    break;
            }
            // compute location from where to begin inserting padding, it may overwrite some bytes from the partial block encoding
            // if their value was 0 (cases 1-2).
            encodingBaseIndex = encodedLength - padding;
            while( padding-- > 0 ) {
                encodingBytes[encodingBaseIndex++] = '=';
            }
            encoding = [[NSString alloc] initWithBytes:encodingBytes length:encodedLength encoding:NSASCIIStringEncoding];
        }
    }
    @catch (NSException *exception) {
        encoding = nil;
    }
    @finally {
        if( encodingBytes != NULL ) {
            free( encodingBytes );
        }
    }
    return encoding;
    
}

+ (NSData *)decodeBase64WithString:(NSString *)strBase64
{
    NSData *data = nil;
    unsigned char *decodedBytes = NULL;
    @try {
#define __ 255
        static char decodingTable[256] = {
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x00 - 0x0F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x10 - 0x1F
            __,__,__,__, __,__,__,__, __,__,__,62, __,__,__,63,  // 0x20 - 0x2F
            52,53,54,55, 56,57,58,59, 60,61,__,__, __, 0,__,__,  // 0x30 - 0x3F
            __, 0, 1, 2,  3, 4, 5, 6,  7, 8, 9,10, 11,12,13,14,  // 0x40 - 0x4F
            15,16,17,18, 19,20,21,22, 23,24,25,__, __,__,__,__,  // 0x50 - 0x5F
            __,26,27,28, 29,30,31,32, 33,34,35,36, 37,38,39,40,  // 0x60 - 0x6F
            41,42,43,44, 45,46,47,48, 49,50,51,__, __,__,__,__,  // 0x70 - 0x7F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x80 - 0x8F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0x90 - 0x9F
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xA0 - 0xAF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xB0 - 0xBF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xC0 - 0xCF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xD0 - 0xDF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xE0 - 0xEF
            __,__,__,__, __,__,__,__, __,__,__,__, __,__,__,__,  // 0xF0 - 0xFF
        };
        strBase64 = [strBase64 stringByReplacingOccurrencesOfString:@"=" withString:@""];
        NSData *encodedData = [strBase64 dataUsingEncoding:NSASCIIStringEncoding];
        unsigned char *encodedBytes = (unsigned char *)[encodedData bytes];
        
        NSUInteger encodedLength = [encodedData length];
        NSUInteger encodedBlocks = (encodedLength+3) >> 2;
        NSUInteger expectedDataLength = encodedBlocks * 3;
        
        unsigned char decodingBlock[4];
        
        decodedBytes = malloc(expectedDataLength);
        if( decodedBytes != NULL ) {
            
            NSUInteger i = 0;
            NSUInteger j = 0;
            NSUInteger k = 0;
            unsigned char c;
            while( i < encodedLength ) {
                c = decodingTable[encodedBytes[i]];
                i++;
                if( c != __ ) {
                    decodingBlock[j] = c;
                    j++;
                    if( j == 4 ) {
                        decodedBytes[k] = (decodingBlock[0] << 2) | (decodingBlock[1] >> 4);
                        decodedBytes[k+1] = (decodingBlock[1] << 4) | (decodingBlock[2] >> 2);
                        decodedBytes[k+2] = (decodingBlock[2] << 6) | (decodingBlock[3]);
                        j = 0;
                        k += 3;
                    }
                }
            }
            
            // Process left over bytes, if any
            if( j == 3 ) {
                decodedBytes[k] = (decodingBlock[0] << 2) | (decodingBlock[1] >> 4);
                decodedBytes[k+1] = (decodingBlock[1] << 4) | (decodingBlock[2] >> 2);
                k += 2;
            } else if( j == 2 ) {
                decodedBytes[k] = (decodingBlock[0] << 2) | (decodingBlock[1] >> 4);
                k += 1;
            }
            data = [[NSData alloc] initWithBytes:decodedBytes length:k];
        }
    }
    @catch (NSException *exception) {
        data = nil;
    }
    @finally {
        if( decodedBytes != NULL ) {
            free( decodedBytes );
        }
    }
    return data;
    
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (NSInteger)characterCountOfStr:(NSString *)str;
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [str dataUsingEncoding:enc];
    return [data length];
}

#pragma mark - 图片本地存储，获取md5值
//+ (NSString *)getPhotosMd5:(UIImage *)image result:(void(^)(NSString *path,int progress))result
//{
//    
//    //根据当前系统时间生成图片名称
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    NSString *dateString = [formatter stringFromDate:date];
//    
//    NSString *fileName = [NSString stringWithFormat:@"%@.png",dateString];
//    NSData *imageData;
//    imageData = UIImageJPEGRepresentation(image, 1);
//    
//    double scaleNum = (double)300*1024 / imageData.length;
//    if (scaleNum < 1) {
//        imageData = UIImageJPEGRepresentation(image, scaleNum);
//    }
//    
//    //把图片临时存到本地（为了获取图片路径）
//    NSString *photoTempPath = [WriteToFile localDataWriteToTempFilePath:@"png" fileName:fileName resourceType:@"HomeShoppingPicture" fileData:imageData];
//    
//    NSMutableArray * photoTempPatharray=[NSMutableArray arrayWithArray:[photoTempPath componentsSeparatedByString:@"Documents/"]];
//    NSString *photoMd5Str = [NSString stringWithFormat:@"%@",[MyMD5 md5Str:[NSString stringWithFormat:@"%@",photoTempPatharray[1]]]];
//    
//    //把图片存到本地库
//    [WriteToFile dataWriteToFilePath:@"png" fileName:photoMd5Str resourceType:@"TrustedFollowerOriginalImage" fileData:imageData result:^(NSString *path, int progress) {
//        result(path,progress);
//    }];
//    
//    return photoMd5Str;
//}


@end
