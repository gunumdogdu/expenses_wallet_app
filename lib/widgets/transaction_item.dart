import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTx,
  });

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(
              child: Text(
                '\₺${transaction.amount}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        subtitle: Text(
          style: Theme.of(context).textTheme.bodySmall,
          DateFormat.yMMMd().format(
            transaction.date,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () {
                  deleteTx(transaction.id);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => deleteTx(transaction.id),
              ),
      ),
    );
  }
}
