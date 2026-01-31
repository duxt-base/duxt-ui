/// DuxtUI Variant Utilities
library;

/// Common size variants used across components
enum DSize { xs, sm, md, lg, xl }

/// Common visual variants
enum DVariant { solid, outline, soft, subtle, ghost, link, none }

/// Button-specific variants (subset of DVariant)
enum DButtonVariant { solid, outline, soft, subtle, ghost, link }

/// Input-specific variants
enum DInputVariant { outline, soft, subtle, ghost, none }

/// Card-specific variants
enum DCardVariant { solid, outline, soft, subtle }

/// Badge-specific variants
enum DBadgeVariant { solid, outline, soft, subtle }

/// Alert-specific variants
enum DAlertVariant { solid, outline, soft, subtle }

/// Size class mappings for different component types

/// Button size classes
const Map<DSize, String> buttonSizeClasses = {
  DSize.xs: 'px-2 py-1 text-xs gap-1',
  DSize.sm: 'px-2.5 py-1.5 text-xs gap-1.5',
  DSize.md: 'px-2.5 py-1.5 text-sm gap-1.5',
  DSize.lg: 'px-3 py-2 text-sm gap-2',
  DSize.xl: 'px-3 py-2 text-base gap-2',
};

/// Button icon size classes
const Map<DSize, String> buttonIconSizeClasses = {
  DSize.xs: 'size-4',
  DSize.sm: 'size-4',
  DSize.md: 'size-5',
  DSize.lg: 'size-5',
  DSize.xl: 'size-6',
};

/// Input size classes
const Map<DSize, String> inputSizeClasses = {
  DSize.xs: 'px-2 py-1 text-xs gap-1',
  DSize.sm: 'px-2.5 py-1.5 text-xs gap-1.5',
  DSize.md: 'px-2.5 py-1.5 text-sm gap-1.5',
  DSize.lg: 'px-3 py-2 text-sm gap-2',
  DSize.xl: 'px-3 py-2 text-base gap-2',
};

/// Badge size classes
const Map<DSize, String> badgeSizeClasses = {
  DSize.xs: 'text-[8px]/3 px-1 py-0.5 gap-1 rounded-sm',
  DSize.sm: 'text-[10px]/3 px-1.5 py-1 gap-1 rounded-sm',
  DSize.md: 'text-xs px-2 py-1 gap-1 rounded-md',
  DSize.lg: 'text-sm px-2 py-1.5 gap-1.5 rounded-md',
  DSize.xl: 'text-base px-2.5 py-1.5 gap-1.5 rounded-md',
};

/// Combine multiple class strings, filtering out empty strings
String cx(List<String?> classes) {
  return classes.where((c) => c != null && c.isNotEmpty).join(' ');
}
