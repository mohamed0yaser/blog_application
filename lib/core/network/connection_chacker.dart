import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> isConnected();
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection dataConnectionChecker;

  ConnectionCheckerImpl(this.dataConnectionChecker);

  @override
  Future<bool> isConnected() async => 
  await dataConnectionChecker.hasInternetAccess;
  
}