import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'FoundItem.dart';
import 'LostItem.dart';
import 'ItemDetail.dart';
import 'SettingsScreen.dart';
import 'ProfileScreen.dart';

class Dashboard extends StatefulWidget {
  String? name;
  Dashboard(this.name);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  List<Map<String, dynamic>> dynamicItems = [];


  void _logout(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Log Out"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  // OPEN LOST ITEM SCREEN
  Future<void> _openLost() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LostItem()),
    );

    if (result != null) {
      setState(() {
        dynamicItems.insert(0, result);
      });
    }
  }

  // OPEN FOUND ITEM SCREEN
  Future<void> _openFound() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FoundItem()),
    );

    if (result != null) {
      setState(() {
        dynamicItems.insert(0, result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      // APP BAR (UNCHANGED DESIGN)
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text(
          'Lost & Found',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_sharp),
            onPressed: () => _logout(context),
          ),
        ],
      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[800]),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


              const SizedBox(height: 12),


              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _openLost,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Lost Item",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _openFound,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Found Item", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                'Recent Items',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
              ),

              const SizedBox(height: 12),


              Expanded(
                child: ListView(
                  children: [


                    ...dynamicItems.map((item) => Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Icon(
                          item['isLost']
                              ? Icons.report_problem
                              : Icons.check_circle,
                          color: item['isLost']
                              ? Colors.red
                              : Colors.green,
                        ),
                        title: Text(item['title']),
                        subtitle: Text(item['description']),
                        trailing: Text(item['date']),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ItemDetail(
                                itemTitle: item['title'],
                                description: item['description'],
                                date: item['date'],
                                isLost: item['isLost'],
                                itemType: item['itemType'],
                                contact: item['contact'],

                              ),
                            ),
                          );
                        },
                      ),
                    )),

                    const SizedBox(height: 10),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
