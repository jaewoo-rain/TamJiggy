import 'package:flutter/material.dart';
import 'package:tam_jiggy/home/tabs/home_screen/home_screen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeScreen(),
    TravelScreen(),
    ChatScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TOM.jigi"),
        backgroundColor: Colors.white,
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 아이콘 크기 변화 방지
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedIconTheme: IconThemeData(size: 24, color: Colors.blue),
        unselectedIconTheme: IconThemeData(size: 24, color: Colors.black),

        // iconSize: ,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "여행"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "채팅"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "장바구니"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이페이지"),
        ],
      ),
    );
  }
}

class TravelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("여행 화면"),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("채팅 화면"),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("장바구니 화면"),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("마이페이지 화면"),
    );
  }
}
