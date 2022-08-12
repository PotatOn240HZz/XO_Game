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
                  return GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                        border: _determineBorder(index),
                      ),
                      child: const Center(
                        child: Text(
                          // mylist[index],
                          'X',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 55),
                          textAlign: TextAlign.center,
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
                    Column(children: const [
                      Text(
                        'Player X',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '0',
                        style: TextStyle(fontSize: 20),
                      ),
                    ]),
                    Column(children: const [
                      Text(
                        'Player O',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '0',
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
