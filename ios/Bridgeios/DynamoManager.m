//
//  DynamoManager.m
//  Bridgeios
//
//  Created by digital on 15/07/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "DynamoManager.h"
#import <React/RCTLog.h>

@implementation DynamoManager {
  bool hasListeners;
}

-(void)startObserving {
  hasListeners = YES;
}

-(void)stopObserving {
  hasListeners = NO;
}

-(id)init {
  
  NSLog(@"init start");
  RCTLogInfo(@"init start");
  
  self.lib = [MTSCRA new];
  self.lib.delegate = self;
  
  [self.lib setDeviceType:(MAGTEKIDYNAMO)];
  [self.lib setDeviceProtocolString:@"com.magtek.idynamo"];

  NSLog(@"init end");
  RCTLogInfo(@"init end");

  
  return   [super init];
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(openDevice) {
  RCTLogInfo(@"Pretending to open device");
  

  [self.lib openDevice];
  
}


RCT_EXPORT_METHOD(closeDevice) {

  RCTLogInfo(@"Pretending to close device");
  
  [self.lib closeDevice];

}


- (NSArray<NSString *> *)supportedEvents
{
  return @[@"DataReceived", @"CardSwipeDidStart", @"CardSwipeDidGetTransError", @"DeviceConnectionDidChange"];
}


RCT_EXPORT_METHOD(isDeviceOpened:(RCTResponseSenderBlock) callback) {
  
  RCTLogInfo(@"Pretending to is device opened");
  
  NSString* opened = [self.lib isDeviceOpened] ? @"true" : @"false";
  
  callback(@[[NSNull null], opened]);
  
}


RCT_EXPORT_METHOD(isDeviceConnected:(RCTResponseSenderBlock) callback) {
  
  RCTLogInfo(@"Pretending to is device connected");
  
  NSString* connected = [self.lib isDeviceConnected] ? @"true" : @"false";
  
  callback(@[[NSNull null], connected]);
  
}



- (void) onDataReceived: (MTCardData*)cardDataObj instance:(id)instance {
  
  NSString* data = [NSString stringWithFormat:
                              @"Track.Status: %@\n\n"
                              "Track1.Status: %@\n\n"
                              "Track2.Status: %@\n\n"
                              "Track3.Status: %@\n\n"
                              "Encryption.Status: %@\n\n"
                              "Battery.Level: %ld\n\n"
                              "Swipe.Count: %ld\n\n"
                              "Track.Masked: %@\n\n"
                              "Track1.Masked: %@\n\n"
                              "Track2.Masked: %@\n\n"
                              "Track3.Masked: %@\n\n"
                              "Track1.Encrypted: %@\n\n"
                              "Track2.Encrypted: %@\n\n"
                              "Track3.Encrypted: %@\n\n"
                              "Card.PAN: %@\n\n"
                              "MagnePrint.Encrypted: %@\n\n"
                              "MagnePrint.Length: %i\n\n"
                              "MagnePrint.Status: %@\n\n"
                              "SessionID: %@\n\n"
                              "Card.IIN: %@\n\n"
                              "Card.Name: %@\n\n"
                              "Card.Last4: %@\n\n"
                              "Card.ExpDate: %@\n\n"
                              "Card.ExpDateMonth: %@\n\n"
                              "Card.ExpDateYear: %@\n\n"
                              "Card.SvcCode: %@\n\n"
                              "Card.PANLength: %ld\n\n"
                              "KSN: %@\n\n"
                              "Device.SerialNumber: %@\n\n"
                              "MagTek SN: %@\n\n"
                              "Firmware Part Number: %@\n\n"
                              "Device Model Name: %@\n\n"
                              "TLV Payload: %@\n\n"
                              "DeviceCapMSR: %@\n\n"
                              "Operation.Status: %@\n\n"
                              "Card.Status: %@\n\n"
                              "Raw Data: \n\n%@",
                              cardDataObj.trackDecodeStatus,
                              cardDataObj.track1DecodeStatus,
                              cardDataObj.track2DecodeStatus,
                              cardDataObj.track3DecodeStatus,
                              cardDataObj.encryptionStatus,
                              cardDataObj.batteryLevel,
                              cardDataObj.swipeCount,
                              cardDataObj.maskedTracks,
                              cardDataObj.maskedTrack1,
                              cardDataObj.maskedTrack2,
                              cardDataObj.maskedTrack3,
                              cardDataObj.encryptedTrack1,
                              cardDataObj.encryptedTrack2,
                              cardDataObj.encryptedTrack3,
                              cardDataObj.cardPAN,
                              cardDataObj.encryptedMagneprint,
                              cardDataObj.magnePrintLength,
                              cardDataObj.magneprintStatus,
                              cardDataObj.encrypedSessionID,
                              cardDataObj.cardIIN,
                              cardDataObj.cardName,
                              cardDataObj.cardLast4,
                              cardDataObj.cardExpDate,
                              cardDataObj.cardExpDateMonth,
                              cardDataObj.cardExpDateYear,
                              cardDataObj.cardServiceCode,
                              cardDataObj.cardPANLength,
                              cardDataObj.deviceKSN,
                              cardDataObj.deviceSerialNumber,
                              cardDataObj.deviceSerialNumberMagTek,
                              cardDataObj.firmware,
                              cardDataObj.deviceName,
                              [(MTSCRA*)instance getTLVPayload],
                              cardDataObj.deviceCaps,
                              [(MTSCRA*)instance getOperationStatus],
                              cardDataObj.cardStatus,
                              [(MTSCRA*)instance getResponseData]];
  
  NSLog(@"%@", data);
  
  if (hasListeners) {
    [self sendEventWithName:@"DataReceived" body:@{@"payload": data}];  
  }
  
  
  
}


- (void) cardSwipeDidStart:(id)instance {
  [self sendEventWithName:@"CardSwipeDidStart" body:@{@"CardSwipeDidStart": @"true"}];
}
- (void) cardSwipeDidGetTransError {
  [self sendEventWithName:@"CardSwipeDidGetTransError" body:@{@"CardSwipeDidGetTransError": @"true"}];
}
- (void) onDeviceConnectionDidChange:(MTSCRADeviceType)deviceType connected:(BOOL) connected instance:(id)instance {
  [self sendEventWithName:@"DeviceConnectionDidChange" body:@{@"DeviceConnectionDidChange": @"true"}];;
}



@end
