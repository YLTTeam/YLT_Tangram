//
//  YLT_CryptoTools.m
//  YLT_Crypto
//
//  Created by YLT on 2017/10/12.
//

#import "YLT_CryptoTools.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation YLT_CryptoTools

/**
 AES、DES 加密数据
 
 @param algorithm
 kCCAlgorithmAES     高级加密标准，128位(默认)
 kCCAlgorithmDES     数据加密标准
 @param sourceData 源内容
 @param keyData 密钥
 @param iv 向量(8字节)
 @return 加密后Data
 */
+ (NSData *)encryptType:(uint32_t)algorithm sourceData:(NSData *)sourceData keyData:(NSData *)keyData iv:(NSData *)iv {
    int keySize = 0;
    int blockSize = 0;
    if (algorithm == kCCAlgorithmAES) {
        keySize = kCCKeySizeAES128;
        blockSize = kCCBlockSizeAES128;
    } else if (algorithm == kCCAlgorithmDES) {
        keySize = kCCKeySizeDES;
        blockSize = kCCBlockSizeDES;
    } else {
        return nil;
    }
    uint8_t cKey[keySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:keySize];
    
    // 设置iv
    /*
     kCCOptionPKCS7Padding                      CBC 的加密方式
     kCCOptionPKCS7Padding | kCCOptionECBMode   ECB 的加密方式
     */
    uint8_t cIv[blockSize];
    bzero(cIv, blockSize);
    int option = 0;
    if (iv) {
        [iv getBytes:cIv length:blockSize];
        option = kCCOptionPKCS7Padding;
    } else {
        option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    }
    
    size_t bufferSize = [sourceData length] + blockSize;
    void *buffer = malloc(bufferSize);
    
    // 开始加密
    size_t encryptedSize = 0;
    /***
     CCCrypt 对称加密算法的核心函数(加密/解密)
     参数:
     1.kCCEncrypt  加密/kCCDecrypt 解密
     2.加密算法,默认使用的是  AES/DES
     3.加密选项  ECB/CBC
     kCCOptionPKCS7Padding                      CBC 的加密方式
     kCCOptionPKCS7Padding | kCCOptionECBMode   ECB 的加密方式
     4.加密密钥
     5.密钥长度
     6.iv 初始化向量,ECB 不需要指定
     7.加密的数据
     8.加密的数据的长度
     9.密文的内存地址
     10.密文缓冲区的大小
     11.加密结果大小
     */
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          algorithm,
                                          option,
                                          cKey,
                                          keySize,
                                          cIv,
                                          [sourceData bytes],
                                          [sourceData length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 加密失败|状态编码: %d", cryptStatus);
    }
    
    return result;
}

/**
 AES、DES 解密数据
 
 @param algorithm
 kCCAlgorithmAES     高级加密标准，128位(默认)
 kCCAlgorithmDES     数据加密标准
 @param sourceData 源内容
 @param keyData 密钥
 @param iv 向量(8字节)
 @return 解密后的字串
 */
+ (NSData *)dencryptType:(uint32_t)algorithm sourceData:(NSData *)sourceData keyData:(NSData *)keyData iv:(NSData *)iv {
    int keySize = 0;
    int blockSize = 0;
    if (algorithm == kCCAlgorithmAES) {
        keySize = kCCKeySizeAES128;
        blockSize = kCCBlockSizeAES128;
    } else if (algorithm == kCCAlgorithmDES) {
        keySize = kCCKeySizeDES;
        blockSize = kCCBlockSizeDES;
    } else {
        return nil;
    }
    // 设置秘钥
    uint8_t cKey[keySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:keySize];
    
    // 设置iv
    uint8_t cIv[blockSize];
    bzero(cIv, blockSize);
    int option = 0;
    if (iv) {
        [iv getBytes:cIv length:blockSize];
        option = kCCOptionPKCS7Padding;
    } else {
        option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    }
    
    // 设置输出缓冲区
    size_t bufferSize = [sourceData length] + blockSize;
    void *buffer = malloc(bufferSize);
    
    // 开始解密
    size_t decryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          algorithm,
                                          option,
                                          cKey,
                                          keySize,
                                          cIv,
                                          [sourceData bytes],
                                          [sourceData length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 解密失败|状态编码: %d", cryptStatus);
    }
    
    return result;
}





