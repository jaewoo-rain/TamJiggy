import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tam_jiggy/home/tabs/home_screen/route/search_page/search_bloc.dart';
import 'package:tam_jiggy/home/tabs/home_screen/route/search_page/search_screen.dart';

class TravelSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => SearchBloc(),
            child: SearchPage(), // MaterialApp 제거
          );
          ;
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " 여행하고 싶은 곳이 있나요?",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            Icon(Icons.search, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
