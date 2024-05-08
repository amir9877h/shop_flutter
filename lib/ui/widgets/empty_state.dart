import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final Widget? callToAction;
  final Widget image;

  const EmptyView(
      {super.key,
      required this.message,
      this.callToAction,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              message,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (callToAction != null) callToAction!,
      ],
    );
  }
}
