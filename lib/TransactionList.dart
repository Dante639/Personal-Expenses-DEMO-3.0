import 'package:first_app/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';
import 'dart:math';

class transactionList extends StatefulWidget {
  final List<Transaction> transacTion;
  final Function deleteT;

  transactionList(this.transacTion, this.deleteT);

  @override
  State<transactionList> createState() => _transactionListState();
}

class _transactionListState extends State<transactionList> {

  Color? bgColor;

  @override
  void initState() {
    // TODO: implement initState
    const availbleColors = [
      Colors.red,
      Colors.black87,
      Colors.yellowAccent,
      Colors.blue,
      Colors.purple,
      Colors.indigo,
      Colors.green
    ];
    bgColor =availbleColors[Random().nextInt(7)];
    super.initState();
  }
 @override
  Widget build(BuildContext context) {
    return widget.transacTion.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
         const Text('No transactions added not yet :(',
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 35.2,
              )),
         const SizedBox(
            height: 13,
          ),
          Container(
              height: constraint.maxHeight * 0.6,
              child: Image.asset(
                'images/justin-lee-tomie03.jpg',
                fit: BoxFit.cover,
              ))
        ],
      );
    })
        : ListView.builder(
      itemBuilder: (dan, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 9.2, horizontal: 7.3),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: bgColor,
              radius: 50,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    '\$${widget.transacTion[index].total}',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              widget.transacTion[index].tilte,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 23.4),
            ),
            subtitle: Text(
              DateFormat.yMMMMEEEEd().format(
                widget.transacTion[index].date,
              ),
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.4),
            ),
            trailing: MediaQuery.of(context).size.width > 460
                ? TextButton.icon(
              onPressed: () => widget.deleteT(widget.transacTion[index].id),
              icon: Icon(Icons.delete,color: Colors.blue,),
              label: Text('Delete'),
            )
                : IconButton(
              icon: Icon(Icons.delete),
              color: Colors.blue,
              focusColor: Colors.red,
              onPressed: () => widget.deleteT(widget.transacTion[index].id),
            ),
          ),
        );
      },
      itemCount: widget.transacTion.length,
    );
  }
}