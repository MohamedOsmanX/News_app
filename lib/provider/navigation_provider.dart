import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateProvider for the current tab index
final navigationProvider = StateProvider<int>((ref) {
  return 0; // Default to first tab (News)
});
