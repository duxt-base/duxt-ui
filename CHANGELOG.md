# Changelog

## 0.3.0

**BREAKING CHANGE:** Interactive components now work without `@client` annotation.

### Breaking Changes
- `DModal`, `DSlideover`, `DDrawer` now require `trigger` prop instead of `open`
- Use `DModalControlled`, `DSlideoverControlled`, `DDrawerControlled` for state-controlled usage with `@client`
- `DCalendar` now uses `String` dates (YYYY-MM-DD format) instead of `DateTime`
- Removed `onClick` from `DDropdownItem` - use `href` for links
- Removed `onChange`/`onComplete` from `DPinInput` - use form submission

### New Features
- Native HTML `<dialog>` element for Modal, Slideover, and Drawer
  - Built-in focus trapping
  - Native Escape key handling
  - Backdrop with `::backdrop` pseudo-element
  - Smooth slide animations with CSS `@starting-style`
- All interactive components work without `@client`:
  - `DDropdown` - uses `<details>/<summary>` + JS
  - `DPopover` - uses `<details>/<summary>` + JS
  - `DCollapsible` - uses native `<details>/<summary>`
  - `DAccordion` - uses native `<details>` with `name` attribute
  - `DCarousel` - uses inline JS
  - `DCalendar` - uses inline JS with form integration
  - `DPinInput` - auto-advance to next input on digit entry
  - `DInputNumber` - increment/decrement buttons

### Improvements
- Better dark mode support across all components
- Reduced JavaScript complexity with native HTML elements
- Improved accessibility with semantic HTML

## 0.2.4

- Add example file for pub.dev
- Update lints to 6.1.0

## 0.2.3

- Switch to Lucide icons as default icon set
- DIcon component now uses Iconify for icon rendering
- Refactor Select and FileUpload components to use DIcon instead of inline SVG
- Fix pagination crash when totalPages is 1 or 2
- Fix minLength validator to allow empty values
- Update theme colors from green to cyan for primary

## 0.2.2

- Fix footer link to duxt.dev
- Bug fixes and improvements

## 0.2.1

- Revamp README with comprehensive documentation and examples
- Add usage examples for buttons, inputs, cards, alerts, modals, forms
- Add variants, colors, and sizes reference tables
- Add dark mode and theming documentation

## 0.2.0

**BREAKING CHANGE:** All components renamed from `U` prefix to `D` prefix.

- `UButton` → `DButton`
- `UInput` → `DInput`
- `UCard` → `DCard`
- `UAlert` → `DAlert`
- etc.

This change provides better branding consistency with DuxtUI.

## 0.1.0

- Initial release
- 100+ UI components for Jaspr/Dart
- Components include:
  - **Buttons**: DButton with variants, sizes, colors, loading states
  - **Inputs**: DInput, DSelect, DCheckbox, DRadio, DSwitch, DSlider, DPinInput, DFileUpload
  - **Data Display**: DTable, DCard, DBadge, DAvatar, DChip, DTimeline, DTree, DPagination
  - **Feedback**: DAlert, DToast, DBanner, DProgress, DSpinner
  - **Overlays**: DModal, DSlideover, DDropdown, DPopover, DTooltip, DContextMenu
  - **Navigation**: DTabs, DBreadcrumb, DNavigationMenu, DLink, DKbd
  - **Layout**: DContainer, DHeader, DFooter, DMain, DSeparator
  - **Page**: DPage, DPageHeader, DPageHero, DPageSection, DPageCard, DPageCTA
  - **Dashboard**: DDashboard, DDashboardSidebar, DDashboardNavbar, DDashboardPanel
  - **Blog**: DBlogPosts, DBlogPost
  - **Pricing**: DPricingPlans, DPricingPlan, DPricingTable
  - **Chat**: DChatMessage, DChatMessages, DChatPrompt, DChatPalette
  - **Content**: DAccordion, DCollapsible, DSkeleton, DEmpty, DError
  - **Utility**: DIcon, DCarousel, DMarquee, DScrollArea, DStepper, DCalendar
- Theme system with color modes and variants
- Full test suite with 520 passing tests
- Zero errors, zero warnings in dart analyze
