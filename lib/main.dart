import 'package:expenses_wallet_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //REMOVED DEBUG BANNER FOR AEST. PURPOSES
      title: 'Götür',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(
          secondary: Colors.amber,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyMedium: TextStyle(
                color: Colors.green,
                fontSize: 14,
              ),
              titleLarge: TextStyle(
                color: Colors.deepPurple,
                fontSize: 22,
              ),
              displayLarge: TextStyle(fontSize: 24),
            ),
        appBarTheme: AppBarTheme(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.deepPurple,
          iconTheme: IconThemeData(
            color: Colors.red,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.amber,
          ),
          //DID NOT UNDERSTAND
          titleTextStyle: TextStyle(
              color: Colors.amber,
              fontFamily: 'OpenSans',
              fontSize: 24,
              fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String? titleInput;

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   amount: 69.99,
    //   title: 'New Shoes',
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   amount: 16.53,
    //   title: 'Weekly groceries',
    //   date: DateTime.now(),
    // ),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList(); //IF YOU REMOVE THIS LINE THROWS AN ERROR!!!!!!!!!
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      date: DateTime.now(),
      amount: txAmount,
      title: txTitle,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          //GESTURE DETECTOR NOT NEEDED ANYMORE, HENCE ADDED FOR PRACTICE
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Götür',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.deepPurple,
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
