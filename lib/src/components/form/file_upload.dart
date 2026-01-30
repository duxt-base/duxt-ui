import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../../theme/variants.dart';
import '../../theme/colors.dart';
import '../utility/icon.dart';

/// File upload sizes
enum DFileUploadSize { sm, md, lg }

/// Represents an uploaded file
class DUploadedFile {
  final String name;
  final int size;
  final String type;

  const DUploadedFile({
    required this.name,
    required this.size,
    required this.type,
  });

  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// DuxtUI FileUpload component - Drag and drop file upload area
class DFileUpload extends StatefulComponent {
  final String? label;
  final String? name;
  final String? accept;
  final bool multiple;
  final bool disabled;
  final bool required;
  final DFileUploadSize size;
  final DColor color;
  final String? hint;
  final String? error;
  final int? maxSize; // in bytes
  final int? maxFiles;
  final Component? icon;
  final String? dropzoneText;
  final String? browseText;
  final ValueChanged<List<DUploadedFile>>? onChange;

  const DFileUpload({
    super.key,
    this.label,
    this.name,
    this.accept,
    this.multiple = false,
    this.disabled = false,
    this.required = false,
    this.size = DFileUploadSize.md,
    this.color = DColor.primary,
    this.hint,
    this.error,
    this.maxSize,
    this.maxFiles,
    this.icon,
    this.dropzoneText,
    this.browseText,
    this.onChange,
  });

  @override
  State<DFileUpload> createState() => _UFileUploadState();
}

class _UFileUploadState extends State<DFileUpload> {
  bool _isDragOver = false;
  List<DUploadedFile> _files = [];

  String get _paddingClasses {
    switch (component.size) {
      case DFileUploadSize.sm:
        return 'p-4';
      case DFileUploadSize.md:
        return 'p-6';
      case DFileUploadSize.lg:
        return 'p-8';
    }
  }

  String get _textSizeClasses {
    switch (component.size) {
      case DFileUploadSize.sm:
        return 'text-sm';
      case DFileUploadSize.md:
        return 'text-base';
      case DFileUploadSize.lg:
        return 'text-lg';
    }
  }

  String get _iconSizeClasses {
    switch (component.size) {
      case DFileUploadSize.sm:
        return 'w-8 h-8';
      case DFileUploadSize.md:
        return 'w-10 h-10';
      case DFileUploadSize.lg:
        return 'w-12 h-12';
    }
  }

  DIconSize get _iconSize {
    switch (component.size) {
      case DFileUploadSize.sm:
        return DIconSize.lg;
      case DFileUploadSize.md:
        return DIconSize.xl;
      case DFileUploadSize.lg:
        return DIconSize.xl;
    }
  }

  String get _colorClasses {
    if (_isDragOver) {
      switch (component.color) {
        case DColor.primary:
          return 'border-cyan-500 bg-cyan-50 dark:bg-cyan-950';
        case DColor.secondary:
          return 'border-blue-500 bg-blue-50 dark:bg-blue-950';
        case DColor.success:
          return 'border-cyan-500 bg-cyan-50 dark:bg-cyan-950';
        case DColor.info:
          return 'border-blue-500 bg-blue-50 dark:bg-blue-950';
        case DColor.warning:
          return 'border-yellow-500 bg-yellow-50 dark:bg-yellow-950';
        case DColor.error:
          return 'border-red-500 bg-red-50 dark:bg-red-950';
        case DColor.neutral:
          return 'border-slate-500 bg-slate-50 dark:bg-slate-950';
      }
    }
    return 'border-gray-300 dark:border-gray-600';
  }

  String get _linkColorClasses {
    switch (component.color) {
      case DColor.primary:
        return 'text-cyan-600 hover:text-cyan-700 dark:text-cyan-400';
      case DColor.secondary:
        return 'text-blue-600 hover:text-blue-700 dark:text-blue-400';
      case DColor.success:
        return 'text-cyan-600 hover:text-cyan-700 dark:text-cyan-400';
      case DColor.info:
        return 'text-blue-600 hover:text-blue-700 dark:text-blue-400';
      case DColor.warning:
        return 'text-yellow-600 hover:text-yellow-700 dark:text-yellow-400';
      case DColor.error:
        return 'text-red-600 hover:text-red-700 dark:text-red-400';
      case DColor.neutral:
        return 'text-slate-600 hover:text-slate-700 dark:text-slate-400';
    }
  }

  void _handleDragOver(bool over) {
    if (component.disabled) return;
    setState(() => _isDragOver = over);
  }

  void _handleFiles(dynamic fileList) {
    if (component.disabled) return;

    final files = <DUploadedFile>[];
    final length = fileList.length as int;

    for (var i = 0; i < length; i++) {
      final file = fileList[i];
      final uploadedFile = DUploadedFile(
        name: file.name as String,
        size: file.size as int,
        type: file.type as String,
      );

      // Check max size
      if (component.maxSize != null && uploadedFile.size > component.maxSize!) {
        continue;
      }

      files.add(uploadedFile);

      // Check max files
      if (component.maxFiles != null && files.length >= component.maxFiles!) {
        break;
      }
    }

    setState(() => _files = files);
    component.onChange?.call(files);
  }

