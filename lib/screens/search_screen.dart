import 'package:auto_size_text/auto_size_text.dart';
import 'package:donev2/bloc/todo_bloc.dart';
import 'package:donev2/constants.dart';
import 'package:donev2/lists/extras/none_available.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../lists/category_list.dart';
import '../lists/task_list.dart';
import 'extras/custom_back_button.dart';
import 'extras/search_sheet.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
    required this.search,
  }) : super(key: key);

  static const tag = '/search';
  final String search;

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
        builder: (BuildContext context, data, Widget? child) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 12,
              right: 12,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomBackButton(),
                    IconButton(
                      tooltip: 'Search',
                      iconSize: kIconSize,
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: kRoundedBorder,
                          context: context,
                          builder: (context) => SearchSheet(
                            searchText: 'Search ${data.selected}',
                            screen: tag,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                        color: kTertiaryColor,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: AutoSizeText(
                    'Search results for \'${data.query}\'',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      letterSpacing: 1.2,
                    ),
                    maxLines: 2,
                  ),
                ),
                spacing(),
                data.categoryLength! > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              categoryAmount(data.categoryLength),
                              style: kText1,
                            ),
                          ),
                          spacing(),
                          SizedBox(
                            height: 110,
                            child: CategoryList(myQuery: search),
                          ),
                          spacing(),
                        ],
                      )
                    : const SizedBox.shrink(),
                data.taskLength! > 0
                    ? Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                taskAmount(data.taskLength),
                                style: kText1,
                              ),
                            ),
                            spacing(),
                            Expanded(
                              child: TaskList(myQuery: search),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    });
  }

  taskAmount(int? length) {
    String text = '';
    if (length! >= 1) {
      text = 'Tasks ($length)';
    } else {
      text = '';
    }
    return text;
  }

  categoryAmount(int? length) {
    String text = '';
    if (length! >= 1) {
      text = 'Categories ($length)';
    } else {
      text = '';
    }
    return text;
  }

  spacing({double height = 20}) => SizedBox(height: height);
}