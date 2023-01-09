import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FavoriteWidget(),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  static const likedKey = 'liked_key';

  late bool liked;
  String text = '';
  String input = '';
  String test = '';

  @override
  void initState() {
    super.initState();
    _restorePersistedPreference();
  }

  void _restorePersistedPreference() async {
    var preferences = await SharedPreferences.getInstance();
    var liked = preferences.getBool(test) ?? false;
    setState(() => this.liked = liked);
  }

  void _persistPreference() async {
    setState(() => liked = !liked);
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool(test, liked);
  }

  void _saveString(String text) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('text', text);
  }

  void _loadString() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString('text') ?? '';
    setState(() {
      this.text = text;
      test = text;

      // _restorePersistedPreference();
      // _persistPreference();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            child: TextField(
              onChanged: (input) {
                setState(() {
                  text = input;
                  _saveString(text);
                });
              },
            ),
            width: double.infinity,
            height: 100,
          ),
          IconButton(onPressed: _loadString, icon: Icon(Icons.abc)),
          Container(
            child: liked == null
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.black,
                          width: 100,
                          height: 100,
                          child: IconButton(
                            icon: Icon(
                              liked ? Icons.favorite : Icons.favorite_border,
                              color: liked ? Colors.red : Colors.grey,
                            ),
                            onPressed: _persistPreference,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            child: Center(child: Text(text)),
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
            child: Text(test),
          ),
        ],
      ),
    );
  }
}
