import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../google_map_drawer.dart';


class GoogleMapDrawController {
  final List<LatLng> _points = [];
  GoogleMapController? _mapController;

  List<LatLng> get points => List.unmodifiable(_points);

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  void addPoint(LatLng point) => _points.add(point);
  void removeLastPoint() {
    if (_points.isNotEmpty) _points.removeLast();
  }

  void clearPoints() => _points.clear();

  SavedArea saveArea(String name) => SavedArea(name: name, points: List.from(_points));

  Future<void> moveCamera(LatLng target) async {
    if (_mapController != null) {
      await _mapController!.animateCamera(CameraUpdate.newLatLng(target));
    }
  }
}
