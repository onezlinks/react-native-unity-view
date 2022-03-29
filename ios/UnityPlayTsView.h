#import <Foundation/Foundation.h>
#import <React/RCTView.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTBridgeModule.h>
#import <UnityFramework/NativeCallProxy.h>

@interface UnityPlayTsView : RCTView <RCTBridgeModule, NativeCallsProtocol>

@property (nonatomic, strong) UIView* _Nullable uView;

@property (nonatomic, copy) RCTBubblingEventBlock _Nullable onUnityMessage;

+ (void)UnityPostMessage:(NSString* _Nonnull )gameObject methodName:(NSString* _Nonnull)methodName message:(NSString* _Nonnull) message;

@end
