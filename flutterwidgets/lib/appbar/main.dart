import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Icon searchBtn = new Icon(Icons.search);
  Widget appBarTitle = new Text('HomePage');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: this.appBarTitle,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.black,
            Colors.white,
          ])),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (this.searchBtn.icon == Icons.search) {
                  this.searchBtn = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    autofocus: true,
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintText: 'Search..',
                        hintStyle: TextStyle(color: Colors.white)),
                  );
                } else {
                  this.searchBtn = new Icon(Icons.search);
                  this.appBarTitle = new Text('HomePage');
                }
              });
            },
            icon: this.searchBtn,
          )
        ],
      ),
      body: Center(
        child: Text('HomePage'),
      ),
    );
  }
}
