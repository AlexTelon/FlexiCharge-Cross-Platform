import 'package:flexicharge/theme.dart';
import 'package:flexicharge/ui/widgets/top_bar.dart';
import 'package:flexicharge/ui/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flexicharge/ui/screens/profile_settings_page/profile_settings_viewmodel.dart';
import '../change_name_address/change_name_address_view.dart';
import '../login_page/login_view.dart';

/// ProfileView is a StatelessWidget that returns a Scaffold with a
/// SingleChildScrollView with a Column consisting of two containers:
/// first container: Topbar with a text of "Profile & Settings" and an onTap
/// that pops the context second container: Column with a ListTiles of
/// "Charging History", "Invoices", "Account Settings", "Name and Address" and
/// "About" as well as a WideButton
class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Topbar(
                  text: "Profile & Settings",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Charging History',
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                      ),
                      shape: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Invoices',
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                      ),
                      shape: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Account Settings',
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                      ),
                      shape: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Name and Address',
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                      ),
                      shape: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNameAddressView()),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        'About',
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                      ),
                      shape: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 25, 10, 10),
                    ),
                    WideButton(
                      text: 'Log Out',
                      color: FlexiChargeTheme.red,
                      onTap: () async {
                        await model.logout();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                            (Route route) => route.isFirst);
                      },
                      showWideButton: true,
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
