import 'package:flutter/material.dart';
import 'package:rxdart_practice/bloc/search_result.dart';
import 'package:rxdart_practice/models/animal.dart';
import 'package:rxdart_practice/models/person.dart';

class SearchResultView extends StatelessWidget {
  final Stream<SearchResult?> searchResult;
  const SearchResultView({Key? key, required this.searchResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchResult?>(
      stream: searchResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data;
          if (result is SearchResultHasError) {
            return const Text("Got error");
          } else if (result is SearchResultLoading) {
            return const CircularProgressIndicator();
          } else if (result is SearchResultNotResult) {
            return const Text("No result found for search term.");
          } else if (result is SearchResultWithResult) {
            // exciting part
            final results = result.results;

            return Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final item = results[index];
                  final String title;
                  if (item is Animal) {
                    title = "Animal";
                  } else if (item is Person) {
                    title = "Person";
                  } else {
                    title = "Unknown";
                  }

                  return ListTile(
                    title: Text(title),
                    subtitle: Text(
                      item.toString(),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text("Unknown state");
          }
        } else {
          return const Text("Waiting");
        }
      },
    );
  }
}