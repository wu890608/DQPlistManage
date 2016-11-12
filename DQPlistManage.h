//
//  DQPlistManage.h
//  DQPlistManage
//
//  Created by wu on 2016/11/5.
//  Copyright © 2016年 wu. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define MYLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__)
#else
#define MYLog(...)
#endif


@interface DQPlistManage : NSObject
/**
 单例模式
 */
+(DQPlistManage*)sharedInstance;
/**
 创建相应的Plist文件
 */
-(void)initPlistWithPlistName:(NSString*)plistName;

/**
 获取对应Plist文件的路径
 */
-(NSString*)getPlistPathWithPlistName:(NSString*)plistName;
/**
 移除相应Plist文件的Key
 */
-(void)plist:(NSString*)plistName removeBookWithKey:(NSString *)key;
/**
 写入数据到相应的Plist文件
 */
-(void)plist:(NSString*)plistName writePlist:(NSMutableDictionary*)dictionary forKey:(NSString *)key;
/**
 判断沙盒中名为plistname的文件是否存在
 */
-(BOOL)isPlistFileExistshWithPlistName:(NSString*)plistName;
/**
 获取相应Plist文件的内容数量
 */
-(NSInteger)getCountWithPlistName:(NSString*)plistName;
/**
 读取对应Plist内容
 */
-(NSMutableDictionary*)readPlistName:(NSString*)plistName;
/**
 删除相应的Plist文件
 */
-(void)deletePlistWithplist:(NSString*)plistName;
/**
 判断相应Plist文件是否有Key
 */
-(BOOL)plist:(NSString*)plistName isBookExistsForKey:(NSString*)key;
/**
 更改一条数据，就是把dictionary内key重写
 */
-(void)plist:(NSString*)plistName replaceDictionary:(NSMutableDictionary *)newDictionary withDictionaryKey:(NSString *)key;
@end
