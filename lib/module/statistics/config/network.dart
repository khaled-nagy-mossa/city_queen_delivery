import 'package:delivery/common/config/api.dart';

abstract class DeliveryApis {
  const DeliveryApis();

  /// Get driver profile data
  /// type post
  static String driverProfile = '${API.baseUrl}/driver_profile';
}
