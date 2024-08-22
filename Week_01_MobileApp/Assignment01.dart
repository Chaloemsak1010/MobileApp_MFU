// Dev: Mike016
// Author: Chaloemsak Arsung

// Write a program to find the summation of your ID. Assume that your ID is a String.
// Expected result: Sum of 6031302089 = 32
void main() {
  String ID = '6031302089';
  double summation = 0;
  for(int i = 0 ; i < ID.length ; i++){
    summation += int.parse( ID[i] );
  }
  print("Sum of 6031302089 = ${summation}");
}
