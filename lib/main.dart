import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Tic Tac Toe Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> gridComponents = List.filled(9, '');
  List<Color> gridColour = List.filled(9, Colors.white);
  bool isXTurn = true;
  int xWins = 0;
  int oWins = 0;
  bool someoneWon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                horizontalTitleGap: 0,
                leading: Image.asset('assets/images/Github.png', width: 30),
                title: const Text('GitHub'),
                onTap: () => _launchUrl('https://github.com/PotatOn240HZz'),
              ),
              ListTile(
                horizontalTitleGap: 0,
                leading: Image.asset('assets/images/Linkedin.png', width: 30),
                title: const Text('LinkedIn'),
                onTap: () =>
                    _launchUrl('https://www.linkedin.com/in/yousefshaban/'),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (gridComponents[index] == '' && !someoneWon) {
                          gridComponents[index] = isXTurn ? 'X' : 'O';
                          isXTurn = !isXTurn;
                          if (checkWinner(index + 1)) {
                            print("THERE IS A WINNER");
                          }
                        }
                      });
                    },
                    child: GridTile(
                      child: Container(
                        decoration: BoxDecoration(
                          border: _determineBorder(index),
                          color: gridColour[index],
                        ),
                        child: Center(
                          child: Text(
                            gridComponents[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 55),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Expanded(child: SizedBox()),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.grey))),
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 30),
                ),
              ),
              onPressed: () {
                showResetDialog(context);
              },
              child: const Text("Reset"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      const Text(
                        'Player X',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        xWins.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ]),
                    Column(children: [
                      const Text(
                        'Player O',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        oWins.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ]),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  void reset() {
    setState(() {
      xWins = 0;
      oWins = 0;
      isXTurn = true;
      someoneWon = false;
      for (int i = 0; i < 9; i++) {
        gridComponents[i] = '';
        gridColour[i] = Colors.white;
        if (i != 8) {
          winningPattern[i] = 0;
        }
      }
    });
  }

  //1st winning pattern will be the 1st row
  //2nd winning pattern will be the 2st row
  //3rd winning pattern will be the 3st row
  //4th winning pattern will be the 1st column
  //5th winning pattern will be the 2st column
  //6th winning pattern will be the 3st column
  //7th winning pattern will be the diagonal
  //8th winning pattern will be the diagonal
  List<int> winningPattern = List.filled(8, 0);

  bool checkWinner(int i) {
    //ADD ALL
    switch (i) {
      case 1:
        gridComponents[i - 1] == 'X'
            ? winningPattern[0]++
            : winningPattern[0]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[3]++
            : winningPattern[3]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[6]++
            : winningPattern[6]--;
        break;
      case 2:
        gridComponents[i - 1] == 'X'
            ? winningPattern[0]++
            : winningPattern[0]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[4]++
            : winningPattern[4]--;
        break;
      case 3:
        gridComponents[i - 1] == 'X'
            ? winningPattern[0]++
            : winningPattern[0]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[5]++
            : winningPattern[5]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[7]++
            : winningPattern[7]--;
        break;
      case 4:
        gridComponents[i - 1] == 'X'
            ? winningPattern[1]++
            : winningPattern[1]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[3]++
            : winningPattern[3]--;
        break;
      case 5:
        gridComponents[i - 1] == 'X'
            ? winningPattern[1]++
            : winningPattern[1]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[4]++
            : winningPattern[4]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[6]++
            : winningPattern[6]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[7]++
            : winningPattern[7]--;
        break;
      case 6:
        gridComponents[i - 1] == 'X'
            ? winningPattern[1]++
            : winningPattern[1]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[5]++
            : winningPattern[5]--;
        break;
      case 7:
        gridComponents[i - 1] == 'X'
            ? winningPattern[2]++
            : winningPattern[2]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[3]++
            : winningPattern[3]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[7]++
            : winningPattern[7]--;
        break;
      case 8:
        gridComponents[i - 1] == 'X'
            ? winningPattern[2]++
            : winningPattern[2]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[4]++
            : winningPattern[4]--;
        break;
      case 9:
        gridComponents[i - 1] == 'X'
            ? winningPattern[2]++
            : winningPattern[2]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[5]++
            : winningPattern[5]--;
        gridComponents[i - 1] == 'X'
            ? winningPattern[6]++
            : winningPattern[6]--;
        break;
    }

    //CHECK ALL
    //CHECK ROW
    if (winningPattern[0] == 3 || winningPattern[0] == -3) {
      return applyWinner(winningPattern[0], 1);
    } else if (winningPattern[1] == 3 || winningPattern[1] == -3) {
      return applyWinner(winningPattern[1], 2);
    } else if (winningPattern[2] == 3 || winningPattern[2] == -3) {
      return applyWinner(winningPattern[2], 3);
    }
    //CHECK COLUMN
    else if (winningPattern[3] == 3 || winningPattern[3] == -3) {
      return applyWinner(winningPattern[3], 4);
    } else if (winningPattern[4] == 3 || winningPattern[4] == -3) {
      return applyWinner(winningPattern[4], 5);
    } else if (winningPattern[5] == 3 || winningPattern[5] == -3) {
      return applyWinner(winningPattern[5], 6);
    }
    //CHECK Diagonal`
    else if (winningPattern[6] == 3 || winningPattern[6] == -3) {
      return applyWinner(winningPattern[6], 7);
    }
    //CHECK ReverseDiagonal
    else if (winningPattern[7] == 3 || winningPattern[7] == -3) {
      return applyWinner(winningPattern[7], 8);
    }
    //NONE WON YET
    return false;
  }

  bool applyWinner(int numberOfSymbol, int line) {
    someoneWon = true;
    if (numberOfSymbol == 3) {
      xWins++;
      showWinningDialog(context, true);
    } else {
      oWins++;
      showWinningDialog(context, false);
    }

    //CHANGE THE COLOUR OF THE WINNER
    switch (line) {
      case 1:
      case 2:
      case 3:
        for (int i = (line * 3) - 3; i < line * 3; i++) {
          gridColour[i] = Colors.red;
        }
        break;
      case 4:
      case 5:
      case 6:
        for (int i = line - 4; i < 9; i += 3) {
          gridColour[i] = Colors.red;
        }
        break;
      case 7:
        for (int i = 0; i < 9; i += 4) {
          gridColour[i] = Colors.red;
        }
        break;
      case 8:
        for (int i = 2; i < 7; i += 2) {
          gridColour[i] = Colors.red;
        }
        break;
    }
    return true;
  }

  Border _determineBorder(int index) {
    BorderSide borderSide = const BorderSide(
      color: Colors.grey,
      width: 1.5,
    );
    switch (index) {
      case 0:
        return Border(bottom: borderSide, right: borderSide);

      case 1:
        return Border(left: borderSide, bottom: borderSide, right: borderSide);

      case 2:
        return Border(left: borderSide, bottom: borderSide);

      case 3:
        return Border(bottom: borderSide, right: borderSide, top: borderSide);

      case 4:
        return Border(
          left: borderSide,
          bottom: borderSide,
          right: borderSide,
          top: borderSide,
        );
      case 5:
        return Border(left: borderSide, bottom: borderSide, top: borderSide);

      case 6:
        return Border(right: borderSide, top: borderSide);

      case 7:
        return Border(left: borderSide, top: borderSide, right: borderSide);

      case 8:
        return Border(left: borderSide, top: borderSide);
      default:
        return const Border();
    }
  }

  showWinningDialog(BuildContext context, bool didXWin) {
    // set up the AlertDialog
    String alertTitle;
    String alertContent;
    if (didXWin == true) {
      alertTitle = "X Won!";
      alertContent = "Your score is now:$xWins";
    } else {
      alertTitle = "O Won!";
      alertContent = "Your score is now:$oWins";
    }

    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: Text(alertContent),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showResetDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Reset"),
      onPressed: () {
        reset();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text("You sure you want to reset the game?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }
}