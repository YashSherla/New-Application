import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';

class SearchBarWidget extends StatefulWidget {
  final VoidCallback onSearch;
  const SearchBarWidget({super.key, required this.onSearch});
  static TextEditingController searchcontroller =
      TextEditingController(text: " ");

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: SearchBarWidget.searchcontroller,
            hintText: "Search a Keyword or a Phrase",
          ),
        ),
        IconButton(
          onPressed: () {
            widget.onSearch();
          },
          icon: Icon(
            Icons.search,
            size: 30,
            shadows: [
              Shadow(color: AppColors.white, blurRadius: 5.0),
            ],
          ),
        )
      ],
    );
  }
}
