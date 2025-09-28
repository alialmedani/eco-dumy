import 'package:in_app_update/in_app_update.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


Future<String?> getLatestVersionFromAppStore() async {


  const String bundleId = 'jedarcenter.hadetha.hbh';
  const String url = 'https://itunes.apple.com/lookup?bundleId=$bundleId';

  try {
    final response = await http.get(Uri.parse(url));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['resultCount'] > 0) {
        String version = jsonData['results'][0]['version'];
        debugPrint('🔹 Latest version from App Store: $version');
        return version;
      } else {
        debugPrint('❌ No results found in JSON response');
      }
    } else {
      debugPrint('❌ Failed to fetch App Store data');
    }
  } catch (e) {
    debugPrint('❌ Error fetching version from App Store: $e');
  }
  return null;
}

Future<void> checkForIosUpdate(BuildContext context) async {
  String? latestVersion = await getLatestVersionFromAppStore();

  if (latestVersion == null) {
    debugPrint('Failed to fetch App Store version');
    return;
  }

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;

  if (isNewerVersion(latestVersion, currentVersion)) {
    // ignore: use_build_context_synchronously
    showUpdateDialog(context, latestVersion);
  }
}

bool isNewerVersion(String latestVersion, String currentVersion) {
  List<int> latest =
      latestVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  List<int> current =
      currentVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();

  while (latest.length < current.length) {
    latest.add(0);
  }
  while (current.length < latest.length) {
    current.add(0);
  }

  for (int i = 0; i < latest.length; i++) {
    if (latest[i] > current[i]) {
      debugPrint('🔹 يوجد إصدار أحدث');
      return true;
    }
    if (latest[i] < current[i]) {
      return false;
    }
  }
  debugPrint('✅ الإصدار محدث');
  return false;
}

void showUpdateDialog(BuildContext context, String latestVersion) {
  if (!context.mounted) return;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("🔄 تحديث متاح"),
        content: Text(
            "📢 يتوفر إصدار جديد ($latestVersion) من التطبيق. هل ترغب في التحديث الآن؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("❌ لاحقًا"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppStore();
            },
            child: const Text("✅ تحديث"),
          ),
        ],
      );
    },
  );
}

void openAppStore() async {
  const String appStoreUrl =
      "https://apps.apple.com/us/app/jedar-center/id1620311156";
  final Uri url = Uri.parse(appStoreUrl);

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    debugPrint("❌ Could not launch App Store URL");
  }
}

Future<void> checkForUpdate() async {
  try {
    AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      await InAppUpdate.performImmediateUpdate();
    } else {
      debugPrint("لا يوجد تحديث متاح");
    }
  } catch (e) {
    debugPrint("حدث خطأ أثناء فحص التحديث: $e");
  }
}
