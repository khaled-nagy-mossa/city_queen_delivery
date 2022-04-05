import 'dart:convert';
import 'dart:developer';

import 'package:delivery/model/order/order.dart';
import 'package:delivery/model/usage_criteria.dart';

class Delivery implements UsageCriteria {
  const Delivery({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.totalOrders,
    this.totalInDeliveryOrders,
    this.latestInDeliveryOrders,
    this.currentLocation,
    this.firebaseToken,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int totalOrders;
  final int totalInDeliveryOrders;
  final List<Order> latestInDeliveryOrders;
  final CurrentLocation currentLocation;
  final String firebaseToken;

  Delivery copyWith({
    int id,
    String name,
    String email,
    String phone,
    String image,
    int totalOrders,
    int totalInDeliveryOrders,
    List<Order> latestInDeliveryOrders,
    CurrentLocation currentLocation,
    String firebaseToken,
  }) {
    try {
      return Delivery(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        totalOrders: totalOrders ?? this.totalOrders,
        totalInDeliveryOrders:
            totalInDeliveryOrders ?? this.totalInDeliveryOrders,
        latestInDeliveryOrders:
            latestInDeliveryOrders ?? this.latestInDeliveryOrders,
        currentLocation: currentLocation ?? this.currentLocation,
        firebaseToken: firebaseToken ?? this.firebaseToken,
      );
    } catch (e) {
      log('Exception in OrderDeliveryMan.copyWith : $e');
      return const Delivery();
    }
  }

  factory Delivery.fromJson(String str) {
    if (str == null || str.isEmpty) return const Delivery();

    try {
      return Delivery.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in OrderDeliveryMan.fromJson : $e');
      return const Delivery();
    }
  }

  String toJson() => json.encode(toMap());

  factory Delivery.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const Delivery();

      return Delivery(
        id: json["id"] as int,
        name: json["name"] as String,
        email: json["email"] as String,
        phone: json["phone"] as String,
        image: json["image"] as String,
        totalOrders: json["total_orders"] as int,
        totalInDeliveryOrders: json["total_in_delivery_orders"] as int,
        latestInDeliveryOrders: List<Order>.from(
          (json["latest_in_delivery_orders"] as List).map(
            (x) => Order.fromMap(x as Map<String, dynamic>),
          ),
        ),
        currentLocation: CurrentLocation.fromMap(
          json["current_location"] as Map<String, dynamic>,
        ),
        firebaseToken: json["firebase_token"] as String,
      );
    } catch (e) {
      log('Exception in OrderDeliveryMan.fromMap : $e');
      return const Delivery();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "total_orders": totalOrders,
        "total_in_delivery_orders": totalInDeliveryOrders,
        "latest_in_delivery_orders": latestInDeliveryOrders == null
            ? null
            : List<dynamic>.from(latestInDeliveryOrders.map((x) => x.toMap())),
        "current_location": currentLocation?.toMap(),
        "firebase_token": firebaseToken,
      };
    } catch (e) {
      log('Exception in OrderDeliveryMan.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in OrderDeliveryMan.unusable : $e');

      return true;
    }
  }

  @override
  bool get usable {
    try {
      return id != null && name != null;
    } catch (e) {
      log('Exception in OrderDeliveryMan.unusable : $e');

      return true;
    }
  }
}

class CurrentLocation {
  const CurrentLocation({this.lat, this.lng});

  final double lat;
  final double lng;

  CurrentLocation copyWith({double lat, double lng}) {
    try {
      return CurrentLocation(lat: lat ?? this.lat, lng: lng ?? this.lng);
    } catch (e) {
      log('Exception in OrderCurrentLocation.copyWith : $e');
      return const CurrentLocation();
    }
  }

  factory CurrentLocation.fromJson(String str) {
    if (str == null || str.isEmpty) return const CurrentLocation();
    try {
      return CurrentLocation.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in OrderCurrentLocation.fromJson : $e');
      return const CurrentLocation();
    }
  }

  String toJson() => json.encode(toMap());

  factory CurrentLocation.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const CurrentLocation();

      return CurrentLocation(
        lat: json['lat'] as double,
        lng: json['lng'] as double,
      );
    } catch (e) {
      log('Exception in OrderCurrentLocation.fromMap : $e');
      return const CurrentLocation();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{'lat': lat, 'lng': lng};
    } catch (e) {
      log('Exception in OrderCurrentLocation.toMap : $e');
      return <String, dynamic>{};
    }
  }
}
