# DuxtUI - Nuxt UI Port Plan

## Overview
Porting 125+ Nuxt UI components to Jaspr/Dart with exact Tailwind CSS styling match.

## Design System

### Colors (Semantic)
- `primary` - Green (CTAs, brand)
- `secondary` - Blue (secondary actions)
- `success` - Green (positive states)
- `info` - Blue (informational)
- `warning` - Yellow (attention)
- `error` - Red (destructive)
- `neutral` - Slate (text, borders, backgrounds)

### CSS Variables
```css
:root {
  --color-primary-50: ...;
  --color-primary-950: ...;
  /* etc for all colors */
}
```

## Component Phases

### Phase 1: Theme System (Foundation)
- [ ] Theme provider component
- [ ] CSS variables file
- [ ] Color utilities
- [ ] Dark mode support

### Phase 2: Core Components (52 from theme/index.ts)
**Form Inputs:**
- [ ] Input (sizes: xs/sm/md/lg/xl, variants: outline/soft/subtle/ghost/none)
- [ ] Textarea
- [ ] Checkbox
- [ ] CheckboxGroup
- [ ] RadioGroup
- [ ] Select
- [ ] SelectMenu
- [ ] Switch
- [ ] Slider
- [ ] InputNumber
- [ ] InputTags
- [ ] InputMenu
- [ ] PinInput
- [ ] ColorPicker
- [ ] FileUpload
- [ ] Form
- [ ] FormField

**Buttons & Controls:**
- [ ] Button (variants: solid/outline/soft/subtle/ghost/link)
- [ ] ButtonGroup
- [ ] Kbd
- [ ] Link

**Data Display:**
- [ ] Badge (variants: solid/outline/soft/subtle)
- [ ] Avatar
- [ ] AvatarGroup
- [ ] Chip
- [ ] Table
- [ ] Pagination
- [ ] Progress
- [ ] Timeline
- [ ] Tree

**Layout:**
- [ ] Card (variants: solid/outline/soft/subtle)
- [ ] Container
- [ ] Separator

**Navigation:**
- [ ] Breadcrumb
- [ ] NavigationMenu
- [ ] Tabs

**Overlays:**
- [ ] Modal
- [ ] Drawer
- [ ] Slideover
- [ ] Popover
- [ ] Tooltip
- [ ] DropdownMenu
- [ ] ContextMenu

**Content:**
- [ ] Accordion
- [ ] Collapsible
- [ ] Alert
- [ ] Skeleton

**Feedback:**
- [ ] Toast
- [ ] Toaster

**Utility:**
- [ ] Calendar
- [ ] Carousel (CSS-only)
- [ ] CommandPalette (simplified)
- [ ] Stepper

### Phase 3: Extended Components
**Page Layout:**
- [ ] Page
- [ ] PageBody
- [ ] PageHeader
- [ ] PageHero
- [ ] PageSection
- [ ] PageAside
- [ ] PageAnchors
- [ ] PageLinks
- [ ] PageColumns
- [ ] PageGrid
- [ ] PageList
- [ ] PageCard
- [ ] PageFeature
- [ ] PageCTA
- [ ] PageLogos

**App Chrome:**
- [ ] Header
- [ ] Footer
- [ ] FooterColumns
- [ ] Main

**Dashboard:**
- [ ] DashboardGroup
- [ ] DashboardPanel
- [ ] DashboardResizeHandle
- [ ] DashboardNavbar
- [ ] DashboardSidebar
- [ ] DashboardSidebarToggle
- [ ] DashboardSidebarCollapse
- [ ] DashboardToolbar
- [ ] DashboardSearch
- [ ] DashboardSearchButton

**Blog/Content:**
- [ ] BlogPost
- [ ] BlogPosts
- [ ] ChangelogVersion
- [ ] ChangelogVersions
- [ ] ContentNavigation
- [ ] ContentToc
- [ ] ContentSurround
- [ ] ContentSearch
- [ ] ContentSearchButton

