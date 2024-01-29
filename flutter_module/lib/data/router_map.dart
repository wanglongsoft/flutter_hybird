import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/page/bruno_component.dart';
import 'package:flutter_module/page/check_express.dart';
import 'package:flutter_module/page/edit_recipient_sender.dart';
import 'package:flutter_module/page/express_track.dart';
import 'package:flutter_module/page/freight_detail.dart';
import 'package:flutter_module/page/order_result.dart';
import 'package:flutter_module/page/reservation_express.dart';

// 配置路由
Map<String, FlutterBoostRouteFactory> routerMap = {
  'check_express': (settings, uniqueId) {
    return PageRouteBuilder<dynamic>(
        settings: settings, pageBuilder: (_, __, ___) {
          print("arguments ${settings.arguments}");
          return const CheckExpress();
        });
  },
  'express_track': (settings, uniqueId) {
    return PageRouteBuilder<dynamic>(
        settings: settings, pageBuilder: (_, __, ___) => const ExpressTrack());
  },
  'reservation_express': (settings, uniqueId) {
    return PageRouteBuilder<dynamic>(
        settings: settings,
        pageBuilder: (_, __, ___) => const ReservationExpress());
  },
  'edit_recipient_sender': (settings, uniqueId) {
    return PageRouteBuilder<dynamic>(
        settings: settings,
        pageBuilder: (_, __, ___) => EditRecipientSender(
            argument: settings.arguments as Map<String, dynamic>));
  },
  'freight_detail': (settings, uniqueId) {
    return PageRouteBuilder<dynamic>(
        settings: settings,
        pageBuilder: (_, __, ___) => FreightDetail(
            argument: settings.arguments as Map<String, dynamic>));
  },
  'bruno_component': (settings, uniqueId) {
    return PageRouteBuilder<dynamic>(
        settings: settings, pageBuilder: (_, __, ___) => const BrunoComponent());
  },
  'order_result': (settings, uniqueId) {
    return PageRouteBuilder<dynamic>(
        settings: settings, pageBuilder: (_, __, ___) {
      return OrderResult(
          argument: settings.arguments as Map<String, dynamic>);
    });
  },
};
