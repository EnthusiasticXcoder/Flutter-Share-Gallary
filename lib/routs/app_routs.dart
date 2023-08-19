import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/app.dart';
import 'package:gallary/pages/group/group.dart';
import 'package:gallary/pages/group/widgets/details.dart';
import 'package:gallary/pages/image/views/image_view.dart';
import 'package:gallary/pages/profile/views/profile_view.dart';
import 'package:gallary/services/auth/auth_Provider.dart';
import 'package:gallary/services/auth/bloc/auth_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

class AppRouts {
  static const homePage = '/';
  static const profileView = '/Profile';
  static const groupPage = '/Group';
  static const groupDetailsPage = '/Group/Details';
  static const viewImagePage = '/ImageView';

  Route? onGenerateRouts(RouteSettings settings) {
    switch (settings.name) {
      case AppRouts.homePage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthBloc(AuthProvider()),
            child: const HomePage(),
          ),
        );
      case AppRouts.profileView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: settings.arguments as AuthBloc,
            child: const ProfileScreen(),
          ),
        );
      case AppRouts.groupPage:
        return MaterialPageRoute(
          builder: (context) => const GroupView(),
        );
      case AppRouts.groupDetailsPage:
        return MaterialPageRoute(
          builder: (context) => const GroupDetails(),
        );
      case AppRouts.viewImagePage:
        return MaterialPageRoute(
          builder: (context) {
            final args = settings.arguments as Map;
            final image = args['Image'] as Medium;
            final index = args['Index'] as int;
            return DetailsPage(
              image: image,
              index: index,
            );
          },
        );
      default:
        return null;
    }
  }
}
