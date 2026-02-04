import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> stations = [
    '시청', '을지로입구', '을지로3가', '을지로4가', '동대문역사문화공원',
    '신당', '상왕십리', '왕십리', '한양대', '뚝섬', '성수', '건대입구',
    '구의', '강변', '잠실', '잠실새내', '종합운동장', '삼성', '선릉',
    '역삼', '강남', '교대', '서초', '방배', '사당', '낙성대', '서울대입구',
    '봉천', '신림', '신대방', '구로디지털단지', '대림', '신도림', '문래', '영등포구청',
    '당산', '합정', '홍대입구', '신촌', '이대', '아현', '충정로'
  ];

  String? boardingStation;
  String? destinationStation;
  String direction = '내선';

  @override
  void initState() {
    super.initState();
    NotificationService.init();
  }

  // MVP용: 단순 타이머로 5초 후 알람
  void startAlarm() {
    if (boardingStation == null || destinationStation == null) return;

    // 실제는 열차 위치 API 호출 후 목적지 1정거장 전 트리거
    Future.delayed(Duration(seconds: 5), () {
      NotificationService.showAlarm(
        'SubWake 알람!',
        '$destinationStation 1정거장 전입니다. 준비하세요!',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sub_wake')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: '승차역'),
              items: stations.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              value: boardingStation,
              onChanged: (v) => setState(() => boardingStation = v),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: '목적지'),
              items: stations.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              value: destinationStation,
              onChanged: (v) => setState(() => destinationStation = v),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('방향: '),
                Radio<String>(
                  value: '내선', groupValue: direction, onChanged: (v) => setState(() => direction = v!),
                ),
                Text('내선'),
                Radio<String>(
                  value: '외선', groupValue: direction, onChanged: (v) => setState(() => direction = v!),
                ),
                Text('외선'),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (boardingStation == null || destinationStation == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('승차역과 목적지를 선택해주세요'),
                  ));
                  return;
                }
                startAlarm();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('알람 시작! 5초 후 테스트 알람 울림')),
                );
              },
              child: Text('알람 시작'),
            ),
          ],
        ),
      ),
    );
  }
}
