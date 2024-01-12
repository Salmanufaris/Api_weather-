import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Homeprovider extends ChangeNotifier {
  Future checkInternet() async {
    var connectivityresult = await Connectivity().checkConnectivity();
    return connectivityresult != ConnectivityResult.none;
  }
}
