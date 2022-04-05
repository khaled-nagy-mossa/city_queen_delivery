import '../../../common/config/api.dart';

abstract class GlobalAPIs {
  const GlobalAPIs();

  ///to update delivery location with send all current orders id
  static String updateLocation = '${API.baseUrl}/update_location';
}
