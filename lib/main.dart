import 'package:flutter/material.dart';
import 'pages/students_page.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'القائمة الرئيسية',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ExpansionTile(
                    leading: _iconWithBackground(
                      icon: Icons.attach_money,
                      backgroundColor: Colors.green,
                    ),
                    title: Text('الإيرادات',
                        style: TextStyle(color: Colors.white)),
                    children: <Widget>[
                      ListTile(
                        leading: _iconWithBackground(
                          icon: Icons.school,
                          backgroundColor: Colors.blueAccent,
                        ),
                        title: Text('الأقساط الدراسية',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: _iconWithBackground(
                          icon: Icons.directions_bus,
                          backgroundColor: Colors.orangeAccent,
                        ),
                        title: Text('اشتراك الباص',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: _iconWithBackground(
                          icon: Icons.sports,
                          backgroundColor: Colors.redAccent,
                        ),
                        title: Text('إيرادات الأنشطة الرياضية',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                    ],
                  ),
                  ExpansionTile(
                    leading: _iconWithBackground(
                      icon: Icons.money_off,
                      backgroundColor: Colors.red,
                    ),
                    title: Text('المصروفات',
                        style: TextStyle(color: Colors.white)),
                    children: <Widget>[
                      ListTile(
                        leading: _iconWithBackground(
                          icon: Icons.people,
                          backgroundColor: Colors.purpleAccent,
                        ),
                        title: Text('رواتب الموظفين',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: _iconWithBackground(
                          icon: Icons.build,
                          backgroundColor: Colors.blueGrey,
                        ),
                        title: Text('صيانة المباني',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: _iconWithBackground(
                          icon: Icons.shopping_cart,
                          backgroundColor: Colors.teal,
                        ),
                        title: Text('المصروفات الإدارية',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                    ],
                  ),
                  ExpansionTile(
                    leading: _iconWithBackground(
                      icon: Icons.person,
                      backgroundColor: Colors.amber,
                    ),
                    title: Text('الموظفون',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    children: <Widget>[
                      ListTile(
                        leading: _iconWithBackground(
                          icon: Icons.badge,
                          backgroundColor: Colors.cyan,
                        ),
                        title: Text('إضافة موظف',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: _iconWithBackground(
                          icon: Icons.list,
                          backgroundColor: Colors.orange,
                        ),
                        title: Text('عرض قائمة الموظفين',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {},
                      ),
                    ],
                  ),
                  ListTile(
                    leading: _iconWithBackground(
                      icon: Icons.bar_chart,
                      backgroundColor: Colors.indigo,
                    ),
                    title:
                        Text('التقارير', style: TextStyle(color: Colors.white)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: _iconWithBackground(
                      icon: Icons.settings,
                      backgroundColor: Colors.grey,
                    ),
                    title: Text('الإعدادات',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {},
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
                      print('إضافة طالب');
                    },
                  ),
                  _buildMainIcon(
                    icon: Icons.attach_money,
                    label: 'الإيرادات',
                    onTap: () {
                      print('الإيرادات');
                    },
                  ),
                  _buildMainIcon(
                    icon: Icons.money_off,
                    label: 'المصروفات',
                    onTap: () {
                      print('المصروفات');
                    },
                  ),
                  _buildMainIcon(
                    icon: Icons.bar_chart,
                    label: 'التقارير',
                    onTap: () {
                      print('التقارير');
                    },
                  ),
                  _buildMainIcon(
                    icon: Icons.settings,
                    label: 'الإعدادات',
                    onTap: () {
                      print('الإعدادات');
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
  Widget _buildMainIcon(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
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
            Icon(icon,
                size: 48, color: const Color.fromARGB(255, 71, 223, 190)),
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

  // تصميم الأيقونة داخل دائرة
  Widget _iconWithBackground(
      {required IconData icon, required Color backgroundColor}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
