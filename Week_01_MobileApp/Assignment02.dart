// Dev: Mike016
// Author: Chaloemsak Arsung
import 'dart:io';
void main() {
  print('Enter your name.... ');
  String? username = stdin.readLineSync();
  if (username == null || username.isEmpty) {
    print("Sorry, please input your name");
    return; // Exit the program
  }
  print('Enter your age... ');
  String? ageInput = stdin.readLineSync();
  if (ageInput == null || ageInput.isEmpty) {
    print("Sorry, please input your age correctly");
    return; 
  }
  int? age = int.tryParse(ageInput);
  if (age == null) {
    print("Sorry, please input your age correctly");
    return; 
  }
  print('$username is $age years old.');
}
