import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.orange,
      ),

      body: Column(
        children: [
          SwitchListTile(
            title: Text('Dark Theme'),
            value: isDarkMode, onChanged: (value) {
            isDarkMode = value;
            setState(() {
            });
          },)
        ],
      ),
    );
  }
}