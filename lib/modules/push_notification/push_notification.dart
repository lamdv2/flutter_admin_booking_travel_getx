import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

void sendNotification(
    String content, String? img, String title, String token) async {
  const String apiUrl = "http://192.168.1.142:8080/user/notification";

  Map<String, dynamic> requestData = {
    "body": content,
    "data": {
      "additionalProp1": "string",
      "additionalProp2": "string",
      "additionalProp3": "string"
    },
    "img": img ?? "string",
    "title": title,
    "token": token
  };

  String jsonData = json.encode(requestData);

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      bool success = responseData['success'];
      String message = responseData['message'];

      print("Success: $success");
      print("Message: $message");
    } else {
      print("Error: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  } catch (e) {
    print("Error: $e");
  }
}
