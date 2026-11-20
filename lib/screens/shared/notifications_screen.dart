import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../widgets/widgets.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
    this.childFriendly = false,
    this.embedded = false,
  });

  static const route = '/notifications';

  final bool childFriendly;
  final bool embedded;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    if (!widget.embedded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.read<AppState>().markNotificationsRead();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<AppState>().notifications;
    final body = items.isEmpty
        ? Center(
            child: Text(
              widget.childFriendly ? 'Pas de nouvelles pour l’instant ✨' : 'Aucune notification pour le moment.',
              style: GoogleFonts.nunito(fontWeight: FontWeight.w700),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, i) => NotificationCard(item: items[i]),
          );

    if (widget.embedded) return body;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.childFriendly ? 'Mes infos' : 'Notifications'),
      ),
      body: body,
    );
  }
}
