import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/views/login_view.dart';


enum AppRoutes {
  login('/login'),
  

  
  submitRequest('/submit');

  const AppRoutes(this.path);

  final String path;
}

Page errorPage(BuildContext context, GoRouterState state) {
  return CupertinoPage<Widget>(
    child: const Scaffold(),
    key: state.pageKey,
  );
}

class AppRouter {
  AppRouter(this.ref);

  final Ref ref;

  GoRouter get router {
    return GoRouter(
      initialLocation: AppRoutes.login.path,
      errorPageBuilder: errorPage,
      debugLogDiagnostics: true,
      routes: [
      
        
    
        GoRoute(
          path: AppRoutes.login.path,
          name: AppRoutes.login.path,
          pageBuilder: (context, state) => CupertinoPage<LoginView>(
            child: const LoginView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
        GoRoute(
          path: AppRoutes.submitRequest.path,
          name: AppRoutes.submitRequest.name,
          pageBuilder: (context, state) => CupertinoPage<LoginView>(
            child: const LoginView(),
            key: state.pageKey,
            restorationId: state.pageKey.value,
          ),
        ),
      ]
    );
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter(ref).router;
});
