# DuxtUI

A comprehensive UI component library for [Jaspr](https://jaspr.dev) - the Dart web framework. DuxtUI provides 100+ pre-built, styled components inspired by Nuxt UI.

## Installation

```yaml
dependencies:
  duxt_ui: ^0.1.0
```

## Usage

```dart
import 'package:duxt_ui/duxt_ui.dart';

// Button
DButton(
  label: 'Click me',
  variant: DButtonVariant.solid,
  color: DButtonColor.primary,
  onClick: () => print('clicked'),
)

// Input
DInput(
  label: 'Email',
  placeholder: 'Enter email',
  type: InputType.email,
  error: 'Invalid email',
)

// Card
DCard(
  header: DCardHeader(title: 'Card Title'),
  children: [Component.text('Card content')],
)

// Alert
DAlert(
  title: 'Success',
  description: 'Your changes have been saved.',
  color: DAlertColor.success,
)

// Modal
DModal(
  open: isOpen,
  title: 'Confirm',
  onClose: () => setState(() => isOpen = false),
  children: [Component.text('Are you sure?')],
)
```

## Components

### Buttons & Inputs
| Component | Description |
|-----------|-------------|
| `DButton` | Button with variants, sizes, colors, loading states |
| `DInput` | Text input with validation, icons, hints |
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
| `DToast` | Toast notifications |
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
| `DPageHeader` | Page title section |
| `DPageHero` | Hero section |
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

### Blog
| Component | Description |
|-----------|-------------|
| `DBlogPosts` | Blog post grid |
| `DBlogPost` | Single blog post card |

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

### Content
| Component | Description |
|-----------|-------------|
| `DAccordion` | Expandable accordion |
| `DCollapsible` | Collapsible section |

### Utility
| Component | Description |
|-----------|-------------|
| `DIcon` | Icon component (Iconify) |
| `DCarousel` | Image/content carousel |
| `DMarquee` | Scrolling marquee |
| `DScrollArea` | Custom scrollbar area |
| `DStepper` | Step indicator |
| `DCalendar` | Date calendar |

### Theme
| Component | Description |
|-----------|-------------|
| `DThemeProvider` | Theme context provider |
| `DColorModeButton` | Dark/light mode toggle |
| `DColorModeSwitch` | Dark/light mode switch |
| `DColorModeSelect` | Dark/light mode select |
| `DApp` | App wrapper with theme |

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

## Variants & Colors

Most components support variants and colors:

**Variants:** `solid`, `outline`, `soft`, `subtle`, `ghost`, `link`

**Colors:** `primary`, `secondary`, `success`, `info`, `warning`, `error`, `neutral`

**Sizes:** `xs`, `sm`, `md`, `lg`, `xl`

## Requirements

- Jaspr ^0.22.1
- Tailwind CSS (via jaspr_tailwind)

## License

MIT License - see [LICENSE](LICENSE) for details.
