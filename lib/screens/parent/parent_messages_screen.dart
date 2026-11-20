import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import '../shared/chat_screen.dart';

class ParentMessagesScreen extends StatelessWidget {
  const ParentMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = context.watch<AppState>().parentConversations();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Text(
          'Échanges avec les enseignants',
          style: GoogleFonts.nunito(fontSize: 16, color: AppColors.textSecondary, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ...conversations.map((c) {
          final teacher = MockData.teacherById(c.teacherId);
          final last = c.messages.last;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SoftCard(
              onTap: () => Navigator.pushNamed(
                context,
                ChatScreen.route,
                arguments: ChatArgs(conversationId: c.id, viewer: UserRole.parent),
              ),
              child: Row(
                children: [
                  EmojiAvatar(emoji: teacher.emoji),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(teacher.fullName, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 16)),
                        Text(teacher.subject, style: GoogleFonts.nunito(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(
                          last.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(DateFormat('HH:mm').format(last.sentAt), style: GoogleFonts.nunito(fontSize: 12, color: AppColors.textSecondary)),
                      if (c.unreadForParent > 0) ...[
                        const SizedBox(height: 6),
                        CircleAvatar(
                          radius: 11,
                          backgroundColor: AppColors.yellow,
                          child: Text('${c.unreadForParent}', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w900)),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
