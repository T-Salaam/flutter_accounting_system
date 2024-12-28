import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<Map<String, dynamic>> students = [
    {"name": "أحمد علي", "class": "البلاي سكول", "fees": 1500},
    {"name": "سارة محمد", "class": "ابتدائي 1", "fees": 2000},
    {"name": "عمر خالد", "class": "ابتدائي 2", "fees": 1800},
  ];
  void _showAddStudentDialog() {
    String name = '';
    String studentClass = '';
    String fees = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('إضافة طالب جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'اسم الطالب'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'المرحلة الدراسية'),
                onChanged: (value) {
                  studentClass = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'الرسوم المدفوعة'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  fees = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // إغلاق النافذة
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  students.add({
                    "name": name,
                    "class": studentClass,
                    "fees": int.tryParse(fees) ?? 0,
                  });
                });
                Navigator.pop(context); // إغلاق النافذة
              },
              child: Text('إضافة'),
            ),
          ],
        );
      },
    );
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الطلاب'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // مربع البحث
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'بحث عن طالب',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          // جدول البيانات
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("الاسم")),
                  DataColumn(label: Text("المرحلة الدراسية")),
                  DataColumn(label: Text("الرسوم المدفوعة")),
                  DataColumn(label: Text("خيارات")),
                ],
                rows: students
                    .where((student) => student["name"]
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()))
                    .map((student) {
                  return DataRow(cells: [
                    DataCell(Text(student["name"])),
                    DataCell(Text(student["class"])),
                    DataCell(Text(student["fees"].toString())),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // تعديل بيانات الطالب
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              students.remove(student);
                            });
                          },
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
          // زر لإضافة طالب جديد
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                _showAddStudentDialog();
                // فتح نافذة لإضافة طالب
              },
              icon: Icon(Icons.add),
              label: Text('إضافة طالب جديد'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
