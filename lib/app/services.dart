import 'package:sapid_labs_core/app/get_it.dart';
import 'package:sapid_labs_core/app/router.dart';
import 'package:sapid_labs_core/features/settings/services/settings_service.dart';
import 'package:sapid_labs_core/features/shared/services/ai_service.dart';
import 'package:sapid_labs_core/features/shared/services/permission_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

AIService get aiService => getIt.get<AIService>();
AppRouter get router => getIt.get<AppRouter>();
SharedPreferences get sharedPrefs => getIt.get<SharedPreferences>();
SettingsService get settingsService => getIt.get<SettingsService>();

PermissionService get permissionService => getIt.get<PermissionService>();
