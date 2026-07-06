import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/app_strings.dart';
import 'core/di/injection_container.dart';
import 'core/router/app_router.dart';
import 'core/services/local_storage_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep the native splash up until the Flutter splash screen has rendered,
  // so there is no flash/overlap between the two.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await LocalStorageService.init(); // SharedPreferences
  await initializeDependencies(); // GetIt service locator

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // When you have app-wide blocs, wrap the tree below in a MultiBlocProvider:
    //   MultiBlocProvider(
    //     providers: [BlocProvider<FavoritesBloc>.value(value: sl<FavoritesBloc>())],
    //     child: ...,
    //   )
    // (MultiBlocProvider requires a non-empty providers list, so it's omitted
    // while there are no global blocs.)
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          // Sizer must wrap MaterialApp so .h/.w/.sp work everywhere.
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp.router(
                title: AppStrings.appName,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeProvider.themeMode,
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
