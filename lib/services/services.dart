import 'package:codingchallenge/models/userModels.dart';
import 'package:http/http.dart' as http;

class Services {
  var client = http.Client();
  Future<List<Users>?> getUser() async {
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<Users> users = userFromJson(response.body);
        return users;
      } else {
        print('Service folder');
      }
    } catch (e) {
      print(e);
    }
  }
}
