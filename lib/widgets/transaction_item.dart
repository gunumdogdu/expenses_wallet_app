import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    required Key key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;
  @override
  void initState() {
    const avaliableColors = [
      Colors.amber,
      Colors.yellow,
      Colors.orange,
      Colors.lime,
    ];
    _bgColor = avaliableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(
              child: Text(
                '\₺${widget.transaction.amount}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          // backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          DateFormat.yMMMd().format(
            widget.transaction.date,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () {
                  widget.deleteTx(widget.transaction.id);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              ),
      ),
    );
  }
}
