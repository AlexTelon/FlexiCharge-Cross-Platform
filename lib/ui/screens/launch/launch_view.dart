import 'package:flexicharge/ui/screens/launch/launch_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay_pro/animations/bumping_line.dart';
import 'package:stacked/stacked.dart';

class LaunchView extends StatelessWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LaunchViewModel>.reactive(
        viewModelBuilder: () => LaunchViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/splash_image.png',
                      height: 200,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 250,
                          height: 10,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xfff2e006),
                                Color(0xff71b974),
                                Color(0xff409c68)
                              ],
                              stops: [0, 0.8659470016891891, 1],
                              begin: Alignment(-1.00, 0.00),
                              end: Alignment(1.00, -0.00),
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 10,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.black.withOpacity(0),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                            value: model.indication,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
