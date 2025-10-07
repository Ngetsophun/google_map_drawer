import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_drawer/google_map_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Drawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GoogleMapDrawController mapController = GoogleMapDrawController();

  bool isDrawingMode = false;

  final CameraPosition initialCamera =
  const CameraPosition(target: LatLng(11.5564, 104.9282), zoom: 13);
  final Color polygonColor = Colors.blue;
  final double polygonOpacity = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Map Drawer Demo")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: initialCamera,
              onMapCreated: (controller) => mapController.setMapController(controller),
              onTap: isDrawingMode ? (position) {
                mapController.addPoint(position);
                setState(() {}); // refresh map
              }
                  : null,
              polygons: {
                Polygon(
                  polygonId: const PolygonId("drawnArea"),
                  points: mapController.points,
                  strokeColor: polygonColor,
                  fillColor:
                  polygonColor.withAlpha((polygonOpacity * 255).toInt()),
                  strokeWidth: 2,
                ),
              },
            ),
          ),

          // User-controlled buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isDrawingMode = !isDrawingMode;
                    });
                  },
                  child: Text(isDrawingMode ? "Stop Drawing" : "Start Drawing"),
                ),
                ElevatedButton(
                  onPressed: () {
                    mapController.removeLastPoint();
                    setState(() {});
                  },
                  child: const Text("Undo"),
                ),
                ElevatedButton(
                  onPressed: () {
                    mapController.clearPoints();
                    setState(() {});
                  },
                  child: const Text("Clear"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final area = mapController.saveArea("My Property");
                    print(area.toJson());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Area saved!")),
                    );
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
