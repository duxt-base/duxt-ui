import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'chat_message.dart';

/// DuxtUI ChatMessages component - displays a scrollable list of chat messages
class UChatMessages extends StatefulComponent {
  final List<ChatMessageData> messages;
  final bool autoScrollToBottom;
  final bool showAvatars;
  final bool showTimestamps;
  final Component? emptyState;
  final String? userBgColor;
  final String? assistantBgColor;

  const UChatMessages({
    super.key,
    required this.messages,
    this.autoScrollToBottom = true,
    this.showAvatars = true,
    this.showTimestamps = true,
    this.emptyState,
    this.userBgColor,
    this.assistantBgColor,
  });

  @override
  State<UChatMessages> createState() => _UChatMessagesState();
}

class _UChatMessagesState extends State<UChatMessages> {
  @override
  void didUpdateComponent(UChatMessages oldComponent) {
    super.didUpdateComponent(oldComponent);
    // Auto-scroll logic would be handled via JavaScript interop in a real implementation
    // The scroll behavior is managed via CSS scroll-snap and overflow-anchor
  }

  @override
  Component build(BuildContext context) {
    if (component.messages.isEmpty && component.emptyState != null) {
      return div(
        classes: 'flex-1 flex items-center justify-center p-4',
        [component.emptyState!],
      );
    }

    if (component.messages.isEmpty) {
      return div(
        classes:
            'flex-1 flex flex-col items-center justify-center p-4 text-gray-400',
        [
          // Empty chat icon
          div(
            classes:
                'w-16 h-16 mb-4 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center',
            [
              span(classes: 'text-2xl', [Component.text('💬')]),
            ],
          ),
          p(classes: 'text-sm', [Component.text('No messages yet')]),
          p(classes: 'text-xs mt-1', [Component.text('Start a conversation')]),
        ],
      );
    }

    return div(
      classes: 'flex flex-col gap-4 overflow-y-auto p-4 flex-1',
      styles: Styles(raw: {
        'scroll-behavior': 'smooth',
        'overflow-anchor': 'auto',
      }),
      id: 'chat-messages-container',
      [
        for (final message in component.messages)
          UChatMessage(
            key: ValueKey(message.id),
            message: message,
            showAvatar: component.showAvatars,
            showTimestamp: component.showTimestamps,
            userBgColor: component.userBgColor,
            assistantBgColor: component.assistantBgColor,
          ),
        // Scroll anchor element
        if (component.autoScrollToBottom)
          div(
            id: 'chat-scroll-anchor',
            styles: Styles(raw: {
              'overflow-anchor': 'auto',
              'height': '1px',
            }),
            [],
          ),
      ],
    );
  }
}
