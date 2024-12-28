import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  List<Map<String, dynamic>> expenses = [
    {"type": "رواتب الموظفين", "amount": 8000, "date": "2024-01-05"},
    {"type": "صيانة المباني", "amount": 3000, "date": "2024-01-10"},
    {"type": "مصروفات إدارية", "amount": 2500, "date": "2024-01-15"},
  ];

  void _showAddExpenseDialog() {
    String type = '';
    String amount = '';
    String date = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('إضافة مصروف جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'نوع المصروف'),
                onChanged: (value) {
                  type = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'المبلغ'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  amount = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'التاريخ'),
                onChanged: (value) {
                  date = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  expenses.add({
                    "type": type,
                    "amount": int.tryParse(amount) ?? 0,
                    "date": date,
                  });
                });
                Navigator.pop(context);
              },
              child: Text('إضافة'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المصروفات'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(expense["type"]),
                    subtitle: Text("التاريخ: ${expense["date"]}"),
                    trailing: Text("${expense["amount"]} جنيه"),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _showAddExpenseDialog,
              icon: Icon(Icons.add),
              label: Text('إضافة مصروف جديد'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
