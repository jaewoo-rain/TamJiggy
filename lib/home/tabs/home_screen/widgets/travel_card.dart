import 'package:flutter/material.dart';

class TravelCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final String subtitle;
  final String location;
  final int views;
  final int likes;

  TravelCard({
    required this.title,
    required this.imagePath,
    required this.subtitle,
    required this.location,
    required this.views,
    required this.likes,
  });

  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  bool isFavorite = false; // 즐겨찾기 상태 관리

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 200,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(widget.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // 우측 상단 즐겨찾기 버튼
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite; // 상태 토글
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.8), // 반투명 배경
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border, // 상태에 따른 아이콘
                  color: isFavorite ? Colors.red : Colors.grey, // 상태에 따른 색상
                  size: 20,
                ),
              ),
            ),
          ),
          // 하단 텍스트
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.white70, size: 14),
                          SizedBox(width: 4),
                          Text(
                            widget.location,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.visibility,
                              color: Colors.white70, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "${widget.views}",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.favorite,
                              color: Colors.redAccent, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "${widget.likes}",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
