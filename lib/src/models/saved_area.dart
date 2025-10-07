import 'package:google_maps_flutter/google_maps_flutter.dart';

class SavedArea {
  final String name;
  final List<LatLng> points;

  SavedArea({required this.name, required this.points});

  Map<String, dynamic> toJson() => {
    'name': name,
    'points': points.map((p) => {'lat': p.latitude, 'lng': p.longitude}).toList(),
  };

  static SavedArea fromJson(Map<String, dynamic> json) {
    final points = (json['points'] as List)
        .map((p) => LatLng(p['lat'], p['lng']))
        .toList();
    return SavedArea(name: json['name'], points: points);
  }
}
