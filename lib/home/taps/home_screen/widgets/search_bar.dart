import 'package:flutter/material.dart';

class TravelSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: " 여행하고 싶은 곳이 있나요?",
              ),
            ),
          ),
          Icon(Icons.search, color: Colors.black),
        ],
      ),
    );
  }
}
