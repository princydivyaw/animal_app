import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class AppCommonUtils {
  Future<void> downloadAndShare(String url) async {
    try {
      await Share.share(
        "Check out this\n$url",
        subject: "Explore this feed",
      );
    } catch (e) {
      print("Error while sharing: $e");
    }
  }

  Future<void> saveFeedImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File("${tempDir.path}/feed_image.jpg");
        await file.writeAsBytes(response.bodyBytes);

        // await GallerySaver.saveImage(file.path, albumName: "MyApp");
      } else {
        print("❌ Failed to download: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  Future<void> pickFileWithPermission() async {
    Permission permission = Permission.storage;
    if (await permission.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
      );
      if (result != null) {
        String? filePath = result.files.single.path;
        print("Picked file: $filePath");
      } else {
        print("User cancelled picker");
      }
    } else if (await permission.isDenied) {
      var newStatus = await permission.request();
      if (newStatus.isGranted) {
        print("Permission granted after request");
      } else {
        print("Permission denied");
      }
    } else if (await permission.isPermanentlyDenied) {
      print("Permission permanently denied → open settings");
      openAppSettings();
    }
  }
}
