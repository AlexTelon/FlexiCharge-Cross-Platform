import 'dart:html';
import 'dart:ui';

import 'package:flexicharge/services/map_style.dart';
import 'package:flexicharge/ui/screens/home_page/home_viewmodel.dart';
<<<<<<< Updated upstream
import 'package:flexicharge/ui/widgets/map_icon.dart';
=======
import 'package:flexicharge/ui/widgets/map_icon_button.dart';
>>>>>>> Stashed changes
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
        
        body: Stack(
          children:[
<<<<<<< Updated upstream
             GoogleMap(
=======
            GoogleMap(
>>>>>>> Stashed changes
              initialCameraPosition: model.cameraPosition,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController _controller) {
                model.controller.complete(_controller);
                _controller.setMapStyle(MapStyle().SilverMode);
              },
              tileOverlays: {}),
<<<<<<< Updated upstream
              Positioned(
                child: MapIcon(onTap: () => print("TEST"), isLarge: false, icon: Icons.location_on)
              )
=======
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
                        MapIcon(onTap: () => print("TEST1"), isLarge: false, icon: SvgPicture.asset('assets/location.svg',fit: BoxFit.scaleDown)),
                        SizedBox(height: 30),
                        MapIcon(onTap: () => print("Test2"), isLarge: false, icon: SvgPicture.asset('assets/camera.svg',fit: BoxFit.scaleDown)),
                      ]
                  ),
                  MapIcon(onTap: ()=> print("Test3"), isLarge: true,icon: SvgPicture.asset('assets/logo.svg',fit:BoxFit.contain)),
                  MapIcon(onTap: ()=> print("Test4"), isLarge: false, icon: SvgPicture.asset('assets/person.svg',fit: BoxFit.scaleDown))
                  ]
                )
              )
            ),
>>>>>>> Stashed changes
          ]
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
