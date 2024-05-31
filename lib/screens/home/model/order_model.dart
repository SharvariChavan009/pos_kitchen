// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    List<Datum>? data;

    OrderModel({
        this.data,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? orderNo;
    String? status;
    int? tableNo;
    List<Item>? items;

    Datum({
        this.orderNo,
        this.status,
        this.tableNo,
        this.items,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderNo: json["order_no"],
        status: json["status"],
        tableNo: json["table_no"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_no": orderNo,
        "status": status,
        "table_no": tableNo,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    String? name;
    int? quatity;

    Item({
        this.name,
        this.quatity,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        quatity: json["quatity"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "quatity": quatity,
    };
}
