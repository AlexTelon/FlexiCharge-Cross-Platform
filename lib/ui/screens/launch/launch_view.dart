import 'package:flexicharge/models/widget_keys.dart';
import 'package:flexicharge/theme.dart';
import 'package:flexicharge/ui/screens/launch/launch_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// This class is a StatelessWidget that uses a ViewModelBuilder to build a
/// ViewModel and then uses that ViewModel to build a Scaffold
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
                key: WidgetKeys.SplashScreenImage,
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
                          FlexiChargeTheme.yellow,
                          FlexiChargeTheme.green,
                        ],
                        stops: [0, 1],
                        begin: Alignment(-1.00, 0.00),
                        end: Alignment(1.00, -0.00),
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: 250,
                      height: 10,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        value: model.indication,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
