import 'package:find_friend/models/transaction_model.dart';
import 'package:find_friend/services/fetch_transaction.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  late String userid;
  Transaction(this.userid);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  late Future<TransactionModel> tm;
  @override
  void initState() {
    tm = TransactionServices.getHistory(widget.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Transaction'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFF2596BE),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Amount',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Remark',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFF6A6A6C).withOpacity(0.6),
              child: FutureBuilder<TransactionModel>(
                  future: tm,
                  builder: (context, snapshot) {
                    return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                                '${snapshot.data!.data![index].date}'
                                                    .substring(0, 10)))),
                                    Expanded(
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '₹ ${snapshot.data!.data![index].amount}',
                                            style: TextStyle(
                                                color:
                                                    ('${snapshot.data!.data![index].remark}' ==
                                                            'deposit'
                                                        ? Colors.green
                                                        : Colors.red),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          ('${snapshot.data!.data![index].remark}' ==
                                                  'deposit')
                                              ? Icon(Icons.add_circle,
                                                  size: 14,
                                                  color:
                                                      ('${snapshot.data!.data![index].remark}' ==
                                                              'deposit'
                                                          ? Colors.green
                                                          : Colors.red))
                                              : Icon(Icons.remove_circle,
                                                  size: 14,
                                                  color:
                                                      ('${snapshot.data!.data![index].remark}' ==
                                                              'deposit'
                                                          ? Colors.green
                                                          : Colors.red))
                                        ],
                                      )),
                                    ),
                                    Expanded(
                                        child: Text(
                                            '         ${snapshot.data!.data![index].remark}',
                                            textAlign: TextAlign.left)),
                                  ],
                                ),
                              ),
                              Divider(thickness: 2)
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
