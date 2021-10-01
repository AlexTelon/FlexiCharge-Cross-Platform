import 'package:flexicharge/ui/screens/launch/launch_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay_pro/animations/bumping_line.dart';
import 'package:stacked/stacked.dart';

class LaunchView extends StatefulWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  _LaunchViewState createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
    );
    _color = _controller.drive<Color?>(
      ColorTween(
        begin: Colors.yellow,
        end: Colors.green,
      ),
    );
    //_controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LaunchViewModel>.reactive(
        viewModelBuilder: () => LaunchViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Color.fromRGBO(13, 13, 13, 1),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/splash_image.png',
                      height: 150,
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
                              // angle: 90,
                              // scale: undefined,
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
