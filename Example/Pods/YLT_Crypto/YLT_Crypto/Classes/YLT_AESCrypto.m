//
//  YLT_AESCrypto.m
//  YLT_Crypto
//
//  Created by YLT on 2017/10/12.
//

#import "YLT_AESCrypto.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation YLT_AESCrypto

/**
 AES 加密字符串
 
 @param sourceString 源字串
 @param keyString 密钥
 @param iv 向量(8字节)
 @return 加密后的Base64字串
 */
+ (NSString *)encryptString:(NSString *)sourceString keyString:(NSString *)keyString iv:(NSData *)iv {
    return [[YLT_CryptoTools encryptType:kCCAlgorithmAES sourceData:[sourceString dataUsingEncoding:NSUTF8StringEncoding] keyData:[keyString dataUsingEncoding:NSUTF8StringEncoding] iv:iv] base64EncodedStringWithOptions:0];
}

/**
 AES 解密字符串
 
 @param sourceString 源字串
 @param keyString 密钥
 @param iv 向量(8字节)
 @return 解密后的字串
 */
+ (NSString *)dencryptString:(NSString *)sourceString keyString:(NSString *)keyString iv:(NSData *)iv {
    return [[NSString alloc] initWithData:[YLT_CryptoTools dencryptType:kCCAlgorithmAES sourceData:[[NSData alloc] initWithBase64EncodedString:sourceString options:0] keyData:[keyString dataUsingEncoding:NSUTF8StringEncoding] iv:iv] encoding:NSUTF8StringEncoding];
}

/**
 AES 加密数据
 
 @param sourceData 源
 @param keyString 密钥
 @param iv 向量(8字节)
 @return 加密后
 */
+ (NSData *)encryptData:(NSData *)sourceData keyString:(NSString *)keyString iv:(NSData *)iv {
    return [YLT_CryptoTools encryptType:kCCAlgorithmAES sourceData:sourceData keyData:[keyString dataUsingEncoding:NSUTF8StringEncoding] iv:iv];
}

/**
 AES 解密
 
 @param sourceData 源
 @param keyString 密钥
 @param iv 向量(8字节)
 @return 解密后
 */
+ (NSData *)dencryptData:(NSData *)sourceData keyString:(NSString *)keyString iv:(NSData *)iv {
    return [YLT_CryptoTools dencryptType:kCCAlgorithmAES sourceData:sourceData keyData:[keyString dataUsingEncoding:NSUTF8StringEncoding] iv:iv];
}

@end
