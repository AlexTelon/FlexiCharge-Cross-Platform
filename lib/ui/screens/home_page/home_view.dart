import 'package:flexicharge/services/map_style.dart';
import 'package:flexicharge/ui/bottom_sheets/top_sheet/top_sheet_view.dart';
import 'package:flexicharge/ui/bottom_sheets/top_sheet/top_sheet_view_model.dart';
import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
// import 'package:flexicharge/ui/bottom_sheets/map_bottom_sheet/snappingcheet.dart';
import 'package:flexicharge/ui/widgets/map_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: Stack(children: [
          GoogleMap(
            initialCameraPosition: model.cameraPosition,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true, // Set To false later.
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
          if (!model
              .activeTopSheet) // Change this boolean value to toggle TopSheet On/Off.
            Align(
              alignment: Alignment.topCenter,
              child: TopSheetView(),
            ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MapIcon(
                                  onTap: () => print("Test1"),
                                  isLarge: false,
                                  icon: SvgPicture.asset(
                                      'assets/svg_images/location.svg',
                                      fit: BoxFit.scaleDown)),
                              SizedBox(height: 30),
                              MapIcon(
                                  onTap: () => print("Test2"),
                                  isLarge: false,
                                  icon: SvgPicture.asset(
                                      'assets/svg_images/camera.svg',
                                      fit: BoxFit.scaleDown)),
                            ]),
                        MapIcon(
                            onTap: () => model.openFindCharger(),
                            isLarge: true,
                            icon: SvgPicture.asset('assets/svg_images/logo.svg',
                                fit: BoxFit.contain)),
                        MapIcon(
                            onTap: () => print("Test4"),
                            isLarge: false,
                            icon: SvgPicture.asset(
                                'assets/svg_images/person.svg',
                                fit: BoxFit.scaleDown)),
                      ]))),
        ]),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
