import 'package:flexicharge/services/map_style.dart';
import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
import 'package:flexicharge/ui/widgets/map_icon.dart';
import 'package:flexicharge/ui/bottom_sheets/map_bottom_sheet/snappingcheet.dart';
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
              _controller.animateCamera(
                CameraUpdate.newCameraPosition(model.cameraPosition),
              );
            },
            markers: {
              Marker(
                markerId: MarkerId("1"),
                position: LatLng(57.781921, 14.161227),
                icon: model.greenMarkerIcon,
                infoWindow: InfoWindow(
                  title: 'Trädgårdsgatan 25',
                  snippet: "Hi I'm Available",
                ),
              ),
              Marker(
                markerId: MarkerId("2"),
                position: LatLng(57.782053, 14.162851),
                icon: model.redMarkerIcon,
                infoWindow: InfoWindow(
                  title: 'Barnarpsgatan',
                  snippet: "Hi I'm Unavailable",
                ),
              ),
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MapIcon(
              onTap: ()=> model.openFindCharger(),
              isLarge: true,
              icon: Icon(
                Icons.location_on,
              ),
            ),
          )
        ]),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
