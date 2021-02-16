import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class NotifConfig {
  Channel channel;

  Future<Event> initPusher() async {
    try {
      await Pusher.init("d6275cc25963fa559ee8", PusherOptions(cluster: "ap1"),
          enableLogging: true);
      print("maid");
      //connect
      await Pusher.connect(
          onConnectionStateChange: (x) async {},
          onError: (x) {
            debugPrint("Error: ${x.message}");
          });

//subscribe
      channel = await Pusher.subscribe("123456");
      await channel.bind('message', (x) async {
        print("halo ${x.data}");

        return x;
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
