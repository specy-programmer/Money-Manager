import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/themes/colors.dart';
import 'package:money_manager/json/expense_page_json.dart';
import 'package:money_manager/pages/create_expense_page.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    CollectionReference test = _firestore.collection('testCollection');
    CollectionReference counters = FirebaseFirestore.instance.collection(
        'counterCollection');

    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Money Manager',
          style: TextStyle(color: Colors.black),),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: test.snapshots(),
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  List<DocumentSnapshot> listofDocumentSnap =
                      asyncSnapshot.data.docs;
                  return Flexible(
                    child: ListView.builder(
                      itemCount: listofDocumentSnap.length,
                      itemBuilder: (context, index) {
                        Map itemGet = listofDocumentSnap[index].data();
                        return Card(
                          child: ListTile(
                            leading: Image.asset(
                                categories[itemGet['kategoriNo']]['icon']),
                            title: RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle
                                    .of(context)
                                    .style,
                                children: <TextSpan>[
                                  TextSpan(text: '${itemGet['baslik']}' +
                                      '                                     '
                                          '',
                                      style: TextStyle(fontSize: 19)),
                                  TextSpan(text: '${itemGet['gider']}',
                                      style: TextStyle(color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ],
                              ),
                            ),
                            minVerticalPadding: 21,
                            subtitle: Text('${itemGet['tarih']}'),
                            isThreeLine: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.pink,
                                  ),
                                  onPressed: () async {
                                    sum = sum -
                                        listofDocumentSnap[index]['gider'];
                                    listofDocumentSnap[index]
                                        .reference
                                        .delete();
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 19),
                child: Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 230),
                      child: TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 16,
                              color: black.withOpacity(0.4),
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "$sum",
                        style: TextStyle(
                            fontSize: 20,
                            color: black,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}