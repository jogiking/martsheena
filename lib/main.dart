import 'package:flutter/material.dart';
import 'package:martsheena/listviewer.dart';
import 'package:martsheena/settingpage.dart';

import 'dart:async';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /**
       * Tab 사용법
       * 스크린을 TabController 위젯으로 구성함
       * TabBar: 사용할 탭을 구성. appBar의 bottom으로 구현
       * TabBarView: 탭이 선택될 시 디스플레이할 컨텐트 구성. body로 구현
       */
      home: DefaultTabController(
        // 탭의 수 설정
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('마트쉬나?'),
            // TabBar 구현. 각 컨텐트를 호출할 탭들을 등록
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.search)),
              ],
            ),
          ),
          // TabVarView 구현. 각 탭에 해당하는 컨텐트 구성
          body: TabBarView(
            children: [
              HomePage(),// Icon(Icons.directions_car),
              ExplicitListConstructing(),//Icon(Icons.directions_transit),
              // Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}