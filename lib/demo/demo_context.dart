import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  String textStr = "String text of build context";

  GlobalKey txtKey = GlobalKey();
  GlobalKey btnKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter BuildContext Demo'),
        ),
        floatingActionButton: FloatingActionButton(
          key: btnKey,
          onPressed: () {
            print("context Scaffold: $context");

            // RenderBox? textRenderbox =
            //     txtKey.currentContext?.findRenderObject() as RenderBox?;
            // RenderBox? btnRenderbox =
            //     btnKey.currentContext?.findRenderObject() as RenderBox?;

            // print("txtKey: ${textRenderbox!.localToGlobal(Offset.zero)}");
            // print("txtKey: ${textRenderbox.size}");
            // print("-------------------");
            // print("btnKey: ${btnRenderbox!.localToGlobal(Offset.zero)}");
            // print("btnKey: ${btnRenderbox.size}");

            // print("-------------------");
            // MyApp? myApp =
            //     btnKey.currentContext!.findAncestorWidgetOfExactType();
            // print(myApp?.textStr);
          },
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                key: txtKey,
                'Text 1',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Text(
                'Text 2',
                style: TextStyle(fontSize: 40),
              ),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('ok'),
                        ),
                      );
                    },
                    child: const Text('SHOW SNACKBAR'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
