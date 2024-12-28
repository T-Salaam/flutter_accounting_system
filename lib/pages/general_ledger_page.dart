import 'package:flutter/material.dart';

class GeneralLedgerPage extends StatefulWidget {
  @override
  _GeneralLedgerPageState createState() => _GeneralLedgerPageState();
}

class _GeneralLedgerPageState extends State<GeneralLedgerPage> {
  // بيانات تجريبية للعرض
  final List<Map<String, dynamic>> ledgerData = [
    {
      "id": 1,
      "account_name": "الإيرادات",
      "debit": 0,
      "credit": 5000,
      "date": "2024-01-01",
      "description": "دفعة أقساط"
    },
    {
      "id": 2,
      "account_name": "المصروفات",
      "debit": 2000,
      "credit": 0,
      "date": "2024-01-02",
      "description": "صيانة المباني"
    },
    {
      "id": 3,
      "account_name": "الرواتب",
      "debit": 3000,
      "credit": 0,
      "date": "2024-01-03",
      "description": "رواتب الموظفين"
    },
  ];

  // عوامل التصفية
  String selectedAccount = "الكل";
  DateTime? startDate;
  DateTime? endDate;

  // البيانات بعد التصفية
  List<Map<String, dynamic>> get filteredData {
    List<Map<String, dynamic>> filtered = ledgerData;

    // تصفية حسب اسم الحساب
    if (selectedAccount != "الكل") {
      filtered = filtered
          .where((entry) => entry["account_name"] == selectedAccount)
          .toList();
    }

    // تصفية حسب التاريخ
    if (startDate != null && endDate != null) {
      filtered = filtered.where((entry) {
        DateTime entryDate = DateTime.parse(entry["date"]);
        return entryDate.isAfter(startDate!) && entryDate.isBefore(endDate!);
      }).toList();
    }

    return filtered;
  }

  // اختيار التواريخ
  Future<void> selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('كراسة الأستاذ العامة'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // فلاتر التصفية
            Row(
              children: [
                // تصفية حسب الحساب
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedAccount,
                    items: ["الكل", "الإيرادات", "المصروفات", "الرواتب"]
                        .map((account) {
                      return DropdownMenuItem(
                        value: account,
                        child: Text(account),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAccount = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                // اختيار المدة الزمنية
                ElevatedButton(
                  onPressed: () => selectDateRange(context),
                  child: Text('اختيار المدة الزمنية'),
                ),
              ],
            ),
            if (startDate != null && endDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'من: ${startDate!.toLocal()} إلى: ${endDate!.toLocal()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(height: 16),
            // جدول البيانات
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('التاريخ')),
                    DataColumn(label: Text('اسم الحساب')),
                    DataColumn(label: Text('مدين')),
                    DataColumn(label: Text('دائن')),
                    DataColumn(label: Text('الوصف')),
                  ],
                  rows: filteredData.map((entry) {
                    return DataRow(cells: [
                      DataCell(Text(entry["date"])),
                      DataCell(Text(entry["account_name"])),
                      DataCell(Text('${entry["debit"]} جنيه')),
                      DataCell(Text('${entry["credit"]} جنيه')),
                      DataCell(Text(entry["description"])),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            // زر إضافة عملية جديدة
            ElevatedButton.icon(
              onPressed: () {
                // فتح صفحة لإضافة عملية جديدة
              },
              icon: Icon(Icons.add),
              label: Text('إضافة عملية جديدة'),
            ),
          ],
        ),
      ),
    );
  }
}
