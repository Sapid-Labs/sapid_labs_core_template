import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapid_labs_core/app/constants.dart';
import 'package:sapid_labs_core/app/services.dart';
import 'package:sapid_labs_core/features/settings/services/settings_service.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SignalsMixin {
  late final isLoading = createSignal<bool>(true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Theme Settings Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gap4,
                  Padding(
                    padding: paddingH8,
                    child: Text(
                      'Appearance',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  gap4,
                  ListTile(
                    leading: const Icon(Icons.palette_outlined),
                    title: const Text('Theme Mode'),
                    subtitle: Watch((context) {
                      final mode = settingsThemeMode.value;
                      return Text(mode.name.toUpperCase());
                    }),
                    trailing: Watch((context) {
                      return DropdownButton<ThemeMode>(
                        value: settingsThemeMode.value,
                        onChanged: (newMode) {
                          if (newMode != null) {
                            settingsService.setThemeMode(newMode);
                          }
                        },
                        items: ThemeMode.values.map((mode) {
                          return DropdownMenuItem(
                            value: mode,
                            child: Text(mode.name.toUpperCase()),
                          );
                        }).toList(),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          gap16,
        ],
      ),
    );
  }
}
