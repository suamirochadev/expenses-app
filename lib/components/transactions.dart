import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key, required this.transactions, required this.onRemove});

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {

    final availableHeight = MediaQuery.of(context).size.height * 0.6;
    
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      height: availableHeight,
      child: transactions.isEmpty
          ? FittedBox(
            child: SizedBox(
              height: availableHeight * 0.8,
              child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.asset(
                        'assets/images/budu.gif',
                        fit: BoxFit.cover,
                        scale: 1,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const FittedBox(
                      child: Text(
                        'No transactions yet!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          )
          : SizedBox(
            height: availableHeight * 0.8,
            child: ListView.builder(
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  final tr = transactions[index];
            
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: FittedBox(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.attach_money,
                                size: 14,
                              ),
                              Text(
                                tr.value.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(tr.title),
                        subtitle: Text(
                          DateFormat('d MMM y').format(tr.date),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red.withOpacity(0.7),
                          onPressed: () {
                            onRemove(tr.id);
                          },
                        ),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ),
          ),
    );
  }
}
