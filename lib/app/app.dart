import 'package:flexicharge/services/trasactions.dart';
import 'package:flexicharge/ui/screens/home_page/home_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: Transactions),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
