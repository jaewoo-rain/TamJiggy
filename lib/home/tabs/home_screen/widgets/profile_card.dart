import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String info;

  ProfileCard(
      {required this.imagePath, required this.name, required this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 165,
          height: 205,
          margin: EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // 하단에 텍스트 표시
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 완전히 투명
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name, // 예: '윌리엄즈'
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "2004년생 INFP 양자리", // 추가 정보
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "English ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: List.generate(
                                    3,
                                    (index) => Icon(Icons.star,
                                        color: Colors.orange, size: 14)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5), // 간격 추가
                          Row(
                            children: [
                              Text(
                                "French ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 14),
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 14),
                                  Icon(Icons.star_half,
                                      color: Colors.orange, size: 14), // 반쪽 별
                                ],
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
        ),
        Container(
          width: 150,
          height: 50,
          child: Text(
            info,
            style: TextStyle(color: Colors.black, fontSize: 12),
            overflow: TextOverflow.ellipsis, // 줄임표 설정
            maxLines: 3, // 한 줄로 제한
          ),
        ),
      ],
    );
  }
}