  void _removeFile(int index) {
    setState(() {
      _files = List.from(_files)..removeAt(index);
    });
    component.onChange?.call(_files);
  }

  @override
  Component build(BuildContext context) {
    final hasError = component.error != null && component.error!.isNotEmpty;
    final borderColor = hasError ? 'border-red-500' : _colorClasses;

    return div(classes: 'space-y-2', [
      if (component.label != null)
        span(
            classes:
                'block text-sm font-medium text-gray-700 dark:text-gray-200',
            [
              Component.text(component.label!),
              if (component.required)
                span(classes: 'text-red-500 ml-1', [Component.text('*')]),
            ]),
      // Dropzone
      div(
        classes: cx([
          'relative',
          'border-2',
          'border-dashed',
          borderColor,
          'rounded-lg',
          _paddingClasses,
          'text-center',
          'transition-colors',
          'duration-200',
          component.disabled
              ? 'opacity-50 cursor-not-allowed'
              : 'cursor-pointer',
        ]),
        events: {
          'dragover': (event) {
            event.preventDefault();
            _handleDragOver(true);
          },
          'dragleave': (event) {
            _handleDragOver(false);
          },
          'drop': (event) {
            event.preventDefault();
            _handleDragOver(false);
            final dataTransfer = (event as dynamic).dataTransfer;
            _handleFiles(dataTransfer.files);
          },
          'click': (_) {
            // Trigger file input click
            // This would need DOM access via querySelector
          },
        },
        [
          div(classes: 'flex flex-col items-center space-y-2', [
            // Icon
            if (component.icon != null)
              div(classes: '$_iconSizeClasses text-gray-400', [component.icon!])
            else
              div(classes: 'text-gray-400', [
                DIcon(
                  name: DIconNames.upload,
                  size: _iconSize,
                  color: 'text-gray-400',
                ),
              ]),
            // Text
            div(classes: _textSizeClasses, [
              span(classes: 'text-gray-600 dark:text-gray-400', [
                Component.text(component.dropzoneText ?? 'Drop files here or '),
              ]),
              span(classes: '$_linkColorClasses font-medium cursor-pointer', [
                Component.text(component.browseText ?? 'browse'),
              ]),
            ]),
            // Constraints hint
            if (component.accept != null || component.maxSize != null)
              p(classes: 'text-xs text-gray-500 dark:text-gray-400', [
                if (component.accept != null)
                  Component.text('Accepted: ${component.accept}'),
                if (component.accept != null && component.maxSize != null)
                  Component.text(' | '),
                if (component.maxSize != null)
                  Component.text(
                      'Max size: ${(component.maxSize! / (1024 * 1024)).toStringAsFixed(0)} MB'),
              ]),
          ]),
          // Hidden file input
          input(
            type: InputType.file,
            name: component.name,
            disabled: component.disabled,
            classes: 'absolute inset-0 w-full h-full opacity-0 cursor-pointer',
            attributes: {
              if (component.accept != null) 'accept': component.accept!,
              if (component.multiple) 'multiple': 'true',
            },
            events: {
              'change': (event) {
                final target = event.target as dynamic;
                _handleFiles(target.files);
              },
            },
          ),
        ],
      ),
      // File list
      if (_files.isNotEmpty)
        div(classes: 'space-y-2', [
          for (var i = 0; i < _files.length; i++)
            div(
              classes:
                  'flex items-center justify-between p-3 bg-gray-50 dark:bg-gray-800 rounded-lg',
              [
                div(classes: 'flex items-center space-x-3 min-w-0', [
                  // File icon
                  div(classes: 'flex-shrink-0 text-gray-400', [
                    RawText('''
                      <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                      </svg>
                    '''),
                  ]),
                  div(classes: 'min-w-0', [
                    p(
                        classes:
                            'text-sm font-medium text-gray-700 dark:text-gray-200 truncate',
                        [
                          Component.text(_files[i].name),
                        ]),
                    p(classes: 'text-xs text-gray-500 dark:text-gray-400', [
                      Component.text(_files[i].formattedSize),
                    ]),
                  ]),
                ]),
                // Remove button
                button(
                  type: ButtonType.button,
                  onClick: () => _removeFile(i),
                  classes:
                      'text-gray-400 hover:text-red-500 focus:outline-none',
                  [
                    RawText('''
                      <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                      </svg>
                    '''),
                  ],
                ),
              ],
            ),
        ]),
      if (hasError)
        p(
            classes: 'text-sm text-red-600 dark:text-red-400',
            [Component.text(component.error!)])
      else if (component.hint != null)
        p(
            classes: 'text-sm text-gray-500 dark:text-gray-400',
            [Component.text(component.hint!)]),
    ]);
  }
}
