import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/providers/providers.dart';
import 'package:hon_app/src/features/dashboard/view/widgets/bottom_sheet.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(userProvider);

    return AppBar(
      foregroundColor: Colors.black,
      toolbarHeight: 80,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CachedNetworkImage(
          imageUrl: user.photoURL,
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 7),
                    blurRadius: 5,
                  ),
                ],
              ),
            );
          },
          placeholder: (_, __) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Buenos dias',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            user.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              builder: (_) => const MenuBottomSheet(),
            );
          },
          icon: const Icon(
            Icons.short_text_sharp,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
