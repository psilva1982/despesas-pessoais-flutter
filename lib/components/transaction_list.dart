import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDelete;

  TransactionList(this.transactions, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nenhuma transação encontrada',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constrains.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text('\$${tr.value.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 600
                      ? FlatButton.icon(
                          onPressed: () {
                            onDelete(tr.id);
                          },
                          icon: Icon(Icons.delete),
                          label: Text('Excluir'),
                          textColor: Theme.of(context).hintColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).hintColor,
                          onPressed: () {
                            onDelete(tr.id);
                          },
                        ),
                ),
              );
            },
          );
  }
}
