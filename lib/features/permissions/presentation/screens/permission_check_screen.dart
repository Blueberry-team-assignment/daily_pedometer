import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionCheckScreen extends ConsumerWidget {
  const PermissionCheckScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Text("퍼미션"),
      ),
    );
  }
}
