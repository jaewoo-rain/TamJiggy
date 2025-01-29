// 📌 지도 보기 위젯
import 'package:flutter/material.dart';

class MapViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.close),
          title: Text("지도 보기"),
          onTap: () => Navigator.pop(context),
        ),
        Expanded(
          child: Center(
            child: Text("지도 UI"),
          ),
        ),
      ],
    );
  }
}
