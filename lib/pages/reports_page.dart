import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final List<Map<String, dynamic>> revenues = [
    {"type": "الأقساط الدراسية", "amount": 10000, "date": DateTime(2024, 1, 1)},
    {"type": "اشتراك الباص", "amount": 5000, "date": DateTime(2024, 1, 15)},
  ];

  final List<Map<String, dynamic>> expenses = [
    {"type": "رواتب الموظفين", "amount": 8000, "date": DateTime(2024, 1, 5)},
    {"type": "صيانة المباني", "amount": 3000, "date": DateTime(2024, 1, 10)},
  ];

  String selectedType = "الإيرادات"; // نوع التقرير
  DateTime? startDate; // تاريخ البداية
  DateTime? endDate; // تاريخ النهاية

  List<Map<String, dynamic>> get filteredData {
    final data = selectedType == "الإيرادات" ? revenues : expenses;

    if (startDate == null || endDate == null) {
      return data;
    }

    return data.where((item) {
      return item["date"].isAfter(startDate!) &&
          item["date"].isBefore(endDate!);
    }).toList();
  }

  Future<void> selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'التقرير المالي: $selectedType',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Table.fromTextArray(
                headers: ['النوع', 'المبلغ', 'التاريخ'],
                data: filteredData.map((item) {
                  return [
                    item["type"],
                    '${item["amount"]} جنيه',
                    '${item["date"].toLocal()}'.split(' ')[0],
                  ];
                }).toList(),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                'الإجمالي: ${filteredData.fold<int>(0, (sum, item) => sum + (item["amount"] as int))} جنيه',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    // عرض نافذة الطباعة
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التقارير'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اختيار نوع التقرير
            Row(
              children: [
                DropdownButton<String>(
                  value: selectedType,
                  items: ["الإيرادات", "المصروفات"].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () => selectDateRange(context),
                  icon: Icon(Icons.date_range),
                  label: Text('تحديد المدة'),
                ),
              ],
            ),
            if (startDate != null && endDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'المدة: ${startDate!.toLocal()} إلى ${endDate!.toLocal()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(height: 16),
            // جدول البيانات
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('النوع')),
                    DataColumn(label: Text('المبلغ')),
                    DataColumn(label: Text('التاريخ')),
                  ],
                  rows: filteredData.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(item["type"])),
                      DataCell(Text('${item["amount"]} جنيه')),
                      DataCell(Text('${item["date"].toLocal()}'.split(' ')[0])),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            // زر تصدير التقرير
            ElevatedButton.icon(
              onPressed: generatePDF,
              icon: Icon(Icons.picture_as_pdf),
              label: Text('تصدير إلى PDF'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
