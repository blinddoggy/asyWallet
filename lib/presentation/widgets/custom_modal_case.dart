import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomModalCase extends ConsumerWidget {
  const CustomModalCase({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final modalState = ref.watch(modalProvider2);

    if (modalState) {}

    return const SizedBox();
  }
}

final modalProvider2 = StateProvider<bool>((ref) => false);
