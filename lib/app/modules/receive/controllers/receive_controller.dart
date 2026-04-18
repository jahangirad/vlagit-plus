import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';

class ReceiveController extends GetxController {
  HttpServer? _server;
  final int httpPort = 53354;
  var receivedList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    startServer();
  }

  void startServer() async {
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, httpPort);
      _server?.listen((HttpRequest request) async {
        if (request.uri.path == '/receive' && request.method == 'POST') {
          String content = await utf8.decoder.bind(request).join();
          var data = jsonDecode(content);
          
          // Add new data to the beginning of the list
          receivedList.insert(0, Map<String, dynamic>.from(data));
          
          request.response.statusCode = HttpStatus.ok;
          request.response.write("OK");
          await request.response.close();
        }
      });
    } catch (e) {
      print("Server Error: $e");
    }
  }

  @override
  void onClose() {
    _server?.close();
    super.onClose();
  }
}
