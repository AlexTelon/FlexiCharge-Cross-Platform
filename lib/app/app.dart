import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flexicharge/services/transactions.dart';
import 'package:flexicharge/ui/screens/home_page/home_view.dart';
import 'package:flexicharge/ui/screens/login_page/login_view.dart';
import 'package:flexicharge/ui/screens/registration_page/registration_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: false),
    MaterialRoute(page: LoginView, initial: false),
    MaterialRoute(page: RegistrationView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: Transactions),
    LazySingleton(classType: LocalData),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ChargerApiService),
  ],
)

/// obs: When updating this file run
/// [ $ flutter pub run build_runner build --delete-conflicting-outputs ]  in the terminal &&
///  and also when you change class signature
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
