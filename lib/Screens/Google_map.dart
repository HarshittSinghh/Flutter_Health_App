import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _kiitCoordinates = LatLng(20.351786806986333, 85.81456658824384);

  late BitmapDescriptor _hospitalIcon;
  late BitmapDescriptor _pharmacyIcon;
  late BitmapDescriptor _kiitIcon;

  Set<Marker> _markers = {};

  Future<BitmapDescriptor> _getMarkerIcon(String assetPath, int width, int height) async {
    final ByteData byteData = await rootBundle.load(assetPath);
    final Uint8List imageBytes = byteData.buffer.asUint8List();

    final img.Image? image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception('Failed to decode image.');
    }

    final img.Image resizedImage = img.copyResize(image, width: width, height: height);

    final Uint8List resizedImageBytes = Uint8List.fromList(img.encodePng(resizedImage));

    return BitmapDescriptor.fromBytes(resizedImageBytes);
  }

  @override
  void initState() {
    super.initState();
    _loadIcons();
  }

  void _loadIcons() async {
    _hospitalIcon = await _getMarkerIcon('assets/img/hospital.png', 150, 150);
    _pharmacyIcon = await _getMarkerIcon('assets/img/pharma.png', 150, 150);
    _kiitIcon = await _getMarkerIcon('assets/img/location.png', 150, 150);

    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId('kiitLocation'),
          position: _kiitCoordinates,
          icon: _kiitIcon,
          infoWindow: InfoWindow(
            title: 'KIIT University',
            snippet: 'Your Location',
          ),
        ),
        Marker(
          markerId: MarkerId('kimsHospital'),
          position: LatLng(20.351988365615835, 85.8133631456264),
          icon: _hospitalIcon,
          infoWindow: InfoWindow(
            title: 'KIMS Hospital',
            snippet: 'Healthcare services',
          ),
        ),
        Marker(
          markerId: MarkerId('kissDispensary'),
          position: LatLng(20.364559328263283, 85.80994796302583),
          icon: _hospitalIcon,
          infoWindow: InfoWindow(
            title: 'KISS Dispensary',
            snippet: 'Medical assistance',
          ),
        ),
        Marker(
          markerId: MarkerId('kimsDentalDepartment'),
          position: LatLng(20.350295403240217, 85.81365886524135),
          icon: _hospitalIcon,
          infoWindow: InfoWindow(
            title: 'KIMS Dental Department',
            snippet: 'Dental care services',
          ),
        ),
        Marker(
          markerId: MarkerId('apolloHospital'),
          position: LatLng(20.306557540356387, 85.83195108413625),
          icon: _hospitalIcon,
          infoWindow: InfoWindow(
            title: 'Apollo Hospital',
            snippet: 'Comprehensive healthcare',
          ),
        ),
        Marker(
          markerId: MarkerId('kimsPharmacy'),
          position: LatLng(20.354045633192708, 85.81366251822698),
          icon: _pharmacyIcon,
          infoWindow: InfoWindow(
            title: 'KIMS Pharmacy',
            snippet: 'Medicines and health products',
          ),
        ),
        Marker(
          markerId: MarkerId('apolloPharmacy'),
          position: LatLng(20.353964894210158, 85.82218393024945),
          icon: _pharmacyIcon,
          infoWindow: InfoWindow(
            title: 'Apollo Pharmacy',
            snippet: 'Pharmacy and drug store',
          ),
        ),
        Marker(
          markerId: MarkerId('utkalHospital'),
          position: LatLng(20.322679091022376, 85.80043852318315),
          icon: _hospitalIcon,
          infoWindow: InfoWindow(
            title: 'Utkal Hospital',
            snippet: 'Emergency and general healthcare',
          ),
        ),
      };
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _kiitCoordinates,
          zoom: 15,
        ),
        markers: _markers,
      ),
    );
  }
}
