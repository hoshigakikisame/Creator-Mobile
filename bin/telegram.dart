  
import 'dart:io';

import 'package:dio/dio.dart';

void main(List<String> args) async {
  final String botToken = args[0];
  final String chatId = args[1];
  final String message = args[2];

  final dio = Dio();
  //final File file = File('build/app/outputs/apk/release/app-release.apk');
  //final fileSize = await file.length();
  //if (fileSize < 50 * 1024 * 1024) {
    final data = FormData.fromMap({
      'chat_id': chatId,
      'caption': message,
      'document': await MultipartFile.fromFile(
        'build/app/outputs/apk/release/app-release.apk',
        filename: 'app-release.apk',
      ),
    });

    await dio.post(
      'https://api.telegram.org/bot$botToken/sendDocument',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  //} else {
  //  final data = {
  //    'chat_id': chatId,
  //    'text': message,
  //  };

  //  await dio.post(
  //    'https://api.telegram.org/bot$botToken/sendMessage',
  //    data: data,
  //  );
  //}

  exit(0);
}