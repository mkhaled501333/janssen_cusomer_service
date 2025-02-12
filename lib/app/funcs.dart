import 'package:permission_handler/permission_handler.dart';

Future<void> permission() async {
  var status = await Permission.manageExternalStorage.status;
  if (!status.isGranted) {
    await Permission.manageExternalStorage.request();
  }
  var status1 = await Permission.storage.status;
  if (!status1.isGranted) {
    await Permission.storage.request();
  }
}
