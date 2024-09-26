/*
  Dev: Mike016
  Author: Chaloemsak Arsung 
*/

import 'package:flutter/material.dart';
import 'dart:math';

class Labtest extends StatefulWidget {
  const Labtest({super.key});

  @override
  State<Labtest> createState() => _LabtestState();
}

class _LabtestState extends State<Labtest> {
  Random random = Random();
  // All variables
  // ignore: non_constant_identifier_names
  int total_Coins = 10; // Remaining coins 
  int player01Coin = 0; // player 1 coins
  int player02Coin = 0; // player 2 coins
  bool isTurnOfP1 = true; // --> use for check turn.
  bool isEnded = false ; // --> use for check game is complete or not
  // Output str
  String resultCollect = 'Let start to collect the coins!!!';
  String strShowWiner = '';
  
  // who: 1 --> player 1 , 2 --> player 2
  void playersCollect(String who) {
    if (isEnded){
      setState(() {
        resultCollect = 'Pls , click Replay to play again' ;
      });
      return ; // exit this method if game ended
    }
    // turn of player 1
    if (isTurnOfP1 && who == '1') {
      setState(() {
        int ranCoins = random.nextInt(total_Coins ) + 1 ; // need to plus 1 ,Cuz nextInt return Value  >= 0 and < total_Coins
        player01Coin += ranCoins;

        if (ranCoins > 5 || player01Coin > 5 ) {
          strShowWiner = 'Player 1 wins';
          isEnded = true ;
        }

        total_Coins -= ranCoins;
        resultCollect = 'Player 1 collect $ranCoins';
        isTurnOfP1 = !isTurnOfP1;
        if (total_Coins <= 0) {
          if (player01Coin > player02Coin) {
            strShowWiner = 'Player 1 wins';
          } else if (player01Coin == player02Coin) {
            strShowWiner = 'There is no winner , Cuz scores is equal!!';
          } else {
            strShowWiner = 'Player 2 wins';
          }
          isEnded = true ;
        }
      });
    // turn of player 2
    } else if (!isTurnOfP1 && who == '2') {
      setState(() {
        int ranCoins = random.nextInt(total_Coins) + 1;
        player02Coin += ranCoins;

        if ((ranCoins > 5 && total_Coins > 5) || player02Coin > 5 ) {
          strShowWiner = 'Player 2 wins';
          // set total = 0 for stop game
          total_Coins = 0 ;
          isEnded = true ;
        }

        total_Coins -= ranCoins;
        resultCollect = 'Player 2 collect $ranCoins';
        isTurnOfP1 = !isTurnOfP1;
        if (total_Coins <= 0) {
          if (player01Coin > player02Coin) {
            strShowWiner = 'Player 1 wins';
          } else if (player01Coin == player02Coin) {
            strShowWiner = 'There is no winner , Cuz scores is equal!!';
          } else {
            strShowWiner = 'Player 2 wins';
          }
          isEnded = true ;
        }
      });
    // if player click buttton but not player turn
    } else {
      setState(() {
        resultCollect = 'Is not your turn';
      });
    }
  }
  // Re-Game
  void _regame() {
    setState(() {
      total_Coins = 10;
      player01Coin = 0;
      player02Coin = 0;
      resultCollect = 'Let start to collect the coins!!!';
      strShowWiner = '';
      isTurnOfP1 = true ;
      isEnded = false ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Treasure Game',
          style: TextStyle(color: Colors.yellow),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Coins part
          Padding(padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Column(
                children: [Text('Total Coins')],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  // coins ui
                  Row(
                    children: [
                      // 1
                      for (int i = 1; i <= 5; i++)
                        Icon(
                          Icons.paid,
                          color: i <= total_Coins
                              ? const Color.fromARGB(255, 241, 217, 6)
                              : Colors.black,
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      for (int i = 6; i <= 10; i++)
                        Icon(
                          Icons.paid,
                          color: i <= total_Coins
                              ? const Color.fromARGB(255, 241, 217, 6)
                              : Colors.black,
                        ),
                    ],
                  )
                ],
              )
            ],
          ),
          ),

          // for image
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                // Player 1
                children: [
                  const Text('Player 1'),
                  Image.asset('assets/images/dig1.png'),
                  Text('$player01Coin coins'),
                  ElevatedButton(
                    onPressed: () => playersCollect('1'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Collect',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Column(
                // Player 2
                children: [
                  const Text('Player 2'),
                  Image.asset('assets/images/dig2.png'),
                  Text('$player02Coin coins'),
                  ElevatedButton(
                    onPressed: () => playersCollect('2'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Collect',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
          // Output part
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Text(resultCollect),
                Text(strShowWiner),
              ],
            ),
          ),
          // regame button
          Center(
            child: ElevatedButton(
              onPressed: _regame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child:
                  const Text('Replay', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
