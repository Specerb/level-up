import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz_lib;
import 'constants/theme.dart';
import 'providers.dart';
import 'screens/onboarding/name_screen.dart';
import 'screens/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Timezone must be initialized before notification service
  tz.initializeTimeZones();
  final timeZoneName =
      await FlutterLocalNotificationsPlugin.getLocalTimezone();
  try {
    tz_lib.setLocalLocation(tz_lib.getLocation(timeZoneName));
  } catch (_) {
    tz_lib.setLocalLocation(tz_lib.UTC);
  }

  runApp(
    const ProviderScope(
      child: LevelUpApp(),
    ),
  );
}

class LevelUpApp extends ConsumerWidget {
  const LevelUpApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);

    return MaterialApp(
      title: 'Level Up',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: player.onboardingComplete ? const MainShell() : const NameScreen(),
    );
  }
}
