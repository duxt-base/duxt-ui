<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/duxt-base/duxt/main/web/logo.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/duxt-base/duxt/main/web/logo.svg">
  <img alt="Duxt UI" src="https://raw.githubusercontent.com/duxt-base/duxt/main/web/logo.svg" width="180">
</picture>

# Duxt UI

[![Pub Version](https://img.shields.io/pub/v/duxt_ui?color=00C0E8&label=pub.dev)](https://pub.dev/packages/duxt_ui)
[![License: MIT](https://img.shields.io/badge/license-MIT-00C0E8.svg)](https://opensource.org/licenses/MIT)
[![Dart](https://img.shields.io/badge/Dart-3.0+-00C0E8.svg)](https://dart.dev)

**A comprehensive UI component library for [Jaspr](https://jaspr.dev)** — 100+ beautifully crafted, accessible components inspired by Nuxt UI.

---

## Highlights

<table>
<tr>
<td align="center" width="25%">

**Beautiful**

Carefully designed components with attention to detail

</td>
<td align="center" width="25%">

**Dark Mode**

Full dark mode support out of the box

</td>
<td align="center" width="25%">

**Tailwind**

Built with Tailwind CSS for easy customization

</td>
<td align="center" width="25%">

**Type Safe**

Full Dart type safety with enums & classes

</td>
</tr>
</table>

---

## Quick Start

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  duxt_ui: ^0.2.1
```

### Setup Tailwind

In your `tailwind.config.js`:

```js
module.exports = {
  content: [
    './lib/**/*.dart',
    './node_modules/duxt_ui/**/*.dart', // Include Duxt UI
  ],
  darkMode: 'class',
  theme: {
    extend: {},
  },
}
```

### Wrap Your App

```dart
import 'package:duxt_ui/duxt_ui.dart';

class App extends StatelessComponent {
  @override
  Component build(BuildContext context) => DApp(
    child: MyHomePage(),
  );
}
```

---

## Usage Examples

### Buttons

```dart
// Solid button (default)
DButton(
  label: 'Click me',
  onClick: () => print('Clicked!'),
)

// With variants
DButton(
  label: 'Outline',
  variant: DButtonVariant.outline,
  color: DButtonColor.primary,
)

// With icon
DButton(
  label: 'Download',
  leading: DIcon(icon: 'heroicons:arrow-down-tray'),
)

// Loading state
DButton(
  label: 'Submitting...',
  loading: true,
)

// Icon only
DButton(
  icon: DIcon(icon: 'heroicons:heart'),
  variant: DButtonVariant.ghost,
)
```

### Inputs

```dart
// Basic input
DInput(
  label: 'Email',
  placeholder: 'Enter your email',
  type: InputType.email,
)

// With validation error
DInput(
  label: 'Password',
  type: InputType.password,
  error: 'Password must be at least 8 characters',
)

// With icons
DInput(
  label: 'Search',
  placeholder: 'Search...',
  leading: DIcon(icon: 'heroicons:magnifying-glass'),
)
```

### Cards

```dart
DCard(
  header: DCardHeader(
    title: 'Card Title',
    description: 'Card description here',
  ),
  children: [
    p([text('Card content goes here.')]),
  ],
  footer: DCardFooter(
    children: [
      DButton(label: 'Cancel', variant: DButtonVariant.ghost),
      DButton(label: 'Save'),
    ],
  ),
)
```

### Alerts

```dart
DAlert(
  title: 'Success!',
  description: 'Your changes have been saved.',
  color: DAlertColor.success,
  icon: DIcon(icon: 'heroicons:check-circle'),
)
```

### Modals

```dart
DModal(
  open: isOpen,
  title: 'Confirm Action',
  description: 'Are you sure you want to continue?',
  onClose: () => setState(() => isOpen = false),
  children: [
    p([text('This action cannot be undone.')]),
  ],
  footer: [
    DButton(
      label: 'Cancel',
      variant: DButtonVariant.ghost,
      onClick: () => setState(() => isOpen = false),
    ),
    DButton(
      label: 'Confirm',
      color: DButtonColor.error,
      onClick: () => handleConfirm(),
    ),
  ],
)
```

### Forms

```dart
DForm(
  children: [
    DFormField(
      label: 'Full Name',
      required: true,
      children: [
        DInput(placeholder: 'John Doe'),
      ],
    ),
    DFormField(
      label: 'Email',
      required: true,
      hint: 'We\'ll never share your email',
      children: [
        DInput(type: InputType.email, placeholder: 'john@example.com'),
      ],
    ),
    DFormActions(
      children: [
        DButton(label: 'Submit', type: ButtonType.submit),
      ],
    ),
  ],
)
```

---

## Variants & Colors

### Variants

| Variant | Description |
|---------|-------------|
| `solid` | Filled background (default) |
| `outline` | Border only with hover fill |
| `soft` | Light background tint |
| `subtle` | Light background with border |
| `ghost` | Transparent with hover effect |
| `link` | Text-only link style |

### Colors

| Color | Value | Usage |
|-------|-------|-------|
| `primary` | Green | Primary actions |
| `secondary` | Blue | Secondary actions |
| `success` | Green | Success states |
| `info` | Blue | Informational |
| `warning` | Amber | Warnings |
| `error` | Red | Errors & destructive |
| `neutral` | Gray | Neutral actions |

### Sizes

| Size | Description |
|------|-------------|
| `xs` | Extra small |
| `sm` | Small |
| `md` | Medium (default) |
| `lg` | Large |
| `xl` | Extra large |

---

## Component Library

### Form Components

| Component | Description |
|-----------|-------------|
| `DButton` | Button with variants, sizes, colors, loading states |
| `DInput` | Text input with validation, icons, hints |
| `DTextarea` | Multi-line text input |
| `DInputNumber` | Numeric input with increment/decrement |
| `DSelect` | Dropdown select with search, multi-select |
| `DCheckbox` | Checkbox with indeterminate state |
| `DCheckboxGroup` | Group of checkboxes |
| `DRadioGroup` | Radio button group |
| `DSwitch` | Toggle switch |
| `DSlider` | Range slider |
| `DPinInput` | PIN/OTP input |
| `DFileUpload` | File upload with drag & drop |

### Data Display

| Component | Description |
|-----------|-------------|
| `DTable` | Data table with sorting, pagination |
| `DCard` | Card container with header, body, footer |
| `DBadge` | Status badge with variants |
| `DAvatar` | User avatar with fallback |
| `DAvatarGroup` | Stacked avatars |
| `DChip` | Removable chip/tag |
| `DTimeline` | Vertical timeline |
| `DTree` | Tree view with expand/collapse |
| `DPagination` | Page navigation |
| `DProgress` | Progress bar and circular progress |
| `DUser` | User card component |

### Feedback

| Component | Description |
|-----------|-------------|
| `DAlert` | Alert message with variants |
| `DToast` | Toast notification |
| `DToaster` | Toast container/provider |
| `DBanner` | Top banner announcements |
| `DSpinner` | Loading spinner |
| `DSkeleton` | Loading skeleton placeholders |
| `DEmpty` | Empty state display |
| `DError` | Error state display |

### Overlays

| Component | Description |
|-----------|-------------|
| `DModal` | Modal dialog |
| `DSlideover` | Slide-in panel |
| `DDrawer` | Side drawer |
| `DDropdown` | Dropdown menu |
| `DPopover` | Popover tooltip |
| `DTooltip` | Simple tooltip |
| `DContextMenu` | Right-click context menu |

### Navigation

| Component | Description |
|-----------|-------------|
| `DTabs` | Tab navigation |
| `DControlledTabs` | Controlled tab navigation |
| `DBreadcrumb` | Breadcrumb navigation |
| `DNavigationMenu` | Navigation menu |
| `DLink` | Styled link |
| `DKbd` | Keyboard shortcut display |

### Layout

| Component | Description |
|-----------|-------------|
| `DContainer` | Centered container |
| `DHeader` | Page header |
| `DFooter` | Page footer |
| `DMain` | Main content area |
| `DSeparator` | Horizontal/vertical divider |

### Page Components

| Component | Description |
|-----------|-------------|
| `DPage` | Page wrapper with aside |
| `DPageHero` | Hero section |
| `DPageHeader` | Page title section |
| `DPageSection` | Content section |
| `DPageBody` | Page body |
| `DPageAside` | Sidebar navigation |
| `DPageGrid` | Grid layout |
| `DPageColumns` | Column layout |
| `DPageCard` | Linked card |
| `DPageCTA` | Call-to-action section |

### Dashboard

| Component | Description |
|-----------|-------------|
| `DDashboard` | Dashboard layout |
| `DDashboardSidebar` | Dashboard sidebar |
| `DDashboardNavbar` | Dashboard top nav |
| `DDashboardPanel` | Dashboard panel |
| `DDashboardToolbar` | Dashboard toolbar |
| `DDashboardSearch` | Search component |
| `DDashboardGroup` | Group container |

### Blog & Content

| Component | Description |
|-----------|-------------|
| `DBlogPosts` | Blog post grid |
| `DBlogPost` | Single blog post card |
| `DAccordion` | Expandable accordion |
| `DCollapsible` | Collapsible section |

### Pricing

| Component | Description |
|-----------|-------------|
| `DPricingPlans` | Pricing plan cards |
| `DPricingPlan` | Single pricing plan |
| `DPricingTable` | Feature comparison table |

### Chat

| Component | Description |
|-----------|-------------|
| `DChatMessage` | Single chat message |
| `DChatMessages` | Chat message list |
| `DChatPrompt` | Chat input |
| `DChatPromptSubmit` | Submit button |
| `DChatPalette` | Command palette |

### Utility

| Component | Description |
|-----------|-------------|
| `DIcon` | Icon component (Iconify support) |
| `DCarousel` | Image/content carousel |
| `DMarquee` | Scrolling marquee |
| `DScrollArea` | Custom scrollbar area |
| `DStepper` | Step indicator |
| `DCalendar` | Date calendar |

### Theme

| Component | Description |
|-----------|-------------|
| `DApp` | App wrapper with theme |
| `DThemeProvider` | Theme context provider |
| `DColorModeButton` | Dark/light mode toggle |
| `DColorModeSwitch` | Dark/light mode switch |
| `DColorModeSelect` | Dark/light mode select |

### Forms

| Component | Description |
|-----------|-------------|
| `DForm` | Form container |
| `DFormField` | Form field wrapper |
| `DFormFieldGroup` | Grouped form fields |
| `DFormActions` | Form action buttons |
| `DFormRow` | Form row layout |
| `DFormSection` | Form section |
| `DValidators` | Built-in validators |

---

## Dark Mode

Duxt UI supports dark mode out of the box. Use the color mode components:

```dart
// Toggle button
DColorModeButton()

// Switch
DColorModeSwitch()

// Select dropdown
DColorModeSelect()
```

Or control it programmatically:

```dart
// In your component
DThemeProvider(
  initialMode: ThemeMode.system, // auto, light, dark
  child: MyApp(),
)
```

---

## Theming

### Custom Colors

```dart
DThemeProvider(
  config: DThemeConfig(
    primary: '#your-color',
    secondary: '#your-color',
  ),
  child: MyApp(),
)
```

---

## Requirements

- **Jaspr** ^0.22.1
- **Tailwind CSS** (via jaspr_tailwind)

---

## Documentation

Visit [duxt.dev](https://duxt.dev) for full documentation and interactive examples.

---

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) first.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

---

## License

MIT License - see [LICENSE](LICENSE) for details.

---

<p align="center">
  <sub>Built by the <a href="https://github.com/duxt-base">Base.al</a> team</sub>
</p>