**Pricing:**
- [ ] PricingPlan
- [ ] PricingPlans
- [ ] PricingTable

**Chat:**
- [ ] ChatMessage
- [ ] ChatMessages
- [ ] ChatPrompt
- [ ] ChatPromptSubmit
- [ ] ChatPalette

**Editor (simplified):**
- [ ] Editor
- [ ] EditorToolbar

**User/Auth:**
- [ ] User
- [ ] AuthForm

**States:**
- [ ] Empty
- [ ] Error

**Theme:**
- [ ] ColorModeButton
- [ ] ColorModeSwitch
- [ ] ColorModeSelect
- [ ] ColorModeImage
- [ ] ColorModeAvatar

**Other:**
- [ ] Icon
- [ ] Marquee
- [ ] ScrollArea
- [ ] LocaleSelect
- [ ] App

## Styling Reference

### Button Classes
```
Base: rounded-md font-medium inline-flex items-center disabled:cursor-not-allowed disabled:opacity-75 transition-colors
Size xs: px-2 py-1 text-xs gap-1
Size sm: px-2.5 py-1.5 text-xs gap-1.5
Size md: px-2.5 py-1.5 text-sm gap-1.5
Size lg: px-3 py-2 text-sm gap-2
Size xl: px-3 py-2 text-base gap-2
```

### Input Classes
```
Base: w-full rounded-md border-0 appearance-none placeholder:text-dimmed focus:outline-none disabled:cursor-not-allowed disabled:opacity-75 transition-colors
Variant outline: text-highlighted bg-default ring ring-inset ring-accented
Variant soft: text-highlighted bg-elevated/50 hover:bg-elevated focus:bg-elevated
Variant subtle: text-highlighted bg-elevated ring ring-inset ring-accented
Variant ghost: text-highlighted bg-transparent hover:bg-elevated focus:bg-elevated
```

### Card Classes
```
Root: rounded-lg overflow-hidden
Header: p-4 sm:px-6
Body: p-4 sm:p-6
Footer: p-4 sm:px-6
Variant outline: bg-default ring ring-default divide-y divide-default
Variant soft: bg-elevated/50 divide-y divide-default
Variant subtle: bg-elevated/50 ring ring-default divide-y divide-default
Variant solid: bg-inverted text-inverted
```

### Badge Classes
```
Base: font-medium inline-flex items-center
Size xs: text-[8px]/3 px-1 py-0.5 gap-1 rounded-sm
Size sm: text-[10px]/3 px-1.5 py-1 gap-1 rounded-sm
Size md: text-xs px-2 py-1 gap-1 rounded-md
Size lg: text-sm px-2 py-1.5 gap-1.5 rounded-md
Size xl: text-base px-2.5 py-1.5 gap-1.5 rounded-md
```

## File Structure
```
lib/
├── duxt_ui.dart           # Main export
├── src/
│   ├── theme/
│   │   ├── provider.dart  # Theme provider
│   │   ├── colors.dart    # Color definitions
│   │   └── styles.css     # CSS variables
│   ├── components/
│   │   ├── form/
│   │   │   ├── input.dart
│   │   │   ├── textarea.dart
│   │   │   ├── checkbox.dart
│   │   │   └── ...
│   │   ├── data/
│   │   │   ├── badge.dart
│   │   │   ├── avatar.dart
│   │   │   ├── table.dart
│   │   │   └── ...
│   │   ├── layout/
│   │   │   ├── card.dart
│   │   │   ├── container.dart
│   │   │   └── ...
│   │   ├── navigation/
│   │   ├── overlay/
│   │   ├── content/
│   │   ├── feedback/
│   │   ├── page/
│   │   ├── dashboard/
│   │   └── ...
│   └── utils/
│       └── variants.dart  # Tailwind variant utilities
```

## Execution Strategy
1. Theme system first (colors, CSS variables, provider)
2. Spawn parallel agents for each component category
3. Each agent ports ~10-15 components
4. Continuous integration testing
5. Final review and publish
