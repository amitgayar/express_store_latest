import 'package:flutter/material.dart';
import 'testBarcodeScanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'login.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'services/syncData.dart';
import 'AppScreens/customer.dart';
import 'AppScreens/orders.dart';
import 'AppScreens/requestStocks.dart';
import 'AppScreens/customer_plus_order.dart';

class DefaultWidget {
  final Widget defaultWidget;
  const DefaultWidget({this.defaultWidget});
}

class ExpressStoreApp extends StatefulWidget {
  final DefaultWidget defaultWidgetHome;

  // In the constructor, require a Todo.
  ExpressStoreApp({Key key, @required this.defaultWidgetHome}) : super(key: key);


  @override
  _ExpressStoreAppState createState() => _ExpressStoreAppState();
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class _ExpressStoreAppState extends State<ExpressStoreApp>
    with SingleTickerProviderStateMixin {

  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  String initialRouteValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
          _connectionStatus = result.toString();
          print(_connectionStatus);
          if (_connectionStatus == "ConnectivityResult.wifi" ||
              _connectionStatus == "ConnectivityResult.mobile") {
            SharedPreferences is_post_sync_successful = await SharedPreferences.getInstance();



            var CheckpostSyncStatus = is_post_sync_successful.getBool('postSyncStatus');
            var CheckgetSyncStatus = is_post_sync_successful.getBool('getSyncStatus');

            if (CheckpostSyncStatus == false) {
              await PostSyncAPI();
            }
            if (CheckgetSyncStatus == false) {
              await getSyncAPI();
            }
          }
        });

    setInitialRoute();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
      value: 1.0,
      );
  }

  @override
  void dispose() {
    print("dispose function called in app.dart");
    subscription.cancel();
    super.dispose();
  }


  // Controller to coordinate both the opening/closing of backdrop and sliding
  // of expanding bottom sheet.
  AnimationController _controller;


  setInitialRoute() async {
    SharedPreferences cronFrequency = await SharedPreferences.getInstance();
    if (cronFrequency.getString("authentication_token") != null){
      print("\n\nauthentication_token in app.dart = ${cronFrequency.getString("authentication_token")}");
      initialRouteValue = '/';
    }
    else {
      print("\n\nauthentication_token in app.dart = ${cronFrequency.getString("authentication_token")}");
      initialRouteValue = '/login';
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpStore',
      navigatorKey: navigatorKey,
      initialRoute: initialRouteValue,
//      onGenerateRoute: _getRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/': (context) => HomePage(),
        '/cart': (context) => new Container(),
        '/customers' : (context) => new CustomerPlusOrder(page:'customers'),
        '/customers/screen2' : (context) => new CustomerScreen2(),
//        '/customers/screen3' : (context) => new CustomerScreen3(),
//        '/addCustomer': (context) => AddCustomer(),
        '/orders' : (context) => new CustomerPlusOrder(page:'Orders'),
        '/requestStocks' : (context) => RequestStocks(),
        '/addCustomItem' : (context) => CustomItem(),

      },



      );
  }
}