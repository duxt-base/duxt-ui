import 'package:jaspr_test/jaspr_test.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:duxt_ui/src/components/form/file_upload.dart';
import 'package:duxt_ui/src/theme/colors.dart';

void main() {
  group('DFileUpload', () {
    group('rendering', () {
      testComponents('renders with default props', (tester) async {
        tester.pumpComponent(DFileUpload());

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with label', (tester) async {
        tester.pumpComponent(
          DFileUpload(label: 'Upload File'),
        );

        expect(find.text('Upload File'), findsOneComponent);
        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders with hint text', (tester) async {
        tester.pumpComponent(
          DFileUpload(
            label: 'Profile Picture',
            hint: 'Upload a square image',
          ),
        );

        expect(find.text('Profile Picture'), findsOneComponent);
        expect(find.text('Upload a square image'), findsOneComponent);
      });

      testComponents('renders with error message', (tester) async {
        tester.pumpComponent(
          DFileUpload(
            label: 'Document',
            error: 'File is too large',
          ),
        );

        expect(find.text('Document'), findsOneComponent);
        expect(find.text('File is too large'), findsOneComponent);
      });

      testComponents('renders required indicator', (tester) async {
        tester.pumpComponent(
          DFileUpload(label: 'Attachment', required: true),
        );

        expect(find.text('Attachment'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
      });

      testComponents('renders default dropzone text', (tester) async {
        tester.pumpComponent(DFileUpload());

        expect(find.text('Drop files here or '), findsOneComponent);
        expect(find.text('browse'), findsOneComponent);
      });

      testComponents('renders custom dropzone text', (tester) async {
        tester.pumpComponent(
          DFileUpload(
            dropzoneText: 'Drag and drop here or ',
            browseText: 'select files',
          ),
        );

        expect(find.text('Drag and drop here or '), findsOneComponent);
        expect(find.text('select files'), findsOneComponent);
      });

      testComponents('renders with custom icon', (tester) async {
        tester.pumpComponent(
          DFileUpload(
            icon: span([Component.text('icon')]),
          ),
        );

        expect(find.text('icon'), findsOneComponent);
      });
    });

    group('file constraints', () {
      testComponents('renders with accept attribute', (tester) async {
        tester.pumpComponent(
          DFileUpload(accept: 'image/*'),
        );

        expect(find.tag('input'), findsOneComponent);
        expect(find.text('Accepted: image/*'), findsOneComponent);
      });

      testComponents('renders with max size info', (tester) async {
        tester.pumpComponent(
          DFileUpload(maxSize: 5 * 1024 * 1024), // 5 MB
        );

        expect(find.tag('input'), findsOneComponent);
        expect(find.text('Max size: 5 MB'), findsOneComponent);
      });

      testComponents('renders with both accept and max size', (tester) async {
        tester.pumpComponent(
          DFileUpload(
            accept: '.pdf,.doc',
            maxSize: 10 * 1024 * 1024, // 10 MB
          ),
        );

        expect(find.text('Accepted: .pdf,.doc'), findsOneComponent);
        expect(find.text(' | '), findsOneComponent);
        expect(find.text('Max size: 10 MB'), findsOneComponent);
      });

      testComponents('renders with multiple file support', (tester) async {
        tester.pumpComponent(
          DFileUpload(multiple: true),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('sizes', () {
      testComponents('renders sm size', (tester) async {
        tester.pumpComponent(
          DFileUpload(size: DFileUploadSize.sm),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders md size (default)', (tester) async {
        tester.pumpComponent(
          DFileUpload(size: DFileUploadSize.md),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders lg size', (tester) async {
        tester.pumpComponent(
          DFileUpload(size: DFileUploadSize.lg),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders all sizes', (tester) async {
        for (final size in DFileUploadSize.values) {
          tester.pumpComponent(
            DFileUpload(size: size),
          );

          expect(find.tag('input'), findsOneComponent);
        }
      });
    });

    group('colors', () {
      testComponents('renders primary color (default)', (tester) async {
        tester.pumpComponent(
          DFileUpload(color: DColor.primary),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders secondary color', (tester) async {
        tester.pumpComponent(
          DFileUpload(color: DColor.secondary),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders success color', (tester) async {
        tester.pumpComponent(
          DFileUpload(color: DColor.success),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders warning color', (tester) async {
        tester.pumpComponent(
          DFileUpload(color: DColor.warning),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders error color', (tester) async {
        tester.pumpComponent(
          DFileUpload(color: DColor.error),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders neutral color', (tester) async {
        tester.pumpComponent(
          DFileUpload(color: DColor.neutral),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders all colors', (tester) async {
        for (final color in DColor.values) {
          tester.pumpComponent(
            DFileUpload(color: color),
          );

          expect(find.tag('input'), findsOneComponent);
        }
      });
    });

    group('states', () {
      testComponents('renders disabled state', (tester) async {
        tester.pumpComponent(
          DFileUpload(disabled: true),
        );

        expect(find.tag('input'), findsOneComponent);
      });

      testComponents('renders enabled state by default', (tester) async {
        tester.pumpComponent(
          DFileUpload(),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('error state styling', () {
      testComponents('shows error instead of hint when error present',
          (tester) async {
        tester.pumpComponent(
          DFileUpload(
            hint: 'Upload your document',
            error: 'File type not allowed',
          ),
        );

        expect(find.text('File type not allowed'), findsOneComponent);
        expect(find.text('Upload your document'), findsNothing);
      });

      testComponents('shows hint when no error', (tester) async {
        tester.pumpComponent(
          DFileUpload(
            hint: 'Supported formats: PDF, DOC',
          ),
        );

        expect(find.text('Supported formats: PDF, DOC'), findsOneComponent);
      });
    });

    group('form integration', () {
      testComponents('renders with name attribute', (tester) async {
        tester.pumpComponent(
          DFileUpload(name: 'document_upload'),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('interactions', () {
      testComponents('onChange callback can be set', (tester) async {
        List<DUploadedFile>? uploadedFiles;
        tester.pumpComponent(
          DFileUpload(
            onChange: (files) {
              uploadedFiles = files;
            },
          ),
        );

        expect(find.tag('input'), findsOneComponent);
      });
    });

    group('complete configurations', () {
      testComponents('renders with all props', (tester) async {
        tester.pumpComponent(
          DFileUpload(
            label: 'Resume Upload',
            name: 'resume',
            accept: '.pdf,.docx',
            multiple: false,
            disabled: false,
            required: true,
            size: DFileUploadSize.lg,
            color: DColor.primary,
            hint: 'PDF or DOCX only',
            maxSize: 5 * 1024 * 1024,
            maxFiles: 1,
            dropzoneText: 'Drop your resume here or ',
            browseText: 'choose file',
          ),
        );

        expect(find.tag('input'), findsOneComponent);
        expect(find.text('Resume Upload'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
        expect(find.text('Drop your resume here or '), findsOneComponent);
        expect(find.text('choose file'), findsOneComponent);
        expect(find.text('PDF or DOCX only'), findsOneComponent);
      });

      testComponents('renders with error state', (tester) async {
        tester.pumpComponent(
          DFileUpload(
            label: 'Photo',
            required: true,
            error: 'Please upload a photo',
          ),
        );

        expect(find.text('Photo'), findsOneComponent);
        expect(find.text('*'), findsOneComponent);
        expect(find.text('Please upload a photo'), findsOneComponent);
      });
    });
  });

  group('DUploadedFile', () {
    group('formattedSize', () {
      test('formats bytes correctly', () {
        final file = DUploadedFile(name: 'small.txt', size: 500, type: 'text/plain');
        expect(file.formattedSize, equals('500 B'));
      });

      test('formats kilobytes correctly', () {
        final file = DUploadedFile(name: 'medium.txt', size: 1536, type: 'text/plain');
        expect(file.formattedSize, equals('1.5 KB'));
      });

      test('formats megabytes correctly', () {
        final file = DUploadedFile(name: 'large.pdf', size: 2621440, type: 'application/pdf');
        expect(file.formattedSize, equals('2.5 MB'));
      });
    });
  });
}
