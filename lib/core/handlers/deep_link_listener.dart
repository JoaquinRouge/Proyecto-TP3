import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_links/app_links.dart';

//handleo de deep links externos (con firebase hosting)

class DeepLinkListener extends StatefulWidget {
  final Widget child;

  const DeepLinkListener({super.key, required this.child});

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _listenToLinks();
  }

  void _listenToLinks() {
    // Escuchar todos los enlaces entrantes
    _appLinks.uriLinkStream.listen((uri) {
      if (uri != null) _handleIncomingLink(uri);
    }, onError: (err) {
      debugPrint('Error al recibir link: $err');
    });
  }

  void _handleIncomingLink(Uri uri) {
    debugPrint('🔗 Link recibido: $uri');

    // Ejemplo: https://gameshelf.web.app/game?id=42
    if (uri.path == '/game') {
      final id = uri.queryParameters['id'];
      if (id != null) {
        // Navegar con GoRouter
        context.go('/home?id=$id');
      }
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}