import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionService {
  Future<bool> get isConnected async =>
      InternetConnectionChecker.instance.hasConnection;
  void dispose() {
    InternetConnectionChecker.instance.dispose();
  }
}
