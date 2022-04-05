import 'dart:convert';

import 'delivery.dart';
import 'order_label.dart';

class DriverProfile {
  DriverProfile({
    this.profileData,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.totalCollected,
    this.totalEarning,
    this.counts,
  });

  final Delivery profileData;
  final String name;
  final String phone;
  final String email;
  final String image;
  final String totalCollected;
  final String totalEarning;
  final List<OrderLabel> counts;

  DriverProfile copyWith({
    Delivery profileData,
    String name,
    String phone,
    String email,
    String image,
    String totalCollected,
    String totalEarning,
    List<OrderLabel> counts,
  }) =>
      DriverProfile(
        profileData: profileData ?? this.profileData,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        image: image ?? this.image,
        totalCollected: totalCollected ?? this.totalCollected,
        totalEarning: totalEarning ?? this.totalEarning,
        counts: counts ?? this.counts,
      );

  factory DriverProfile.fromJson(String str) {
    return DriverProfile.fromMap(json.decode(str) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory DriverProfile.fromMap(Map<String, dynamic> json) {
    return DriverProfile(
      profileData:
          Delivery.fromMap(json["profile_data"] as Map<String, dynamic>),
      name: json["name"] as String,
      phone: json["phone"] as String,
      email: json["email"] as String,
      image: json["image"] as String,
      totalCollected: json["total_collected"] as String,
      totalEarning: json["total_earning"] as String,
      counts: List<OrderLabel>.from(
        (json["counts"] as List)
            .map((x) => OrderLabel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "profile_data": profileData.toMap(),
        "name": name,
        "phone": phone,
        "email": email,
        "image": image,
        "total_collected": totalCollected,
        "total_earning": totalEarning,
        "counts": List<dynamic>.from(counts.map((x) => x.toMap())),
      };
}
