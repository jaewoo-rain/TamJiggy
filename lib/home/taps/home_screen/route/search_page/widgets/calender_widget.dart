// 📌 달력 위젯
import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.close),
          title: Text("달력"),
          onTap: () => Navigator.pop(context),
        ),
        Expanded(
          child: Center(
            child: Text("📅 여기에 달력 UI 추가"),
          ),
        ),
      ],
    );
  }
}
