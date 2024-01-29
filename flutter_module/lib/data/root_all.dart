import 'package:flutter/material.dart';
import 'package:flutter_module/page/check_express.dart';
import 'package:flutter_module/page/edit_recipient_sender.dart';
import 'package:flutter_module/page/express_track.dart';
import 'package:flutter_module/page/freight_detail.dart';
import 'package:flutter_module/page/order_result.dart';
import 'package:flutter_module/page/reservation_express.dart';

final routes = {
  'check_express' : (context) => const CheckExpress(),
  'express_track' : (context) => const ExpressTrack(),
  'reservation_express' : (context) => const ReservationExpress(),
  'edit_recipient_sender' :  (context, {arguments}) => EditRecipientSender(argument:arguments),
  //携带入参示列
  'freight_detail' :  (context, {arguments}) => FreightDetail(argument:arguments),
  'order_result' :  (context, {arguments}) => OrderResult(argument:arguments),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (settings.arguments != null) {
    final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments));
    return route;
  } else {
    final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context));
    return route;
  }
};