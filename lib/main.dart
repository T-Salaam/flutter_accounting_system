import 'package:accounting_app/pages/expenses_page.dart';
import 'package:accounting_app/pages/revenues_page.dart';
import 'package:flutter/material.dart';
import 'pages/students_page.dart';
import 'package:accounting_app/pages/reports_page.dart';
import 'package:accounting_app/pages/general_ledger_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: <Widget>[
          // الشريط الجانبي مع تحسين الديكور
          Container(
            width: screenWidth * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(255, 13, 161, 99), Color(0xFF1976D2)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text(
                      'الطلاب',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentsPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.attach_money, color: Colors.white),
                    title: Text(
                      'الإيرادات',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RevenuesPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bar_chart, color: Colors.white),
                    title: Text(
                      'التقارير',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReportsPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book, color: Colors.white),
                    title: Text(
                      'كراسة الأستاذ',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GeneralLedgerPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // المحتوى الرئيسي
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMainIcon(
                    icon: Icons.person,
                    label: 'إضافة طالب',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentsPage()),
                      );
                    },
                  ),
                  _buildMainIcon(
                    icon: Icons.attach_money,
                    label: 'الإيرادات',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RevenuesPage()),
                      );
                    },
                  ),
                  _buildMainIcon(
                    icon: Icons.money_off,
                    label: 'المصروفات',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExpensesPage()),
                      );
                    },
                  ),
                  _buildMainIcon(
                    icon: Icons.bar_chart,
                    label: 'التقارير',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReportsPage()),
                      );
                    },
                  ),
                  _buildMainIcon(
                    icon: Icons.settings,
                    label: 'الإعدادات',
                    onTap: () {
                      print('الإعدادات');
                    },
                  ),
                  _buildMainIcon(
                    icon: Icons.book,
                    label: 'كراسة الأستاذ',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GeneralLedgerPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // تصميم الأيقونات الرئيسية
  Widget _buildMainIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: const Color.fromARGB(255, 71, 223, 190),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
