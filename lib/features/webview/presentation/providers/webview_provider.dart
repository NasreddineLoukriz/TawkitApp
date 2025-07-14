import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final maneUrl = Provider<WebUri>((ref) => WebUri(dotenv.env['MANE_URL']!));

final webviewcontrolerprovider =
    StateProvider<InAppWebViewController?>((ref) => null);

final inAppWebViewSettingsProvider = StateProvider<InAppWebViewSettings>((ref) {
  return InAppWebViewSettings(
    javaScriptEnabled: true,
    allowFileAccessFromFileURLs: true,
    allowUniversalAccessFromFileURLs: true,
  );
});

final pullToRefreshControllerprovider =
    Provider<PullToRefreshController?>((ref) {
  return PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (defaultTargetPlatform == TargetPlatform.android) {
          ref.watch(webviewcontrolerprovider)!.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          ref.watch(webviewcontrolerprovider)!.loadUrl(
                urlRequest: URLRequest(
                  url: await ref.refresh(webviewcontrolerprovider)!.getUrl(),
                ),
              );
        }
      });
});
