

// Assignment 3 Write a program to simulate a login system.
// Dev: Mike016
import 'dart:io';
// Role 1 is admin, 2 is user
var account = [
  {'username': 'Lisa', 'password': '1111', 'role': 1},
  {'username': 'Tom', 'password': '2222', 'role': 2}
];
int time = 0 ;
bool loginFunction(int role , String? username, String? password, String? usernameInput,String? passwordInput) {
  time += 1 ; // first time be 1
  // if username and password is correct exit the loop and show name base on role
  if (username == usernameInput && password == passwordInput) {
    if (role == 1) {
      print("Welcome $username (Admin)");
    } else {
      print("Welcome  $username (User)");
    }
    return true;
  } else if (username != usernameInput || password != passwordInput){ // incorrect password or username
    // Checking if the loop has passed through all accounts or not.
    if (time == account.length) {  
      print("Wrong Login");
      return true ;
    } else {
      return false ;
    }
  }
  return false ;
}
void main() {
  print("--- Login ---");
  stdout.write('Enter your username: ');
  String? username = stdin.readLineSync();
  stdout.write('Enter your password: ');
  String? password = stdin.readLineSync();
 
  for (var user in account) {
    bool isDone = false ;
    // create function to complete this process.
    isDone = loginFunction( user['role'] as int ,user['username'] as String, user['password'] as String, username, password);
    if (isDone) {
      // if already done exit from the loop
      break ;
    }
  }
}

