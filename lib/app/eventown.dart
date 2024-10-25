import 'package:eventown/core/theme/app_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/cubit/global_cubit.dart';
import '../core/cubit/global_state.dart';
import '../core/locale/localization_settings.dart';
import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart';

class Eventown extends StatelessWidget {
  const Eventown({super.key});

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
