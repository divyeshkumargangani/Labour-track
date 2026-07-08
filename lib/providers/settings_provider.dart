import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateProvider<String>((ref) => 'en');
final themeProvider = StateProvider<bool>((ref) => true); // true = dark, false = light
