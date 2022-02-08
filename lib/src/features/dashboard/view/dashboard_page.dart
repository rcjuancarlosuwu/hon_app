import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/dashboard/view/widgets/authors_sheet.dart';
import 'package:hon_app/src/features/dashboard/view/widgets/reommendation_sheet.dart';
import 'package:hon_app/src/features/search/views/search.dart';

import 'widgets/liked_works_list.dart';
import 'widgets/widgets.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: SeachBar(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Libros'),
                    ],
                  ),
                ),
                const LikedWorksList()
              ],
            ),
          ),
          const AuthorsSheet(),
          const RecommendationSheet()
        ],
      ),
    );
  }
}

class ScrollBar extends StatelessWidget {
  const ScrollBar({
    Key? key,
    this.color = Colors.grey,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    );
  }
}
