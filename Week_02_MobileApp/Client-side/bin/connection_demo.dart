// Dev: Mike016
// Author: Chaloemsak Arsung

// for http connection
import 'package:http/http.dart' as http;
// for stdin
import 'dart:io';
import 'dart:convert';
// varaibles
int? userID = null;
// show menu fn
void showMenu() {
  print("===== Expense Tracking App =====");
  print("1. Show all");
  print("2. Today's expense");
  print("3. Exit");
}

void main() async {
  bool loginSuccess = false;
  do {
    loginSuccess = await login();
  } while (!loginSuccess);
  bool isExit = false;
  do {
    isExit = await showExpenses(userID);
  } while (!isExit);
}

Future<bool> showExpenses(int? userId) async {
  showMenu();
  stdout.write("Choose... ");
  String? choice = stdin.readLineSync();

  if (choice == null) {
    print("Invalid input, please enter a number.");
    return false;
  } else {
    switch (choice) {
      case "1":
        print("----- All expenses ------");
        final body = {"userId": userId, "showAll": true};
        final url = Uri.parse('http://localhost:3000/showExpenses');
        // Send the request with a JSON body
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body), // Convert Dart Map to JSON String
        );
        print("Raw response body: ${response.body}");
        List<dynamic> result = jsonDecode(response.body);
        // Print each expense item
        for (var expense in result) {
          print("Item: ${expense['item']}, Paid: ${expense['paid']}, Date: ${expense['date']}");
        }
        return false;
      case "2":
        print("----- Today's expenses ------");
        final body = {"userId": userId, "showAll": false};
        final url = Uri.parse('http://localhost:3000/showExpenses');
        // Send the request with a JSON body
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body), // Convert Dart Map to JSON String
        );
        print("Raw response body: ${response.body}");
        List<dynamic> result = jsonDecode(response.body);
        for (var expense in result) {
          print("Item: ${expense['item']}, Paid: ${expense['paid']}, Date: ${expense['date']}");
        }
        return false;
      case "3":
        print("Exiting the app...");
        return true;

      default:
        print("Invalid option, please choose a number between 1 and 3.");
        return false;
    }
  }
}

// Login
Future<bool> login() async {
  print("===== Login =====");
  // Get username and password
  stdout.write("Username: ");
  String? username = stdin.readLineSync()?.trim();
  stdout.write("Password: ");
  String? password = stdin.readLineSync()?.trim();
  if (username == null || password == null) {
    print("Incomplete input");
    return false;
  }

  final body = {"username": username, "password": password};
  final url = Uri.parse('http://localhost:3000/login');
  final response = await http.post(url, body: body);
  // note: if body is Map, it is encoded by "application/x-www-form-urlencoded" not JSON
  if (response.statusCode == 200) {
    // Map<String, dynamic> result = "dfsdfdsfdsf:dfdsfds";
    Map<String, dynamic> result = jsonDecode(response.body);
    // Access the value of "id"
    userID = result['id'];
    print("Login successfuly");
    return true;
  } else if (response.statusCode == 401 || response.statusCode == 500) {
    final result = response.body;
    print(result);
    return false;
  } else {
    print("Unknown error");
    return false;
  }
}


// for registration (client)
Future<void> registration() async {
  print("===== Registration =====");
  // Get username and password
  stdout.write("Username: ");
  String? username = stdin.readLineSync()?.trim();
  stdout.write("Password: ");
  String? password = stdin.readLineSync()?.trim();
  if (username == null || password == null) {
    print("Incomplete input");
    return;
  }
  final body = {"username": username, "password": password};
  final url = Uri.parse('http://localhost:3000/registration');
  final response = await http.post(url, body: body);
  // note: if body is Map, it is encoded by "application/x-www-form-urlencoded" not JSON
  if (response.statusCode == 200) {
    // the response.body is String
    final result = response.body;
    print(result);
  } else if (response.statusCode == 401 || response.statusCode == 500) {
    final result = response.body;
    print(result);
  } else {
    print("Unknown error");
  }
}


