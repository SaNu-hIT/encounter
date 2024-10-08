import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../core/utils/image_constant.dart';


Future<void> shareToWhatsAppText(
    String message, String body, String? fileUrl) async {
  try {
    print("fileUrl");
    print(fileUrl);
    // Determine the path to save the file
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/myItem.png';
    File file;

    if (fileUrl != null && fileUrl.isNotEmpty) {
      print("if");

      final url = Uri.parse(fileUrl);
      if (url != null && url.hasScheme && url.hasAuthority) {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          // Write the response body bytes to a file
          file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);
        } else {
          // If the response fails, use the default image from assets
          final byteData = await rootBundle.load(ImageConstant.imgImage);
          file = File(filePath);
          await file.writeAsBytes(byteData.buffer.asUint8List());
        }
      } else {
        final byteData = await rootBundle.load(ImageConstant.imgImage);
        file = File(filePath);
        await file.writeAsBytes(byteData.buffer.asUint8List());
      }
    } else {
      print("else");
      // If the fileUrl is empty, use the default image from assets
      final byteData = await rootBundle.load(ImageConstant.logo_blue);
      file = File(filePath);
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }
    message = stripHtmlIfNeeded(message);
    body = stripHtmlIfNeeded(body);
    // // Share the file
    final result =
        await Share.share('$message\n$body', subject: 'Shared from Encounter');
    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing!');
    }
  } catch (e) {
    print('Error sharing to WhatsApp: $e');
  }
}



Future<void> shareToWhatsApp(
    String message, String body, String? fileUrl) async {
  try {
    print("fileUrl");
    print(fileUrl);
    // Determine the path to save the file
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/myItem.png';
    File file;

    if (fileUrl != null && fileUrl.isNotEmpty) {
      print("if");

      final url = Uri.parse(fileUrl);
      if (url != null && url.hasScheme && url.hasAuthority) {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          // Write the response body bytes to a file
          file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);
        } else {
          // If the response fails, use the default image from assets
          final byteData = await rootBundle.load(ImageConstant.imgImage);
          file = File(filePath);
          await file.writeAsBytes(byteData.buffer.asUint8List());
        }
      } else {
        final byteData = await rootBundle.load(ImageConstant.imgImage);
        file = File(filePath);
        await file.writeAsBytes(byteData.buffer.asUint8List());
      }
    } else {
      print("else");
      // If the fileUrl is empty, use the default image from assets
      final byteData = await rootBundle.load(ImageConstant.logo_blue);
      file = File(filePath);
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }
    message = stripHtmlIfNeeded(message);
    body = stripHtmlIfNeeded(body);
    // // Share the file
    final result = await Share.shareXFiles([XFile(filePath)],
        text: '$message\n$body', subject: 'Shared from Encounter');
    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing!');
    }
  } catch (e) {
    print('Error sharing to WhatsApp: $e');
  }
}

String stripHtmlIfNeeded(String text) {
  return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
}
