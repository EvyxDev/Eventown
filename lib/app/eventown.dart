import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:eventown/core/theme/app_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/cubit/global_cubit.dart';
import '../core/cubit/global_state.dart';
import '../core/locale/localization_settings.dart';
import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart';

class Eventown extends StatefulWidget {
  const Eventown({super.key});

  @override
  State<Eventown> createState() => _EventownState();
}

class _EventownState extends State<Eventown> {
  late final AppLinks _appLinks;
  StreamSubscription<Uri?>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinkListener();
  }

  void _initDeepLinkListener() async {
    // Get the initial deep link if there is one
    final Uri? initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    }

    // Listen for subsequent deep links while the app is running
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      uri.toString(),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              builder: (context, child) {
                final mediaQueryData = MediaQuery.of(context);
                final scale = mediaQueryData.textScaler
                    .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.0);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: scale),
                  child: child!,
                );
              },
              debugShowCheckedModeBanner: false,
              //!Localization Settings
              localizationsDelegates: localizationsDelegatesList,
              supportedLocales: supportedLocalesList,
              locale: Locale(context.read<GlobalCubit>().language),
              //!App Scroll Behavior
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                physics: const BouncingScrollPhysics(),
              ),
              //!Routing
              onGenerateRoute: AppRoutes.generateRoute,
              initialRoute: Routes.initialRoute,
              theme: getAppTheme(),
              darkTheme: getAppDarkTheme(),
              themeMode: ThemeMode.dark,
            );
          },
        );
      },
    );
  }
}
