import 'package:flutter/material.dart';

class StudentsPage extends StatelessWidget {
  final List<Map<String, dynamic>> students = [
    {
      "serial": 1,
      "id": "1001",
      "name": "Ahmed Mohamed",
      "stage": "Grade 1",
      "class": "Class 1",
      "paid": 500,
      "remaining": 100,
      "paymentMethod": "Cash",
      "status": "Paid"
    },
    {
      "serial": 2,
      "id": "1002",
      "name": "Mohamed Ali",
      "stage": "Grade 2",
      "class": "Class 2",
      "paid": 700,
      "remaining": 0,
      "paymentMethod": "Bank Transfer",
      "status": "Paid"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إدارة الطلاب"),
        backgroundColor: Color.fromARGB(255, 13, 161, 99),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // زر إضافة طالب جديد
            ElevatedButton.icon(
              onPressed: () {
                print("إضافة طالب جديد");
                // تنفيذ العملية هنا
              },
              icon: Icon(Icons.add),
              label: Text("إضافة طالب جديد"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 13, 161, 99),
              ),
            ),
            SizedBox(height: 10),
            // جدول عرض بيانات الطلاب
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0,
                  columns: [
                    DataColumn(
                        label: Text('م',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('رقم الطالب',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('الاسم',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('المرحلة',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('الصف',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('المبلغ المدفوع',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('المبلغ المتبقي',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('طريقة الدفع',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('الحالة',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: students.map((student) {
                    return DataRow(
                      cells: [
                        DataCell(Text(student['serial'].toString())),
                        DataCell(Text(student['id'])),
                        DataCell(Text(student['name'])),
                        DataCell(Text(student['stage'])),
                        DataCell(Text(student['class'])),
                        DataCell(Text(student['paid'].toString())),
                        DataCell(Text(student['remaining'].toString())),
                        DataCell(Text(student['paymentMethod'])),
                        DataCell(Text(student['status'])),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
