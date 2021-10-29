import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pengo/ui/explore/cubit/filter_cubit.dart';
import 'package:pengo/extensions/string_extension.dart';

class SearchRow extends StatefulWidget {
  const SearchRow({
    Key? key,
    required this.onTextFieldChanged,
    required this.type,
    this.defaultText,
  }) : super(key: key);

  final ValueSetter<String> onTextFieldChanged;
  final String? defaultText;
  final ExploreListFilter type;

  @override
  State<SearchRow> createState() => _SearchRowState();
}

class _SearchRowState extends State<SearchRow> {
  late TextEditingController _searchController;

  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController(text: widget.defaultText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Search ${widget.type.toString().split('.').last} ...",
            border: const UnderlineInputBorder(
              borderSide: BorderSide(width: 4),
            ),
          ),
          controller: _searchController,
          onChanged: (String q) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              widget.onTextFieldChanged(q);
            });
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
    _debounce?.cancel();
  }
}
