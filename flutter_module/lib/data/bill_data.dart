// To parse this JSON data, do
//
//     final billData = billDataFromJson(jsonString);
// 转换工具网址：https://app.quicktype.io/

import 'dart:convert';

BillData billDataFromJson(String str) => BillData.fromJson(json.decode(str));

String billDataToJson(BillData data) => json.encode(data.toJson());

class BillData {
  int code;
  String message;
  List<Datum> data;
  bool success;
  dynamic platScrtSgn;
  bool signatureRequired;

  BillData({
    required this.code,
    required this.message,
    required this.data,
    required this.success,
    this.platScrtSgn,
    required this.signatureRequired,
  });

  factory BillData.fromJson(Map<String, dynamic> json) => BillData(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
        platScrtSgn: json["platScrtSgn"],
        signatureRequired: json["signatureRequired"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
        "platScrtSgn": platScrtSgn,
        "signatureRequired": signatureRequired,
      };
}

class Datum {
  String innerBillNo;
  String orderNo;
  String shipId;
  String collectCode;
  DateTime operateTime;
  String orderStatus;
  String orderStatusName;
  String payStatus;
  List<String> buttonList;
  String drillDownType;
  String payFee;
  String latestArrivalTime;
  String senderCity;
  String senderName;
  String receiverCity;
  String receiverName;

