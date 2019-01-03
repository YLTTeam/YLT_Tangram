//
//  YLT_RSACrypto.h
//  YLT_Crypto
//
//  Created by YLT on 2017/10/12.
//

#import <Foundation/Foundation.h>

@interface YLT_RSACrypto : NSObject

+ (instancetype)sharedInstance;

/**
 *  生成密钥对
 *
 *  @param keySize 密钥尺寸，可选数值(512/1024/2048)
 */
- (void)generateKeyPair:(NSUInteger)keySize;

/**
 *  加载公钥
 *
 *  @param publicKeyPath 公钥路径
 */
- (void)loadPublicKey:(NSString *)publicKeyPath;

/**
 *  加载私钥
 *
 *  @param privateKeyPath p12文件路径
 *  @param password       p12文件密码
 */
- (void)loadPrivateKey:(NSString *)privateKeyPath password:(NSString *)password;

/**
 *  加密数据
 *
 *  @param plainData 明文数据
 *  @return 密文数据
 */
- (NSData *)encryptData:(NSData *)plainData;

/**
 *  解密数据
 *
 *  @param cipherData 密文数据
 *  @return 明文数据
 */
- (NSData *)decryptData:(NSData *)cipherData;

@end
