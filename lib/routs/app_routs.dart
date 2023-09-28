import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallary/services/auth/auth.dart';
import 'package:gallary/services/auth/auth_service.dart';
import 'package:gallary/services/auth/profile/profile_bloc.dart';
import 'package:gallary/services/cloud/cloud.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../app.dart';
import '../pages/group/views/group_view.dart';
import '../pages/group/views/details.dart';
import '../pages/image/views/image_view.dart';
import '../pages/profile/views/profile_view.dart';

class AppRouts {
  static const homePage = '/';
  static const profileView = '/Profile';
  static const groupPage = '/Group';
  static const groupDetailsPage = '/Group/Details';
  static const viewImagePage = '/ImageView';

  final AuthService _service = AuthService.firebase();

  Route? onGenerateRouts(RouteSettings settings) {
    switch (settings.name) {
      case AppRouts.homePage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => AuthBloc(_service),
              child: const HomePage(),
            );
          },
        );
      case AppRouts.profileView:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    ProfileBloc(_service, FirebaseCloudStorage()),
              ),
              BlocProvider.value(
                value: settings.arguments as AuthBloc,
              ),
            ],
            child: const ProfileScreen(),
          ),
        );
      case AppRouts.groupPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                CloudBloc(FirebaseFirestoreProvider(), FirebaseCloudStorage()),
            child: GroupView(
              groupId: settings.arguments as String,
            ),
          ),
        );
      case AppRouts.groupDetailsPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                CloudBloc(FirebaseFirestoreProvider(), FirebaseCloudStorage()),
            child: GroupDetails(
              groupId: settings.arguments as String,
            ),
          ),
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
