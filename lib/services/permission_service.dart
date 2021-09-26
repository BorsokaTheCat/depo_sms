import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<PermissionStatus> requestPermission(Permission permission) async {
    final status = await permission.request();
    var _permissionStatus = status;
    return _permissionStatus;
  }

  /// Requests the users permission to the storage.
  Future<bool> requestSmsPermission() async {
    PermissionStatus permission = await requestPermission(Permission.sms);
    if (permission.isGranted) {
      return true;
      // Either the permission was already granted before or the user just granted it.
    }if (permission.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      print('openAppSettings');
      openAppSettings();
      return false;
    }
    return false;
  }

  Future<String> checkSmsPermission() async {
    var status = await Permission.sms.status;
    if (status.isGranted) {
      return 'isGranted';
      // Either the permission was already granted before or the user just granted it.
    }else if(status.isDenied){
      return 'isDenied';
    }else if(status.isPermanentlyDenied){
      return 'isPermanentlyDenied';
    }
    return '';
  }

  /// Requests the users permission to the storage.
  Future<bool> requestStoragePermission() async {
    PermissionStatus permission = await requestPermission(Permission.storage);
    if (permission.isGranted) {
      return true;
      // Either the permission was already granted before or the user just granted it.
    }
    if (permission.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      print('openAppSettings');
      openAppSettings();
      return false;
    }
    return false;
  }

}

