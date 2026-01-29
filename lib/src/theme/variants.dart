/// DuxtUI Variant Utilities - Matches Nuxt UI Tailwind Variants
library;

/// Common size variants used across components
enum USize { xs, sm, md, lg, xl }

/// Common visual variants
enum UVariant { solid, outline, soft, subtle, ghost, link, none }

/// Button-specific variants (subset of UVariant)
enum UButtonVariant { solid, outline, soft, subtle, ghost, link }

/// Input-specific variants
enum UInputVariant { outline, soft, subtle, ghost, none }

/// Card-specific variants
enum UCardVariant { solid, outline, soft, subtle }

/// Badge-specific variants
enum UBadgeVariant { solid, outline, soft, subtle }

/// Alert-specific variants
enum UAlertVariant { solid, outline, soft, subtle }

/// Size class mappings for different component types

/// Button size classes
const Map<USize, String> buttonSizeClasses = {
  USize.xs: 'px-2 py-1 text-xs gap-1',
  USize.sm: 'px-2.5 py-1.5 text-xs gap-1.5',
  USize.md: 'px-2.5 py-1.5 text-sm gap-1.5',
  USize.lg: 'px-3 py-2 text-sm gap-2',
  USize.xl: 'px-3 py-2 text-base gap-2',
};

/// Button icon size classes
const Map<USize, String> buttonIconSizeClasses = {
  USize.xs: 'size-4',
  USize.sm: 'size-4',
  USize.md: 'size-5',
  USize.lg: 'size-5',
  USize.xl: 'size-6',
};

/// Input size classes
const Map<USize, String> inputSizeClasses = {
  USize.xs: 'px-2 py-1 text-xs gap-1',
  USize.sm: 'px-2.5 py-1.5 text-xs gap-1.5',
  USize.md: 'px-2.5 py-1.5 text-sm gap-1.5',
  USize.lg: 'px-3 py-2 text-sm gap-2',
  USize.xl: 'px-3 py-2 text-base gap-2',
};

/// Badge size classes
const Map<USize, String> badgeSizeClasses = {
  USize.xs: 'text-[8px]/3 px-1 py-0.5 gap-1 rounded-sm',
  USize.sm: 'text-[10px]/3 px-1.5 py-1 gap-1 rounded-sm',
  USize.md: 'text-xs px-2 py-1 gap-1 rounded-md',
  USize.lg: 'text-sm px-2 py-1.5 gap-1.5 rounded-md',
  USize.xl: 'text-base px-2.5 py-1.5 gap-1.5 rounded-md',
};

/// Combine multiple class strings, filtering out empty strings
String cx(List<String?> classes) {
  return classes.where((c) => c != null && c.isNotEmpty).join(' ');
}
