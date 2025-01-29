// 📌 인원 선택 위젯
import 'package:flutter/material.dart';

class PeopleSelectWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.close),
          title: Text("인원 선택"),
          onTap: () => Navigator.pop(context),
        ),
        Expanded(
          child: Center(
            child: Text("인원 선택 UI"),
          ),
        ),
      ],
    );
  }
}
