import 'package:flutter/material.dart';
import 'package:attendance/src/Dataset/attendance.dart';

class DataSearch extends SearchDelegate<Data> {
  final List<Data> dataList;

  DataSearch(this.dataList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context); // Changed from `null` to an empty list
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    List<Data> results = dataList.where((data) {
      return data.user.toLowerCase().contains(query.toLowerCase()) ||
          data.phone.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final data = results[index];

        return ListTile(
          title: Text(data.user),
          subtitle: Text(data.phone),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Data> suggestions = dataList.where((data) {
      return data.user.toLowerCase().contains(query.toLowerCase()) ||
          data.phone.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final data = suggestions[index];
        return ListTile(
          title: Text(data.user),
          subtitle: Text(data.phone),
        );
      },
    );
  }
}
