import 'package:flexicharge/services/map_style.dart';
import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        
        body: GoogleMap(
            initialCameraPosition: model.cameraPosition,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController _controller) {
              model.controller.complete(_controller);
              _controller.setMapStyle(MapStyle().SilverMode);
            },
            tileOverlays: {}),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
