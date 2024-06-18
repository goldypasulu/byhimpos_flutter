import 'package:goldy_pos/services/env.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  postData(endpoint, body) async {
    final response = await http.post(Uri.parse(apiUrl + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    return response;
  }
}
