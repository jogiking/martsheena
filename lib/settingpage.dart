import 'package:flutter/material.dart';

class CheckList extends StatefulWidget {
  CheckList({Key? key, required this.market}) : super(key: key);
  Market market;
  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
//  bool _ischecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.market.name),
      subtitle: Text(widget.market.info),
      value: widget.market.isObserving, //_ischecked,
      onChanged: (bool? value) {
        setState(() {
//          _ischecked = value!;
          widget.market.isObserving = value!;
        });
      },
      secondary: const Icon(Icons.shopping_bag),
      activeColor: Colors.red,
      checkColor: Colors.black,
      isThreeLine: false,
      selected: widget.market.isObserving,
    );
  }
}

class Market {
  String name;
  int number;
  bool isObserving = false;
  String info;

  Market(this.name, this.info, this.number);
}

//var marketList = List<Market>();
List<Market> marketList = [
  Market('강동점', '서울', 10),
  Market('강서점', '서울', 20),
  Market('거제점', '경남/제주', 30),
  Market('경주점', '경북/울산', 30),
  Market('계산점', '인천', 30),
  Market('광주계림점', '광주/전라', 30),
  Market('남대구점', '대구', 30),
  Market('대전가오점', '대전/충청', 30),
  Market('부산정관점', '부산', 30),
  Market('부천여월점', '경기', 30),
  Market('안산고잔점', '경기', 30),
  Market('안산선부점', '경기', 30),
  Market('안산점', '경기', 30),
  Market('작전점', '인천', 30),
  Market('춘천점', '강원', 30)
];

class ExplicitListConstructing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      separatorBuilder: (context, index) {
        if (index == 0) return SizedBox.shrink();
        return const Divider();
      },
      itemCount: marketList.length,
      itemBuilder: (context, index) {
//      if (index == 0) return HeaderTile();
        var temp = marketList[index].isObserving;
        print('in building: $index, $temp');
        return CheckList(market: marketList[index]);
      },
//      <Widget>[
////        HeaderTile(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//        CheckList(),
//      ],
    );
  }
}


//class _CheckListState extends State<CheckList> {
//  bool _ischecked = false;
//  @override
//  Widget build(BuildContext context) {
//    return CheckboxListTile(
//      title: const Text('title : CheckBox'),
//      subtitle: const Text('subtitle : click me!'),
//      value: _ischecked,
//      onChanged: (bool? value) {
//        setState(() {
//          _ischecked = value!;
//        });
//      },
//      secondary: const Icon(Icons.home),
//      activeColor: Colors.red,
//      checkColor: Colors.black,
//      isThreeLine: false,
//      selected: _ischecked,
//    );
//  }
//}