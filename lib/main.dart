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
  List<String> myList = List.filled(9, '');
  bool isXTurn = true;
  bool xWon = false;
  bool oWon = false;
  int xWins = 0;
  int oWins = 0;

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
              padding: const EdgeInsets.all(20),
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
                        if (myList[index] == '' && (!xWon && !oWon)) {
                          myList[index] = isXTurn ? 'X' : 'O';
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
                        ),
                        child: Center(
                          child: Text(
                            myList[index],
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
            const Text(
              'Score',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
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
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    Column(children: [
                      const Text(
                        'Player O',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        oWins.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  int row1Num = 0;
  int row2Num = 0;
  int row3Num = 0;
  int column1Num = 0;
  int column2Num = 0;
  int column3Num = 0;
  int diagonalNum = 0;
  int rDiagonalNum = 0;

  bool checkWinner(int i) {
    //ADD ALL
    switch (i) {
      case 1:
        myList[i - 1] == 'X' ? row1Num++ : row1Num--;
        myList[i - 1] == 'X' ? column1Num++ : column1Num--;
        myList[i - 1] == 'X' ? diagonalNum++ : diagonalNum--;
        break;
      case 2:
        myList[i - 1] == 'X' ? row1Num++ : row1Num--;
        myList[i - 1] == 'X' ? column2Num++ : column2Num--;
        break;
      case 3:
        myList[i - 1] == 'X' ? row1Num++ : row1Num--;
        myList[i - 1] == 'X' ? column3Num++ : column3Num--;
        myList[i - 1] == 'X' ? rDiagonalNum++ : rDiagonalNum--;
        break;
      case 4:
        myList[i - 1] == 'X' ? row2Num++ : row2Num--;
        myList[i - 1] == 'X' ? column1Num++ : column1Num--;
        break;
      case 5:
        myList[i - 1] == 'X' ? row2Num++ : row2Num--;
        myList[i - 1] == 'X' ? column2Num++ : column2Num--;
        myList[i - 1] == 'X' ? diagonalNum++ : diagonalNum--;
        myList[i - 1] == 'X' ? rDiagonalNum++ : rDiagonalNum--;
        break;
      case 6:
        myList[i - 1] == 'X' ? row2Num++ : row2Num--;
        myList[i - 1] == 'X' ? column3Num++ : column3Num--;
        break;
      case 7:
        myList[i - 1] == 'X' ? row3Num++ : row3Num--;
        myList[i - 1] == 'X' ? column1Num++ : column1Num--;
        myList[i - 1] == 'X' ? rDiagonalNum++ : rDiagonalNum--;
        break;
      case 8:
        myList[i - 1] == 'X' ? row3Num++ : row3Num--;
        myList[i - 1] == 'X' ? column2Num++ : column2Num--;
        break;
      case 9:
        myList[i - 1] == 'X' ? row3Num++ : row3Num--;
        myList[i - 1] == 'X' ? column3Num++ : column3Num--;
        myList[i - 1] == 'X' ? diagonalNum++ : diagonalNum--;
        break;
    }
    //CHECK ALL
    //CHECK ROW
    if (row1Num == 3 || row1Num == -3) {
      row1Num == 3 ? xWon = true : oWon = true;
      row1Num == 3 ? xWins++ : oWins++;
      return true;
    } else if (row2Num == 3 || row2Num == -3) {
      row2Num == 3 ? xWon = true : oWon = true;
      row2Num == 3 ? xWins++ : oWins++;
      return true;
    } else if (row3Num == 3 || row3Num == -3) {
      row3Num == 3 ? xWon = true : oWon = true;
      row3Num == 3 ? xWins++ : oWins++;
      return true;
    }
    //CHECK COLUMN
    else if (column1Num == 3 || column1Num == -3) {
      column1Num == 3 ? xWon = true : oWon = true;
      column1Num == 3 ? xWins++ : oWins++;
      return true;
    } else if (column2Num == 3 || column2Num == -3) {
      column2Num == 3 ? xWon = true : oWon = true;
      column2Num == 3 ? xWins++ : oWins++;
      return true;
    } else if (column3Num == 3 || column3Num == -3) {
      column3Num == 3 ? xWon = true : oWon = true;
      column3Num == 3 ? xWins++ : oWins++;
      return true;
    }
    //CHECK Diagonal
    else if (diagonalNum == 3 || diagonalNum == -3) {
      diagonalNum == 3 ? xWon = true : oWon = true;
      diagonalNum == 3 ? xWins++ : oWins++;
      return true;
    }
    //CHECK ReverseDiagonal
    else if (rDiagonalNum == 3 || rDiagonalNum == -3) {
      rDiagonalNum == 3 ? xWon = true : oWon = true;
      rDiagonalNum == 3 ? xWins++ : oWins++;
      return true;
    }
    //ELSE ALL NOT TRUE
    return false;
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

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }
}