/**
 AES、DES 加密字符串
 
 @param algorithm
 kCCAlgorithmAES     高级加密标准，128位(默认)
 kCCAlgorithmDES     数据加密标准
 @param sourceString 源字串
 @param keyString 密钥
 @param iv 向量(8字节)
 @return 加密后的Base64字串
 */
+ (NSString *)encryptType:(uint32_t)algorithm sourceString:(NSString *)sourceString keyString:(NSString *)keyString iv:(NSData *)iv {
    int keySize = 0;
    int blockSize = 0;
    if (algorithm == kCCAlgorithmAES) {
        keySize = kCCKeySizeAES128;
        blockSize = kCCBlockSizeAES128;
    } else if (algorithm == kCCAlgorithmDES) {
        keySize = kCCKeySizeDES;
        blockSize = kCCBlockSizeDES;
    } else {
        return @"";
    }
    NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[keySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:keySize];
    
    // 设置iv
    /*
     kCCOptionPKCS7Padding                      CBC 的加密方式
     kCCOptionPKCS7Padding | kCCOptionECBMode   ECB 的加密方式
     */
    uint8_t cIv[blockSize];
    bzero(cIv, blockSize);
    int option = 0;
    if (iv) {
        [iv getBytes:cIv length:blockSize];
        option = kCCOptionPKCS7Padding;
    } else {
        option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    }
    
    // 设置输出缓冲区
    NSData *data = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
    size_t bufferSize = [data length] + blockSize;
    void *buffer = malloc(bufferSize);
    
    // 开始加密
    size_t encryptedSize = 0;
    /***
     CCCrypt 对称加密算法的核心函数(加密/解密)
     参数:
     1.kCCEncrypt  加密/kCCDecrypt 解密
     2.加密算法,默认使用的是  AES/DES
     3.加密选项  ECB/CBC
     kCCOptionPKCS7Padding                      CBC 的加密方式
     kCCOptionPKCS7Padding | kCCOptionECBMode   ECB 的加密方式
     4.加密密钥
     5.密钥长度
     6.iv 初始化向量,ECB 不需要指定
     7.加密的数据
     8.加密的数据的长度
     9.密文的内存地址
     10.密文缓冲区的大小
     11.加密结果大小
     */
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          algorithm,
                                          option,
                                          cKey,
                                          keySize,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 加密失败|状态编码: %d", cryptStatus);
    }
    
    return [result base64EncodedStringWithOptions:0];
}

/**
 AES、DES 解密字符串
 
 @param algorithm
 kCCAlgorithmAES     高级加密标准，128位(默认)
 kCCAlgorithmDES     数据加密标准
 @param sourceString 源字串
 @param keyString 密钥
 @param iv 向量(8字节)
 @return 解密后的字串
 */
+ (NSString *)dencrypt:(uint32_t)algorithm sourceString:(NSString *)sourceString keyString:(NSString *)keyString iv:(NSData *)iv {
    int keySize = 0;
    int blockSize = 0;
    if (algorithm == kCCAlgorithmAES) {
        keySize = kCCKeySizeAES128;
        blockSize = kCCBlockSizeAES128;
    } else if (algorithm == kCCAlgorithmDES) {
        keySize = kCCKeySizeDES;
        blockSize = kCCBlockSizeDES;
    } else {
        return @"";
    }
    // 设置秘钥
    NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[keySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:keySize];
    
    // 设置iv
    uint8_t cIv[blockSize];
    bzero(cIv, blockSize);
    int option = 0;
    if (iv) {
        [iv getBytes:cIv length:blockSize];
        option = kCCOptionPKCS7Padding;
    } else {
        option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    }
    
    // 设置输出缓冲区
    NSData *data = [[NSData alloc] initWithBase64EncodedString:sourceString options:0];
    size_t bufferSize = [data length] + blockSize;
    void *buffer = malloc(bufferSize);
    
    // 开始解密
    size_t decryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          algorithm,
                                          option,
                                          cKey,
                                          keySize,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 解密失败|状态编码: %d", cryptStatus);
    }
    
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}




@end
