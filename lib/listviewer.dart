import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:martsheena/settingpage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Market> list;
  List<String> list2 = ['없음'];
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  //초기에 값을 랜덤에 넣어줌.
  @override
  void initState() {
    super.initState();
    refreshList();
  }

  //async wait 을 쓰기 위해서는 Future 타입을 이용함
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 0)); //thread sleep 같은 역할을 함.
    //새로운 정보를 그려내는 곳
    setState(() {
      print('새로고침');

      list = marketList.where((element) =>  element.isObserving ).toList();
      print('after list');

      list2 = list.map((e) => e.name).toList();
//      var list2 = list.map((e) => e.info.toString());
      //['asdf', '안산고잔점', 'title', 'testtitle2'];

      FirebaseFirestore.instance
          .collection('info')
          .where('title', whereIn: list2)
          .get()
          .then ((value) {

            var e = value.docs.length;
          print('$e');
          var e2 = value.docs.map((e) => e.id);
          print('$e2');

      });
      // list = marketList;// List.generate(random.nextInt(100), (i) => "Item $i qeersd");
    });
    return null;
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("안산 고잔점"),
//      ),
//      body: RefreshIndicator(
//        key: refreshKey,
//        child: ListView.builder(
//          itemCount: list?.length,
//          itemBuilder: (context, i) => ListTile(
//            title: Text(list[i].name),
//            subtitle: Text(list[i].isObserving.toString()),
//          ),
//        ),
//        onRefresh: refreshList,
//      ),
//    );
//  }


  final db = FirebaseFirestore.instance;
//  @override
//  Widget build(BuildContext context) {
//
////    refreshList();
//    var le = list.length;
//    print('list length is $le');
//
//    return ListView.builder(
//        itemCount: list.length,
//        itemBuilder: (context, index) {
//          return Card(
//            child: ListTile(
//              title: Text(list[index].name),
//            ),
//          );
//        },
//      );
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("즐겨찾기"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('info').where('title', whereIn: list2).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: ListTile(
                    title: Text(doc.data()['title'] + " : " + doc.data()['openInfo']),
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}

class NoteList extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('info').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: ListTile(
                    title: Text(doc.data()['title']),
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}


//class NoteList extends StatelessWidget {
//  final db = FirebaseFirestore.instance;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Notes"),
//        centerTitle: true,
//      ),
//      body: StreamBuilder<QuerySnapshot>(
//        stream: db.collection('info').snapshots(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) {
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//          } else
//            return ListView(
//              children: snapshot.data!.docs.map((doc) {
//                return Card(
//                  child: ListTile(
//                    title: Text(doc.data()['title']),
//                  ),
//                );
//              }).toList(),
//            );
//        },
//      ),
//    );
//  }
//}