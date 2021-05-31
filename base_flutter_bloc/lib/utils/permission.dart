import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(List<Permission> listPermission) async {
  bool _isGranded = true;
  Map<Permission, PermissionStatus> statuses = await listPermission.request();
  for (var value in statuses.values) {
    if (value != PermissionStatus.granted) {
      _isGranded = false;
      break;
    }
  }
  return _isGranded;
}

Future<String> getPath(String fileName) async {
  String path = Platform.isAndroid
      ? await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS)
      : (await getApplicationDocumentsDirectory()).path +
          Platform.pathSeparator +
          'Download';

  final savedDir = Directory(path);
  if (!(await savedDir.exists())) {
    savedDir.create();
  }

  return '$path/$fileName.pdf';
}
