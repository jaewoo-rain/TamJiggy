import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tam_jiggy/home/home.dart';
import 'package:tam_jiggy/select_page/select_bloc.dart';
import 'package:tam_jiggy/select_page/select_page.dart';

void main() {
  runApp(MyApp()); // runApp()에 MyApp 위젯을 전달해야 앱이 실행됩니다.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: Main(), // Scaffold가 포함된 HomePage로 시작
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('탐지기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => SelectBloc(),
                          child: SelectPage())),
                );
              },
              child: Text(
                'Select',
                style: TextStyle(fontSize: 30),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainHomePage()));
              },
              child: Text(
                'Home',
                style: TextStyle(fontSize: 30),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Button 2',
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Button 3',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
      ),
      body: Center(
        child: Text(
          'This is the Sub Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
