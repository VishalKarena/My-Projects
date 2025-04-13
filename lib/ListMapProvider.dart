import 'package:flutter/material.dart';

class ListMapProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _mData = [];

  //events
  void addData(Map<String, dynamic> data) {
    _mData.add(data);
    print('data seved');
    notifyListeners();
  }

  //update
  void updateData(Map<String, dynamic> updatedData, int index) {
    _mData[index] = updatedData;
    notifyListeners();
  }

  //delete
  void deleteData(int index) {
    _mData.removeAt(index);
    notifyListeners();
  }

  List<Map<String, dynamic>> getData() => _mData;
}
