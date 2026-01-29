import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

/// DuxtUI ChatPrompt component - input textarea for chat messages
class UChatPrompt extends StatefulComponent {
  final String? placeholder;
  final String? value;
  final bool disabled;
  final bool autoFocus;
  final int minRows;
  final int maxRows;
  final ValueChanged<String>? onInput;
  final VoidCallback? onSubmit;
  final Component? leadingSlot;
  final Component? trailingSlot;

  const UChatPrompt({
    super.key,
    this.placeholder,
    this.value,
    this.disabled = false,
    this.autoFocus = false,
    this.minRows = 1,
    this.maxRows = 5,
    this.onInput,
    this.onSubmit,
    this.leadingSlot,
    this.trailingSlot,
  });

  @override
  State<UChatPrompt> createState() => _UChatPromptState();
}

class _UChatPromptState extends State<UChatPrompt> {
  String _value = '';

  @override
  void initState() {
    super.initState();
    _value = component.value ?? '';
  }

  @override
  void didUpdateComponent(UChatPrompt oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.value != null && component.value != _value) {
      _value = component.value!;
    }
  }

  void _handleInput(String newValue) {
    setState(() => _value = newValue);
    component.onInput?.call(newValue);
  }

  @override
  Component build(BuildContext context) {
    final isDisabled = component.disabled;

    return div(
      classes:
          'flex items-end gap-2 p-4 border-t border-gray-200 dark:border-gray-800 bg-white dark:bg-gray-900',
      [
        // Leading slot (e.g., attachment button)
        if (component.leadingSlot != null) component.leadingSlot!,

        // Textarea container
        div(
          classes: 'flex-1 relative',
          [
            textarea(
              onInput: _handleInput,
              classes:
                  'w-full resize-none rounded-lg border border-gray-300 dark:border-gray-600 p-3 pr-12 text-sm bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 placeholder-gray-400 dark:placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 disabled:opacity-50 disabled:cursor-not-allowed',
              attributes: {
                if (component.placeholder != null)
                  'placeholder': component.placeholder!,
                'rows': component.minRows.toString(),
                if (isDisabled) 'disabled': 'true',
                if (component.autoFocus) 'autofocus': 'true',
                // CSS for auto-grow would need JavaScript interop
                // Using min/max height as a fallback
              },
              styles: Styles(raw: {
                'min-height': '${component.minRows * 24 + 24}px',
                'max-height': '${component.maxRows * 24 + 24}px',
                'overflow-y': 'auto',
              }),
              [Component.text(_value)],
            ),
          ],
        ),

        // Trailing slot (e.g., submit button, emoji picker)
        if (component.trailingSlot != null) component.trailingSlot!,
      ],
    );
  }
}
