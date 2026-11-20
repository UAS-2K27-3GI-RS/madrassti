import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.conversationId, required this.viewer});

  static const route = '/chat';

  final String conversationId;
  final UserRole viewer;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  String? _warning;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppState>().markConversationRead(widget.conversationId, widget.viewer);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final state = context.read<AppState>();
    final senderId = widget.viewer == UserRole.parent ? MockData.parent.id : MockData.currentTeacher.id;
    final blocked = state.sendMessage(
      conversationId: widget.conversationId,
      text: _controller.text,
      senderRole: widget.viewer,
      senderId: senderId,
    );
    if (blocked != null) {
      setState(() => _warning = blocked);
      return;
    }
    setState(() => _warning = null);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final conversation = state.conversationById(widget.conversationId);
    final teacher = MockData.teacherById(conversation.teacherId);
    final parent = MockData.parentById(conversation.parentId);
    final title = widget.viewer == UserRole.parent ? teacher.fullName : parent.fullName;
    final subtitle = widget.viewer == UserRole.parent ? teacher.subject : 'Parent de ${conversation.childName}';
    final myId = widget.viewer == UserRole.parent ? MockData.parent.id : MockData.currentTeacher.id;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 18)),
            Text(subtitle, style: GoogleFonts.nunito(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              itemCount: conversation.messages.length,
              itemBuilder: (context, i) {
                final msg = conversation.messages[i];
                final mine = msg.senderId == myId;
                return Align(
                  alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
                    constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
                    decoration: BoxDecoration(
                      color: mine ? AppColors.navy : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: Radius.circular(mine ? 18 : 4),
                        bottomRight: Radius.circular(mine ? 4 : 18),
                      ),
                      border: mine ? null : Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          msg.text,
                          style: GoogleFonts.nunito(
                            color: mine ? Colors.white : AppColors.navy,
                            fontWeight: FontWeight.w600,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('HH:mm').format(msg.sentAt),
                          style: GoogleFonts.nunito(
                            fontSize: 11,
                            color: mine ? Colors.white70 : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_warning != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warningSoft,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.yellow),
              ),
              child: Row(
                children: [
                  const Icon(Icons.shield_rounded, color: AppColors.warning),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Message non envoyé : un mot n’est pas adapté (« $_warning »). Merci de le reformuler avec bienveillance.',
                      style: GoogleFonts.nunito(fontWeight: FontWeight.w700, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(hintText: 'Écrire un message…'),
                      onChanged: (_) {
                        if (_warning != null) setState(() => _warning = null);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppColors.yellow,
                    child: IconButton(
                      onPressed: _send,
                      icon: const Icon(Icons.send_rounded, color: AppColors.navy),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatArgs {
  const ChatArgs({required this.conversationId, required this.viewer});
  final String conversationId;
  final UserRole viewer;
}
