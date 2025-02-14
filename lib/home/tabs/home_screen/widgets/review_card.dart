import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final int views;
  final int likes;

  ReviewCard({
    required this.image,
    required this.title,
    required this.author,
    required this.views,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4),
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                author,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.visibility, size: 14, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text("$views",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
            Row(
              children: [
                Icon(Icons.favorite, size: 14, color: Colors.redAccent),
                SizedBox(width: 4),
                Text("$likes",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
