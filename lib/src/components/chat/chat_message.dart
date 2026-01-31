import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../avatar.dart';

/// Role for chat messages
enum DChatMessageRole { user, assistant }

/// Chat message data model
class ChatMessageData {
  final String id;
  final String content;
  final String role;
  final DateTime timestamp;
  final bool isLoading;

  const ChatMessageData({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
    this.isLoading = false,
  });

  DChatMessageRole get roleEnum =>
      role == 'user' ? DChatMessageRole.user : DChatMessageRole.assistant;
}

/// DuxtUI ChatMessage component - displays a single chat message
class DChatMessage extends StatelessComponent {
  final ChatMessageData message;
  final DAvatar? avatar;
  final bool showAvatar;
  final bool showTimestamp;
  final String? userBgColor;
  final String? assistantBgColor;

  const DChatMessage({
    super.key,
    required this.message,
    this.avatar,
    this.showAvatar = true,
    this.showTimestamp = true,
    this.userBgColor,
    this.assistantBgColor,
  });

  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Component build(BuildContext context) {
    final isUser = message.roleEnum == DChatMessageRole.user;

    // Message bubble classes
    final bubbleClasses = isUser
        ? 'rounded-2xl rounded-br-sm px-4 py-2 max-w-[80%] ${userBgColor ?? "bg-cyan-600 text-white"}'
        : 'rounded-2xl rounded-bl-sm px-4 py-2 max-w-[80%] ${assistantBgColor ?? "bg-gray-100 dark:bg-zinc-800 text-gray-900 dark:text-gray-100"}';

    // Container alignment
    final containerClasses = isUser ? 'flex justify-end' : 'flex justify-start';

    // Loading dots animation
    final loadingContent = div(
      classes: 'flex gap-1 items-center py-1',
      [
        span(classes: 'w-2 h-2 bg-gray-400 rounded-full animate-bounce', []),
        span(
            classes:
                'w-2 h-2 bg-gray-400 rounded-full animate-bounce [animation-delay:0.1s]',
            []),
        span(
            classes:
                'w-2 h-2 bg-gray-400 rounded-full animate-bounce [animation-delay:0.2s]',
            []),
      ],
    );

    return div(
      classes: containerClasses,
      [
        div(
          classes: 'flex items-end gap-2 ${isUser ? "flex-row-reverse" : ""}',
          [
            // Avatar
            if (showAvatar)
              avatar ??
                  DAvatar(
                    size: DAvatarSize.sm,
                    text: isUser ? 'U' : 'A',
                  ),
            // Message bubble and timestamp
            div(
              classes: 'flex flex-col ${isUser ? "items-end" : "items-start"}',
              [
                // Message bubble
                div(
                  classes: bubbleClasses,
                  [
                    if (message.isLoading)
                      loadingContent
                    else
                      p(
                          classes: 'whitespace-pre-wrap break-words',
                          [Component.text(message.content)]),
                  ],
                ),
                // Timestamp
                if (showTimestamp && !message.isLoading)
                  span(
                    classes: 'text-xs text-gray-400 mt-1 px-1',
                    [Component.text(_formatTimestamp(message.timestamp))],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
