import 'package:flutter/material.dart';
import 'package:first_app/TransactionList.dart';
import 'package:first_app/NEWtrAnsaCTion.dart';
import 'package:first_app/Transaction.dart';
import 'package:first_app/Chart.dart';
import 'package:flutter/services.dart';


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses DEMO',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.purple,
        backgroundColor: Colors.black87,
        scaffoldBackgroundColor: Colors.black26,
        unselectedWidgetColor: Colors.redAccent,
        secondaryHeaderColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.dark().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 25,
              ),
            ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<Transaction> userTransaction = [
    //   Transaction(
    //       total: 99.9, date: DateTime.now(), id: 'New 1', tilte: 'New Shoes'),
    //   Transaction(
    //       total: 69.9,
    //       date: DateTime.now(),
    //       id: 'New 2',
    //       tilte: 'Weekly Glorious'),
  ];

  void startADDnewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (just) {
        return GestureDetector(
          child: NEWtrAnsaCTion(addTrAnSACtiOn),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  bool showCHART = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state ) {
  print(state);
  }

  @override
 dispose() {
      WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  List<Transaction> get recentTransaction {
    return userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTrAnSACtiOn(String aTtitle, double aTtotal, DateTime chosenDate) {
    final newat = Transaction(
        total: aTtotal,
        date: chosenDate,
        id: DateTime.now().toString(),
        tilte: aTtitle);

    setState(() {
      userTransaction.add(newat);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransaction.removeWhere((ele) {
        return ele.id == id;
      });
    });
  }

  Widget buildLandscapeContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Show Chart',
          style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 17.2),
        ),
        Switch.adaptive(
            activeColor: Colors.purple,
            inactiveTrackColor: Colors.black,
            value: showCHART,
            onChanged: (val) {
              setState(() {
                showCHART = val;
              });
            })
      ],
    );
  }

  Widget buildPortraitContent(AppBar apPBar) {

    return Container(
      height: (MediaQuery.of(context).size.height -
          apPBar.preferredSize.height -
          MediaQuery.of(context).padding.top) *
          0.3,
      child: Chart(recentTransaction),
    );

  }

  @override
  Widget build(BuildContext context) {

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final apPBar = AppBar(
      backgroundColor: Colors.greenAccent,
      title: const Text(
        'Personal Expenses ',
        //Its so long write better use FONTS  style: TextStyle (color: Colors.purple,fontWeight: FontWeight.w700,fontSize: 23,wordSpacing:5,fontStyle: FontStyle.italic)
        style: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 20,
            color: Colors.purple,
            fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
          onPressed: () => startADDnewTransaction(context),
          icon: const Icon(
            Icons.add,
            color: Colors.purple,
            size: 28.3,
          ),
        )
      ],
    );
    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
          apPBar.preferredSize.height -
          MediaQuery.of(context).padding.top) *
          0.5,
      child: transactionList(userTransaction, deleteTransaction),
    );

    return Scaffold(
      appBar: apPBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
               buildLandscapeContent(),
            if (!isLandscape)
                buildPortraitContent(apPBar),
            if (!isLandscape)
             txListWidget,
            if (isLandscape)
              showCHART
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              apPBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.4,
                      child: Chart(recentTransaction),
                    )
                  : Container(
                      height: (MediaQuery.of(context).size.height -
                              apPBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.5,
                      child:
                          transactionList(userTransaction, deleteTransaction))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startADDnewTransaction(context),
        focusColor: Colors.purple,
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30.5,
        ),
      ),
    );
  }
}
