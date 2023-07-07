import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_example/model.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(const MyApp());
}

String suiteName = "group.com.example.flutterUiExample1";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoWidget(),
      color: Colors.white,
      routes: <String, WidgetBuilder>{
        "/mine": (BuildContext context) => const MineWidget(),
      },
    );
  }
}

class DemoWidget extends StatelessWidget {
  MethodChannel channel = const MethodChannel("com.example.flutterUiExample");

  DemoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo!"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                var json = jsonEncode(
                  FlutterPhotoWidgetData(
                    family: WidgetFamilyEnum.systemSmall,
                    photo: "https://picsum.photos/200/300",
                  ),
                );
                WidgetKit.setItem("add", json, suiteName);
                channel.invokeMethod("add");
              },
              child: const Text("add small widget"),
            ),
            ElevatedButton(
              onPressed: () {
                var json = jsonEncode(
                  FlutterPhotoWidgetData(
                    family: WidgetFamilyEnum.systemMedium,
                    photo: "https://picsum.photos/200/300",
                  ),
                );
                WidgetKit.setItem("add", json, suiteName);
                channel.invokeMethod("add");
              },
              child: const Text("add medium widget"),
            ),
            ElevatedButton(
              onPressed: () {
                var json = jsonEncode(
                  FlutterPhotoWidgetData(
                    family: WidgetFamilyEnum.systemLarge,
                    photo: "https://picsum.photos/200/300",
                  ),
                );
                WidgetKit.setItem("add", json, suiteName);
                channel.invokeMethod("add");
              },
              child: const Text("add large widget"),
            ),
            ElevatedButton(
              onPressed: () {
                var json = jsonEncode(
                  FlutterTimeWidgetData(
                    family: WidgetFamilyEnum.systemLarge,
                    time: "https://picsum.photos/200/300",
                  ),
                );
                WidgetKit.setItem("add", json, suiteName);
                channel.invokeMethod("add");
              },
              child: const Text("add large widget 2"),
            ),
            ElevatedButton(
              onPressed: () {
                var json = jsonEncode(
                  FlutterTimeWidgetData(
                    family: WidgetFamilyEnum.systemLarge,
                    time: "https://picsum.photos/200/300",
                  ),
                );
                WidgetKit.setItem("remove", json, suiteName);
                channel.invokeMethod("remove");
              },
              child: const Text("remove large widget 2"),
            ),
            ElevatedButton(
              onPressed: () {
                var json = jsonEncode(
                  FlutterPhotoWidgetData(
                    family: WidgetFamilyEnum.accessoryCircular,
                    photo: "https://picsum.photos/200/300",
                  ),
                );
                WidgetKit.setItem("add", json, suiteName);
                channel.invokeMethod("add");
              },
              child: const Text("add circular widget"),
            ),
          ],
        ),
      ),
    );
  }
}

class MineWidget extends StatelessWidget {
  const MineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("into mine widget");
    return Container(
      color: Colors.red,
      width: 200,
      height: 200,
    );
  }
}

class TabBar extends StatefulWidget {
  const TabBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabBar();
  }
}

class _TabBar extends State<TabBar> {
  @override
  void initState() {
    super.initState();
    initPlatformStateForStringUniLinks();
  }

  Color? customColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.conversation_bubble),
            label: 'Support',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              previousPageTitle: 'Tap me',
              onPressed: () {
                MethodChannel channel =
                    const MethodChannel("com.example.flutterUiExample");
                channel.invokeMethod("ui");
              },
            ),
            middle: Text('Page 1 of tab $index'),
          ),
          child: Container(
            color: customColor ?? Colors.white,
          ),
        );
      },
    );
  }

  Future<void> initPlatformStateForStringUniLinks() async {
    String? initialLink;
    try {
      initialLink = await getInitialLink();
      print("aaaaa");
      print(initialLink);
      if (initialLink == "mine") {
        setState(() {
          customColor = Colors.red;
        });
      }
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }
  }
}
