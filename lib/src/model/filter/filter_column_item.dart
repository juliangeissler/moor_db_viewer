import 'package:moor_db_viewer/src/model/filter/filter_item.dart';
import 'package:moor_flutter/moor_flutter.dart';

class FilterColumnsItem extends FilterItem {
  final columns = Map<GeneratedColumn, bool>();

  @override
  String get name => 'Show columns';

  @override
  bool get canBeDismissed => false;

  bool isColumnShown(GeneratedColumn column) {
    if (!columns.containsKey(column)) {
      columns[column] = true;
    }
    return columns[column];
  }

  void setColumnShown(GeneratedColumn column, bool shown) {
    columns[column] = shown;
  }

  @override
  List<Map<String, dynamic>> applyFilter(List<Map<String, dynamic>> data) {
    columns.forEach((column, show) {
      if (!show) {
        data.forEach((item) => item.remove(column.$name));
      }
    });
    return data;
  }

  @override
  String toString() {
    final amountOfColumnsEnabled = columns.values.where((show) => show).length;
    return 'FilterColumnsItem: ($isEnabled), amountOfColumns: $amountOfColumnsEnabled';
  }
}