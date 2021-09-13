import 'package:flexicharge/services/chargers.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flexicharge/services/transactions.dart';
import 'package:flexicharge/ui/screens/home_page/home_view.dart';
import 'package:stacked/stacked_annotations.dart';


@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: Transactions),
    LazySingleton(classType: ChargerService),
    LazySingleton(classType: LocalData)
  ],
)

/// obs: When updating this file run [ $ flutter pub run build_runner build --delete-conflicting-outputs ]  in the terminal && and also when you change class signature
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
