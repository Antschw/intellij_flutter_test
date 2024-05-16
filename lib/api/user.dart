import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> registerUser(String firstName, String lastName, String email,
    String password, List<String> roles) async {
  var url = Uri.parse('https://s3-5002.nuage-peda.fr/users');
  var headers = {'Content-Type': 'application/json'};
  var body = json.encode({
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
    'roles': roles
  });

  try {
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      print(
          "Échec de la requête : Code de statut ${response.statusCode}, Réponse : ${response.body}");
      return response.statusCode;
    }
  } catch (e) {
    print("Exception lors de la requête : $e");
    return 0;
  }
}

Future<List<Map<String, dynamic>>> fetchUserList() async {
  try {
    var url = Uri.parse('https://s3-5002.nuage-peda.fr/users');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> userListJson = json.decode(response.body);
      return userListJson.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch user list: ${response.reasonPhrase}');
    }
  } catch (e) {
    print("Exception while fetching user list: $e");
    rethrow;
  }
}

Future<http.Response> login(String email, String password) async {
  final url = Uri.parse('https://s3-5002.nuage-peda.fr/users/login');
  final headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    'email': email,
    'password': password,
  });
  final response = await http.post(
    url,
    headers: headers,
    body: body,
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to login: ${response.reasonPhrase}');
  }
}
