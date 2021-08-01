import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selected = 0;
  late PageController _pageController;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    this._pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    this._pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      key: this._drawerKey,
      endDrawer: Drawer(
        child: ListView(),
      ),
      backgroundColor: Colors.grey.shade200,
      appBar: _appBar(
        context,
      ),
      body: PageView(
        controller: this._pageController,
        children: [
          Container(
            child: Center(
              child: Text('현재 진행중인 콘테스트가 없습니다.'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: this.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _listTile(
                    title: this.data[index]['title'],
                    day: this.data[index]['day'],
                    point: this.data[index]['point'],
                    context: context);
              },
            ),
          ),
          Container(
            child: Center(
              child: Text('현재 알림이 없습니다.'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int i) {
          this._pageController.jumpToPage(i);
          setState(() {
            this.selected = i;
          });
        },
        currentIndex: this.selected,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '문제출제'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: '문제풀기'),
          BottomNavigationBarItem(icon: Icon(Icons.add_alert), label: '알림'),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> data = [
    {'title': '조준기 킬패스 3,5주차 변형 1번', 'day': 'D-10', 'point': '0 P ~ 0 P'},
    {'title': '조준기 킬패스 3,5주차 변형 2번', 'day': 'D-9', 'point': '0 P ~ 5 P'},
    {'title': '조준기 킬패스 3,5주차 변형 3번', 'day': 'D-8', 'point': '0 P ~ 10 P'},
  ];

  Widget _listTile({
    required String title,
    required String day,
    required String point,
    required BuildContext context,
  }) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(5.0),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    day,
                    style: TextStyle(color: Colors.red, fontSize: 10.0),
                  )),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.only(left: 100.0),
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    point,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Container(
            child: Text('난이도 :'),
          ),
          Container(
            child: Text('참여자 : '),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar(
    BuildContext context,
  ) {
    if (this.selected == 0) {
      return AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (this._drawerKey.currentState!.isEndDrawerOpen) {
                  this._drawerKey.currentState!.openDrawer();
                } else {
                  this._drawerKey.currentState!.openEndDrawer();
                }
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ))
        ],
        elevation: 1.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0))),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.all(30.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '문제출제',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: '검색'),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromRadius(70.0),
        ),
      );
    } else if (this.selected == 1) {
      return AppBar(
        elevation: 1.0,
        actions: [
          IconButton(
              onPressed: () {
                if (this._drawerKey.currentState!.isEndDrawerOpen) {
                  this._drawerKey.currentState!.openDrawer();
                } else {
                  this._drawerKey.currentState!.openEndDrawer();
                }
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              )),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0))),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.all(30.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '문제풀기',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: '검색'),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromRadius(70.0),
        ),
      );
    } else {
      return AppBar(
        elevation: 1.0,
        actions: [
          IconButton(
              onPressed: () {
                if (this._drawerKey.currentState!.isEndDrawerOpen) {
                  this._drawerKey.currentState!.openDrawer();
                } else {
                  this._drawerKey.currentState!.openEndDrawer();
                }
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              )),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0))),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.all(30.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        '알림',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.restore_from_trash_rounded),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          preferredSize: Size.fromRadius(50.0),
        ),
      );
    }
  }
}
