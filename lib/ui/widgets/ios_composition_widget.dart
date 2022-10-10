import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// `IOSCompositionWidget` is a `StatelessWidget` that returns a `UiKitView`
/// with the `viewType` of `<platform-view-type>`
/// and the `creationParams` of `<creation-params>`
class IOSCompositionWidget extends StatelessWidget {
  const IOSCompositionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
