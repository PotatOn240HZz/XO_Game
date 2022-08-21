import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showResetAndHomepageDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe Game'),
          backgroundColor: Colors.black,
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                const Divider(
                  thickness: 2,
                  color: Colors.black38,
                ),
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
        backgroundColor: Colors.blue,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/XO.png', width: 130),
            const SizedBox(height: 70),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/TTT',
                  arguments: {'isAI': false},
                );
              },
              child: const Text(
                "Two Players\nGame",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/TTT',
                  arguments: {'isAI': true},
                );
              },
              child: const Text(
                "Single Player\nGame",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.blue),
              ),
            ),
          ],
        )),
      ),
    );
  }

  showResetAndHomepageDialog(BuildContext context) {
    //if is false that means reset button was pressed, otherwise homepage button was pressed
    String alertTitle = "AlertDialog";
    String alertContent;
    String continueButtonText;
    alertContent =
        "You sure you want to leave the game?\nAny progress made will be lost";
    continueButtonText = "Quit";

    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(continueButtonText),
      onPressed: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );

    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: Text(alertContent),
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
