import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInfo {
  final String name;
  final LatLng position;
  final String address;
  final double? distanceFromUser;

  LocationInfo({
    required this.name,
    required this.position,
    required this.address,
    this.distanceFromUser,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'lat': position.latitude,
    'lng': position.longitude,
    'address': address,
    'distanceFromUser': distanceFromUser,
  };

  static LocationInfo fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      name: json['name'],
      position: LatLng(json['lat'], json['lng']),
      address: json['address'],
      distanceFromUser: json['distanceFromUser'],
    );
  }
}
