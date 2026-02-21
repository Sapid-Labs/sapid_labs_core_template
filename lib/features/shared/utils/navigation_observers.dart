import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// This observer will track route changes, providing analytics on user navigation patterns.
class NavigationObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _trackNavigation('page viewed', route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _trackNavigation('page viewed', previousRoute, route);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _trackNavigation('page viewed', newRoute, oldRoute);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (previousRoute != null) {
      _trackNavigation('page viewed', previousRoute, route);
    }
  }

  /// Track navigation events with route information
  void _trackNavigation(String eventName, Route route, Route? previousRoute) {
    try {
      final routeName = _getRouteName(route);
      final previousRouteName =
          previousRoute != null ? _getRouteName(previousRoute) : null;

      if (routeName.isNotEmpty) {
        // Create event properties with navigation context
        final eventProperties = <String, dynamic>{
          'page_name': routeName,
          'page_path': _getRoutePath(route),
        };

        // Add previous route context if available
        if (previousRouteName != null && previousRouteName.isNotEmpty) {
          eventProperties['previous_page'] = previousRouteName;
          eventProperties['previous_page_path'] = _getRoutePath(previousRoute!);
        }

        // Add route arguments if available
        final routeArgs = _getRouteArguments(route);
        if (routeArgs.isNotEmpty) {
          eventProperties.addAll(routeArgs);
        }

        if (kDebugMode) {
          print('Navigation: $eventName - $routeName');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error tracking navigation: $e');
      }
    }
  }

  /// Extract the route name from a Route object
  String _getRouteName(Route route) {
    if (route.settings.name != null) {
      // Remove the 'Route' suffix and convert to readable format
      return route.settings.name!.replaceAll('Route', '').trim().toLowerCase();
    }
    return '';
  }

  /// Extract the route path from a Route object
  String _getRoutePath(Route route) {
    if (route.settings.name != null) {
      return route.settings.name!;
    }
    return '';
  }

  /// Extract relevant route arguments for analytics
  Map<String, dynamic> _getRouteArguments(Route route) {
    final args = <String, dynamic>{};

    if (route.settings.arguments != null) {
      final arguments = route.settings.arguments;

      // Handle different types of route arguments based on the Auto Route patterns
      if (arguments is Map) {
        // Extract common useful properties for analytics
        for (final entry in arguments.entries) {
          final key = entry.key.toString();
          final value = entry.value;

          print('Extracted route argument: $key = $value');
        }
      }
    }

    return args;
  }
}
