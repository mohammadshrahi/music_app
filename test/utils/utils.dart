import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:music_app/core/utils.dart';
import 'package:music_app/generated/codegen_loader.g.dart';
import 'package:music_app/presentation/pages/home_page.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'utils.mocks.dart';

@GenerateMocks([HttpResponse])
class ResponseUtils<T> {
  HttpResponse<T> getSuccssResponse(T data) {
    HttpResponse<T> response = HttpResponse<T>(
        data,
        Response<dynamic>(
            requestOptions: RequestOptions(path: ''), statusCode: 200));

    return response;
  }

  HttpResponse<T> getFailedResponse(T data) {
    return MockHttpResponse();
  }
}

class LocalizedApp extends StatelessWidget {
  LocalizedApp(this.blocApp, {Key? key}) : super(key: key);
  Widget blocApp;
  @override
  Widget build(BuildContext context) {
    // return EasyLocalization(
    //     assetLoader: CodegenLoader(),
    //     path: './assets/translations/',
    //     fallbackLocale: AppConst.kSupportedLocals.first,
    //     supportedLocales: AppConst.kSupportedLocals,
    //     child: MyMaterialApp(blocApp));

    return EasyLocalization(
      path: './assets/translations/',
      useOnlyLangCode: true,
      assetLoader: CodegenLoader(),
      fallbackLocale: AppConst.kSupportedLocals.first,
      supportedLocales: AppConst.kSupportedLocals,
      saveLocale: false,
      child: MaterialApp(
        home: Scaffold(
          body: blocApp,
        ),
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  MyMaterialApp(this.home, {Key? key}) : super(key: key);
  Widget home;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: context.localizationDelegates,
      // locale: context.locale,
      // supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: home,
    );
  }
}
