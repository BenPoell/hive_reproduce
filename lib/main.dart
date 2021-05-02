import 'package:flutter/material.dart';
import 'package:hive_reproduce/flavorConfig.dart';
import 'package:hive_reproduce/hiveSetup.dart';

Future<void> main() async {
  try {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
    };

    var tokenBox = await HiveSetup().initBox('token');

    if (tokenBox != null) {
      FlavorConfig(
          flavor: Flavor.Dev, values: FlavorValues(tokenBox: tokenBox));

      runApp(
        MaterialApp(
          title: 'Named Routes Demo',
          // Start the app with the "/" named route. In this case, the app starts
          // on the FirstScreen widget.
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => FirstScreen(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/second': (context) => SecondScreen(),
          },
        ),
      );
    } else {
      throw "Error during init Hive DB!";
    }
  } on Exception catch (_) {
    print(_.toString());
  } catch (error) {
    print(error.toString());
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the `FirstScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
          child: Text('Launch screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlavorConfig.instance.values.tokenBox.put('accessToken', "lalelu");

    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the SecondScreen widget
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
