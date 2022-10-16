import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// This class is not used, icons are retrieved in another way at the moment.
// This class could be usefull in the future.

/// It's a stateless widget that takes an asset name and returns an SvgPicture
class AssetsIcon extends StatelessWidget {
  const AssetsIcon({Key? key, required this.assetName}) : super(key: key);
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      semanticsLabel: 'Acme Logo',
      color: Colors.black,
    );
  }
}
