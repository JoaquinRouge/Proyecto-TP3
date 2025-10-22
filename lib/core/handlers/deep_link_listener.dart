import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_links/app_links.dart';

class DeepLinkListener extends StatefulWidget {
  final Widget child;

  const DeepLinkListener({super.key, required this.child});

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri?>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    //_handleInitialLink();
    _listenToLinks();
  }

  /*Future<void> _handleInitialLink() async {
    try {
      // ignore: undefined_method
      final initialUri = await _appLinks.getInitialAppLink(); // Método correcto según tu versión
      if (initialUri != null) _handleIncomingLink(initialUri);
    } catch (err) {
      debugPrint('Error al obtener link inicial: $err');
    }
  }*/

  void _listenToLinks() {
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        if (uri != null) _handleIncomingLink(uri);
      },
      onError: (err) {
        debugPrint('Error al recibir link: $err');
      },
    );
  }

  void _handleIncomingLink(Uri uri) {
    debugPrint('🔗 Link recibido: $uri');

    if (uri.path == '/game') {
      final id = uri.queryParameters['id'];
      if (id != null) _navigateTo('/home?id=$id');
    }
  }

void _navigateTo(String path) {
  void attemptNavigation() {
    if (!mounted) return;

    final router = GoRouter.maybeOf(context);
    if (router != null) {
      debugPrint('🔗 Navigating to: $path');
      router.go(path);
    } else {
      debugPrint('GoRouter aún no listo, reintentando en 100ms...');
      Future.delayed(const Duration(milliseconds: 100), attemptNavigation);
    }
  }

  WidgetsBinding.instance.addPostFrameCallback((_) => attemptNavigation());
}

  @override
  void dispose() {
    debugPrint('🔗 DeepLinkListener disposed, canceling link subscription.');
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
