import 'package:flexicharge/models/widget_keys.dart';
import 'package:flexicharge/services/map_style.dart';
import 'package:flexicharge/ui/bottom_sheets/top_sheet/top_sheet_view.dart';
import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
import 'package:flexicharge/ui/screens/profile_settings_page/profile_settings_view.dart';
// import 'package:flexicharge/ui/bottom_sheets/map_bottom_sheet/snappingcheet.dart';
import 'package:flexicharge/ui/widgets/map_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../models/user_secure_storage.dart';
import '../login_page/login_view.dart';
// import 'package:loading_overlay_pro/loading_overlay_pro.dart';

/*class SplashScreen extends StatelessWidget {
  SplashScreen() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Hello world!'),
      ),
    );
  }
}*/

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
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController _controller) {
              model.getUserLocation();
              model.controller.complete(_controller);
              model.userLocateController = _controller;
              _controller.setMapStyle(MapStyle().SilverMode);
              _controller.animateCamera(
                CameraUpdate.newCameraPosition(model.cameraPosition),
              );
            },
            markers: model.markers,
          ),
          if (model
              .activeTopSheet) // Change this boolean value to toggle TopSheet On/Off.
            Align(
              alignment: Alignment.topCenter,
              child: TopSheetView(
                complete: () => model.completeTopSheet(),
              ),
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
                                  onTap: () => model.findUser(),
                                  isLarge: false,
                                  icon: SvgPicture.asset(
                                      'assets/svg_images/location.svg',
                                      fit: BoxFit.scaleDown)),
                              SizedBox(height: 30),
                              MapIcon(
                                  onTap: () => model.doQrScan(),
                                  isActive: false,
                                  isLarge: false,
                                  icon: SvgPicture.asset(
                                      'assets/svg_images/camera.svg',
                                      fit: BoxFit.scaleDown)),
                            ]),
                        MapIcon(
                          key: WidgetKeys.FindChargerButton,
                          onTap: () => model.openFindCharger(),
                          isActive: model.localData.isButtonActive,
                          isLarge: true,
                          icon: SvgPicture.asset('assets/svg_images/logo.svg',
                              fit: BoxFit.scaleDown),
                        ),
                        MapIcon(
                            onTap: () async {
                              if (await model.isUserloggedIn()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileView()),
                                );
                              } else {
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginView()),
                                );*/
                                Navigator.pop(context);
                              }
                            },
                            isActive: true,
                            isLarge: false,
                            icon: SvgPicture.asset(
                                'assets/svg_images/person.svg',
                                fit: BoxFit.scaleDown))
                      ]))),
        ]),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
