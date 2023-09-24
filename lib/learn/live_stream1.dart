// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wato/secrets.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

final userID = Random().nextInt(10000).toString();

class LiveScreen1 extends StatelessWidget {
  const LiveScreen1({Key? key,
    required this.liveID,
    this.isHost = true,})
      : super(key: key);

  final  String liveID;
  final bool isHost;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  ZegoUIKitPrebuiltLiveStreaming(
        appID: Secrets.appID,
        appSign: Secrets.appSign,
        userID: userID,
        userName: 'user_$userID',
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            :ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );

  }

}