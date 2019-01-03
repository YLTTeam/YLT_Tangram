//
//  YLT_CryptoTools.h
//  YLT_Crypto
//
//  Created by YLT on 2017/10/12.
//

#import <Foundation/Foundation.h>

@interface YLT_CryptoTools : NSObject

/**
 AES、DES 加密数据
 
 @param algorithm
 kCCAlgorithmAES     高级加密标准，128位(默认)
 kCCAlgorithmDES     数据加密标准
 @param sourceData   源内容
 @param keyData 密钥
 @param iv 向量(8字节)
 @return 加密后data
 */
+ (NSData *)encryptType:(uint32_t)algorithm sourceData:(NSData *)sourceData keyData:(NSData *)keyData iv:(NSData *)iv;

/**
 AES、DES 解密字数据
 
 @param algorithm
 kCCAlgorithmAES     高级加密标准，128位(默认)
 kCCAlgorithmDES     数据加密标准
 @param sourceData  源内容
 @param keyData 密钥
 @param iv 向量(8字节)
 @return 解密后的data
 */
+ (NSData *)dencryptType:(uint32_t)algorithm sourceData:(NSData *)sourceData keyData:(NSData *)keyData iv:(NSData *)iv;

@end