  Datum({
    required this.innerBillNo,
    required this.orderNo,
    required this.shipId,
    required this.collectCode,
    required this.operateTime,
    required this.orderStatus,
    required this.orderStatusName,
    required this.payStatus,
    required this.buttonList,
    required this.drillDownType,
    required this.payFee,
    required this.latestArrivalTime,
    required this.senderCity,
    required this.senderName,
    required this.receiverCity,
    required this.receiverName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        innerBillNo: json["innerBillNo"],
        orderNo: json["orderNo"],
        shipId: json["shipId"],
        collectCode: json["collectCode"],
        operateTime: DateTime.parse(json["operateTime"]),
        orderStatus: json["orderStatus"],
        orderStatusName: json["orderStatusName"],
        payStatus: json["payStatus"],
        buttonList: List<String>.from(json["buttonList"].map((x) => x)),
        drillDownType: json["drillDownType"],
        payFee: json["payFee"],
        latestArrivalTime: json["latestArrivalTime"],
        senderCity: json["senderCity"],
        senderName: json["senderName"],
        receiverCity: json["receiverCity"],
        receiverName: json["receiverName"],
      );

  Map<String, dynamic> toJson() => {
        "innerBillNo": innerBillNo,
        "orderNo": orderNo,
        "shipId": shipId,
        "collectCode": collectCode,
        "operateTime": operateTime.toIso8601String(),
        "orderStatus": orderStatus,
        "orderStatusName": orderStatusName,
        "payStatus": payStatus,
        "buttonList": List<dynamic>.from(buttonList.map((x) => x)),
        "drillDownType": drillDownType,
        "payFee": payFee,
        "latestArrivalTime": latestArrivalTime,
        "senderCity": senderCity,
        "senderName": senderName,
        "receiverCity": receiverCity,
        "receiverName": receiverName,
      };
}

final allBillData = [
  //UN_TAKEN( “待取件”),UN_PAY(“待支付”),
  // IN_TRANSIT(“运输中”),SIGNED(“已签收”),CANCELED(“已取消”),
  {
    "orderNo": "160085313807511234",
    "collectCode": "6460",
    "operateTime": "2022-10-08 14:26:23",
    "orderStatus": "UN_TAKEN",
    "orderStatusName": "待取件",
    "buttonList": ["cancelButton"],
    "drillDownType": "orderDetail",
    "payFee": "0.00",
    "senderCity": "北京市",
    "senderName": "张三",
    "receiverCity": "上海",
    "receiverName": "王五",
  },
  {
    "orderNo": "160085313807513378",
    "collectCode": "",
    "operateTime": "2022-12-08 14:26:23",
    "orderStatus": "UN_PAY",
    "orderStatusName": "待支付",
    "buttonList": ["cancelButton", "payButton"],
    "drillDownType": "orderDetail",
    "payFee": "13.41",
    "senderCity": "天津市",
    "senderName": "张暃",
    "receiverCity": "武汉市",
    "receiverName": "刘洋",
  },
  {
    "orderNo": "160085313807516736",
    "collectCode": "",
    "operateTime": "2023-11-28 14:36:23",
    "orderStatus": "IN_TRANSIT",
    "orderStatusName": "运输中",
    "buttonList": ["traceButton"],
    "drillDownType": "orderTrace",
    "payFee": "23.76",
    "senderCity": "郑州市",
    "senderName": "程暃",
    "receiverCity": "厦门市",
    "receiverName": "周洋",
  },
  {
    "orderNo": "160087391807516736",
    "collectCode": "",
    "operateTime": "2033-08-28 04:36:23",
    "orderStatus": "SIGNED",
    "orderStatusName": "已签收",
    "buttonList": ["traceButton"],
    "drillDownType": "orderTrace",
    "payFee": "53.82",
    "senderCity": "澳门",
    "senderName": "程宇",
    "receiverCity": "合肥市",
    "receiverName": "刘贝",
  },
  {
    "orderNo": "160087391807516736",
    "collectCode": "",
    "operateTime": "2043-01-18 04:16:23",
    "orderStatus": "CANCELED",
    "orderStatusName": "已取消",
    "buttonList": ["cancelButton"],
    "drillDownType": "",
    "payFee": "0.00",
    "senderCity": "珠海",
    "senderName": "李政",
    "receiverCity": "青岛",
    "receiverName": "刘柳",
  },
];

final doingBillData = [
  //UN_TAKEN( “待取件”),UN_PAY(“待支付”),
  // IN_TRANSIT(“运输中”),SIGNED(“已签收”),
  {
    "orderNo": "160085313807516736",
    "collectCode": "",
    "operateTime": "2023-11-28 14:36:23",
    "orderStatus": "IN_TRANSIT",
    "orderStatusName": "运输中",
    "buttonList": ["traceButton"],
    "drillDownType": "orderTrace",
    "payFee": "23.76",
    "senderCity": "郑州市",
    "senderName": "程暃",
    "receiverCity": "厦门市",
    "receiverName": "周洋",
  },
  {
    "orderNo": "160085313807513378",
    "collectCode": "",
    "operateTime": "2022-12-08 14:26:23",
    "orderStatus": "UN_PAY",
    "orderStatusName": "待支付",
    "buttonList": ["cancelButton", "payButton"],
    "drillDownType": "orderDetail",
    "payFee": "13.41",
    "senderCity": "天津市",
    "senderName": "张暃",
    "receiverCity": "武汉市",
    "receiverName": "刘洋",
  },
];

final doneBillData = [
  //UN_TAKEN( “待取件”),UN_PAY(“待支付”),
  // IN_TRANSIT(“运输中”),SIGNED(“已签收”),
  {
    "orderNo": "160087391807516736",
    "collectCode": "",
    "operateTime": "2033-08-28 04:36:23",
    "orderStatus": "SIGNED",
    "orderStatusName": "已签收",
    "buttonList": ["traceButton"],
    "drillDownType": "orderTrace",
    "payFee": "53.82",
    "senderCity": "澳门",
    "senderName": "程宇",
    "receiverCity": "合肥市",
    "receiverName": "刘贝",
  },
];

final cancelBillData = [
  //UN_TAKEN( “待取件”),UN_PAY(“待支付”),
  // IN_TRANSIT(“运输中”),SIGNED(“已签收”),CANCELED(“已取消”),
  {
    "orderNo": "160087391807516736",
    "collectCode": "",
    "operateTime": "2043-01-18 04:16:23",
    "orderStatus": "CANCELED",
    "orderStatusName": "已取消",
    "buttonList": ["cancelButton"],
    "drillDownType": "",
    "payFee": "0.00",
    "senderCity": "珠海",
    "senderName": "李政",
    "receiverCity": "青岛",
    "receiverName": "刘柳",
  },
];

final trackBillData = [
  //UN_TAKEN( “待取件”),UN_PAY(“待支付”),
  // IN_TRANSIT(“运输中”),SIGNED(“已签收”),CANCELED(“已取消”),
  {
    "operateTime": "2023-06-07 20:23:20",
    "orderStatus": "SIGNED",
    "orderStatusName": "已签收",
    "orderStatusDetails":
        "包裹已签收!(凭取件码)如有问题请电联:兔喜生活+176XXXX2405/XXXX138XXXX4098，投诉电话:021-38765149",
  },
  {
    "operateTime": "2023-06-07 05:07:25",
    "orderStatus": "DISPATCH",
    "orderStatusName": "派送中",
    "orderStatusDetails":
        "上海青浦赵巷中部网点】的兔兔快递员XXXX138XXXX4098正在派件(可放心接听952300专属热线)，投诉电话:021-38765149。今天的兔兔，怀揣包裹，卯足干劲，为您“加吉”派送中",
  },
  {
    "operateTime": "2023-06-07 05:07:25",
    "orderStatus": "IN_TRANSIT",
    "orderStatusName": "运输中",
    "orderStatusDetails": "快件离开【上海浦西转运中心B1】已发往【上海青浦赵巷中部网点】",
  },
  {
    "operateTime": "2023-06-07 04:52:47",
    "orderStatus": "IN_TRANSIT",
    "orderStatusName": "运输中",
    "orderStatusDetails": "快件到达【上海浦西转运中心B1】",
  },
  {
    "operateTime": "2023-06-05 20:47:45",
    "orderStatus": "IN_TRANSIT",
    "orderStatusName": "运输中",
    "orderStatusDetails": "快件离开【重庆转运中心】已发往【上海浦西转运中心B1】",
  },
  {
    "operateTime": "2023-06-05 20:43:53",
    "orderStatus": "IN_TRANSIT",
    "orderStatusName": "运输中",
    "orderStatusDetails": "快件到达【重庆转运中心】",
  },
  {
    "operateTime": "2023-06-05 16:17:59",
    "orderStatus": "IN_TRANSIT",
    "orderStatusName": "运输中",
    "orderStatusDetails": "快件离开【重庆巴南界石网点】已发往【重庆转运中心】",
  },
  {
    "operateTime": "2023-06-05 16:00:29",
    "orderStatus": "TAKE",
    "orderStatusName": "已取件",
    "orderStatusDetails": "重庆巴南界石网点】的XXXX(152XXXX8395)已取件，投诉电话:023-62321472",
  },
  {
    "operateTime": "2023-06-05 11:50:58",
    "orderStatus": "UN_TAKE",
    "orderStatusName": "待取件",
    "orderStatusDetails": "商家已发货，正在通知极兔速递取件",
  },
];

final contractData = [
  "1、快递服务法律关系和服务范围：本协议经寄件人签名收寄员收取快件后成立生效，由在运单上印制企业名称全称或者盖章的收寄快递企业与寄件人建立快递服务合关系并提供快递服务（代收货款须另签协议），承诺及时安全地交付快件",
  "2、运单填写：寄件人须用力工整地手写或打印运单,清楚下单准确完整、如实地填写寄件人和收件人的姓名、地址、联系电话以及内件品名，数量、付费方式还须填写中报内件价值即保价价值等内容并签名寄件人不得或虚报内件的性质，品名、数量内件价值等真实情况，否须承担相应责任",
  "3、包装：寄件人应根据内件性质,在满足装卸、运送、派送投递等快递环节要求的情况下对快件进行必要和足够的包装,并保证快件不会污染和损害其他快件",
  "4、禁寄寄件人承诺不得交寄以下禁寄物品和危险品(详细可查阅国家邮政局《禁寄物品指导目录及处理办法》)，者须承担相应责任:"
];
