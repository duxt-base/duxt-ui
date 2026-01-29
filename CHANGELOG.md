# Changelog

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
- 100+ UI components ported from Nuxt UI to Jaspr/Dart
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
