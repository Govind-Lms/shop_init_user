import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCondition extends StatelessWidget {
  const SkeletonCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          return Card(
            color: theme.primaryColor.withOpacity(.1),
            child: ListTile(
              title: Text('Item number $index as title'),
              subtitle: const Text('Subtitle here'),
              trailing: const Icon(Icons.ac_unit),
            ),
          );
        },
      ),
    );
  }
}
