import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/features/auth/providers/auth_providers.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';

class PropertyFormatters {
  static String formatPrice(double price) {
    if (price >= 1000000) {
      return '₦${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '₦${(price / 1000).toStringAsFixed(0)}k';
    }
    return '₦${price.toStringAsFixed(0)}';
  }

  static String getBedroomLabel(int bedrooms) {
    if (bedrooms == 0) return 'Studio';
    if (bedrooms == 1) return '1 Bedroom';
    return '$bedrooms Bedrooms';
  }

  static String rentPeriodSuffix(RentPeriod period) {
    switch (period) {
      case RentPeriod.yearly:
        return '/yr';
      case RentPeriod.monthly:
        return '/mo';
      case RentPeriod.nightly:
        return '/night';
      case RentPeriod.weekly:
        return '/week';
    }
  }

  static String rentPeriodLabel(RentPeriod period) {
    switch (period) {
      case RentPeriod.yearly:
        return 'Per Year';
      case RentPeriod.monthly:
        return 'Per Month';
      case RentPeriod.nightly:
        return 'Per Night';
      case RentPeriod.weekly:
        return 'Per Week';
    }
  }


  static  String getInitials(WidgetRef ref) {
    final userAsyncValue = ref.watch(currentUserProvider);
      final user = userAsyncValue.value;
      if (user != null && user.name.isNotEmpty) {
        final names = user.name.trim().split(' ');
        if (names.length > 1) {
          return '${names[0][0]}${names[1][0]}'.toUpperCase();
        }
        return user.name.substring(0, 1).toUpperCase();
      }
      return 'GU';
    }
}
