import 'package:flutter/material.dart';

class RevenuesPage extends StatefulWidget {
  @override
  _RevenuesPageState createState() => _RevenuesPageState();
}

class _RevenuesPageState extends State<RevenuesPage> {
  List<Map<String, dynamic>> revenues = [
    {"type": "الأقساط الدراسية", "amount": 5000, "date": "2024-01-01"},
    {"type": "اشتراك الباص", "amount": 2000, "date": "2024-01-15"},
    {"type": "إيرادات الأنشطة", "amount": 1500, "date": "2024-01-20"},
  ];

  void _showAddRevenueDialog() {
    String type = '';
    String amount = '';
    String date = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('إضافة إيراد جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'نوع الإيراد'),
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
                  revenues.add({
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
        title: Text('الإيرادات'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: revenues.length,
              itemBuilder: (context, index) {
                final revenue = revenues[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(revenue["type"]),
                    subtitle: Text("التاريخ: ${revenue["date"]}"),
                    trailing: Text("${revenue["amount"]} جنيه"),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _showAddRevenueDialog,
              icon: Icon(Icons.add),
              label: Text('إضافة إيراد جديد'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
