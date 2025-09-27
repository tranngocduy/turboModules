//
//  RCTNativeTurboModules.m
//  nativeModules
//
//  Created by Admin on 27/9/25.
//

#import "RCTNativeTurboModules.h"

@implementation RCTNativeTurboModules {
  bool hasListeners;
}

+ (NSString *)moduleName {
  return @"NativeTurboModules";
}

+ (bool)requiresMainQueueSetup {
  return YES;
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"EventReminder"]; // Add all event names your module will emit
}

- (void)startObserving {
  hasListeners = YES;
}

- (void)stopObserving {
  hasListeners = NO;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params {
  return std::make_shared<facebook::react::NativeTurboModulesSpecJSI>(params);
}

- (void)getMessage:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject {
  NSString *response = @"Hello from iOS With Message";
  resolve(response);
}

- (void)sendMessage:(nonnull NSString *)message { 
  NSLog(@"[iOS] Received from JS: %@", message);
}

- (void)sendWithCallback:(nonnull RCTResponseSenderBlock)callback {
  NSString *response = @"Hello from iOS With CallBack";
  callback(@[response]);
}

- (void)startSendingEvents {
  
  if (!hasListeners) {
      NSLog(@"[iOS] No listeners, not sending events");
      return;
    }

    for (int i = 1; i <= 8; i++) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * NSEC_PER_SEC)),
                     dispatch_get_main_queue(), ^{
        if (!self->hasListeners) return;
        NSString *msg = [NSString stringWithFormat:@"Event at %f", [[NSDate date] timeIntervalSince1970]];
        [self sendEventWithName:@"EventReminder" body:@{@"message": msg}];
      });
    }
}

@end
