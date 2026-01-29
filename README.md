# DuxtUI

A component library for [Jaspr](https://jaspr.dev) with pre-built, Tailwind-styled UI components.

## Installation

```yaml
dependencies:
  duxt_ui:
    path: ../duxt_ui  # or from pub.dev when published
```

## Components

| Component | Description |
|-----------|-------------|
| `UButton` | Button with variants (solid, outline, ghost, soft, link) |
| `UInput` | Text input with label, hint, error states |
| `UTextarea` | Multi-line text input |
| `UCard` | Card container with header/footer |
| `UBadge` | Status badges |
| `UAlert` | Alert messages (info, success, warning, error) |
| `UModal` | Modal dialogs |
| `UDropdown` | Dropdown menus |
| `UTabs` | Tab navigation |
| `UTable` | Data tables |
| `UAvatar` | User avatars with initials fallback |
| `USpinner` | Loading spinners |

## Usage

```dart
import 'package:duxt_ui/duxt_ui.dart';

// Button
UButton(
  label: 'Click me',
  variant: UButtonVariant.solid,
  color: UButtonColor.primary,
  onClick: () => print('clicked'),
)

// Input
UInput(
  label: 'Email',
  placeholder: 'Enter email',
  type: InputType.email,
  error: 'Invalid email',
)

// Card
UCard(
  header: UCardHeader(title: 'Card Title'),
  children: [Component.text('Card content')],
)

// Badge
UBadge(label: 'Active', color: UBadgeColor.success)

// Alert
UAlert(
  title: 'Success',
  description: 'Your changes have been saved.',
  color: UAlertColor.success,
)

// Modal
UModal(
  open: isOpen,
  title: 'Confirm',
  onClose: () => setState(() => isOpen = false),
  children: [Component.text('Are you sure?')],
)

// Table
UTable<Map>(
  columns: [
    UTableColumn(key: 'name', label: 'Name'),
    UTableColumn(key: 'email', label: 'Email'),
  ],
  data: users,
)

// Spinner
USpinner(size: USpinnerSize.md)
```

## Requirements

- Jaspr ^0.22.1
- Tailwind CSS (via jaspr_tailwind)

## License

MIT
