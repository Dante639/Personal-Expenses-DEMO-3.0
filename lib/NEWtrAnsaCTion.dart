import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NEWtrAnsaCTion extends StatefulWidget {
  final Function addTranSActIon;

  NEWtrAnsaCTion(this.addTranSActIon) {
    print('Constructor New Transaction Widget' );
  }

  @override
  State<NEWtrAnsaCTion> createState() {
    print('createState New Transaction Widget' );
    return _NEWtrAnsaCTionState();

  }
}

class _NEWtrAnsaCTionState extends State<NEWtrAnsaCTion> {
  final titleController = TextEditingController();
  final totalController = TextEditingController();
  DateTime? selectDate;

  _NEWtrAnsaCTionState() {
    print('Constructor New Transaction Widget State' );
  }

  @override
  void initState() {
    // TODO: implement initState
    print('initState()' );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NEWtrAnsaCTion oldWidget) {
    // TODO: implement didUpdateWidget
    print('didUpdateWidget' );
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose()' );
    super.dispose();
  }

  void submidDatA() {
    if (totalController.text.isEmpty) {
      return;
    }
    final enterTITLE = titleController.text;
    final enterTOTAL = double.parse(totalController.text);

    if (enterTITLE.isEmpty || enterTOTAL <= 0 || selectDate == null) {
      return;
    }

    widget.addTranSActIon(
      enterTITLE,
      enterTOTAL,
      selectDate,
    );
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        selectDate = pickedData;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 10,
              right: MediaQuery.of(context).viewInsets.bottom + 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                   labelText: "Title",
                ),
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
                controller: titleController,
                onSubmitted: (_) => submidDatA(),
                // onChanged: (ti) {
                //titleInput = ti;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Total"),
                style: TextStyle(
                    color: Colors.purple,
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
                controller: totalController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submidDatA(),

                //onChanged: (to) {
                // totalInput = to;
                // },
              ),
              Container(
                height: 80.5,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date  ' +
                                DateFormat.yMd().format(selectDate!),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: presentDatePicker,
                      child: const Text(
                        'Chosen Date',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        shadowColor: Colors.black87,
                        padding: EdgeInsets.all(15.3),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  backgroundColor: Colors.black87,
                  shadowColor: Colors.purple,
                  padding: EdgeInsets.all(11.3),
                ),
                onPressed: submidDatA,
                // addTranSActIon(titleController.text,double.parse(totalController.text),);
                //},
                //print(titleInput);
                //print(totalInput);

                child: const Text(
                  'Add Transaction',
                  style: TextStyle(
                      fontSize: 22.3,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
