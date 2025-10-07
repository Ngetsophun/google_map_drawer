import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'controller.dart';

class GoogleMapDrawer extends StatelessWidget {
  final GoogleMapDrawController controller;
  final CameraPosition? initialCamera;
  final Color polygonColor;
  final double polygonOpacity;

  const GoogleMapDrawer({
    super.key,
    required this.controller,
    this.initialCamera,
    this.polygonColor = Colors.blue,
    this.polygonOpacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCamera ?? const CameraPosition(target: LatLng(11.5564, 104.9282), zoom: 13),
      onMapCreated: (mapController) => controller.setMapController(mapController),
      onTap: (position) => controller.addPoint(position),

      polygons: {
        Polygon(
          polygonId: const PolygonId("drawnArea"),
          points: controller.points,
          strokeColor: polygonColor,
          fillColor: polygonColor.withAlpha((polygonOpacity * 255).toInt()),
          strokeWidth: 2,
        ),
      },
    );
  }
}
