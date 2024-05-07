import 'package:flutter/material.dart';
import 'package:shop_flutter/data/comment.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: themeData.dividerColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.title),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    comment.email,
                    style: themeData.textTheme.bodySmall,
                  ),
                ],
              ),
              Text(comment.date, style: themeData.textTheme.bodySmall),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            comment.content,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
