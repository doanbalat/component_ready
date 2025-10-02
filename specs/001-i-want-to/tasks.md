# Tasks: ComponentReady Ruby Gem - Modern Web Component Library

**Input**: Design documents from `/specs/001-i-want-to/`
**Prerequisites**: plan.md (required), research.md, data-model.md, contracts/

## Execution Flow (main)
```
1. Load plan.md from feature directory ✓
   → Tech stack: Ruby 3.0+, Rails Engine, Tailwind CSS, RSpec
   → Structure: Ruby gem library with 6 components
2. Load design documents ✓:
   → data-model.md: 6 component entities + Base class
   → contracts/: Component API interfaces and Rails helper
   → research.md: Rails Engine pattern, ERB templates
3. Generate tasks by category ✓:
   → Setup: gem structure, engine, dependencies  
   → Tests: RSpec component tests, integration tests
   → Core: Base class, 6 component classes, templates
   → Integration: Rails helper, demo app, system tests
   → Polish: documentation, performance validation
4. Task rules applied ✓:
   → Component classes = [P] (different files)
   → Templates = [P] (different files)  
   → Tests before implementation (TDD)
5. Tasks numbered T001-T038 ✓
6. Dependencies mapped ✓
7. Parallel execution examples provided ✓
```

## Format: `[ID] [P?] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- Include exact file paths in descriptions

## Path Conventions
- **Ruby gem structure**: `lib/component_ready/` for source, `spec/` for tests
- **Templates**: `lib/component_ready/templates/[component]/`
- **Demo app**: `demo_app/` for Rails integration testing

## Phase 3.1: Setup & Infrastructure
- [x] T001 Create Ruby gem structure with gemspec in `component_ready.gemspec`
- [x] T002 Initialize lib/component_ready.rb with gem requires and version
- [x] T003 [P] Configure RSpec in spec/spec_helper.rb and spec/rails_helper.rb
- [x] T004 Create Rails Engine in lib/component_ready/engine.rb
- [x] T005 Create base component class in lib/component_ready/base.rb
- [x] T006 Create Rails helper module in lib/component_ready/helpers/component_helper.rb
- [x] T007 [P] Configure Bundler and development dependencies in Gemfile
- [x] T008 [P] Set up linting with RuboCop in .rubocop.yml

## Phase 3.2: Tests First (TDD) ⚠️ MUST COMPLETE BEFORE 3.3
**CRITICAL: These tests MUST be written and MUST FAIL before ANY implementation**

### Component Class Tests
- [x] T009 [P] Base component test in spec/component_ready/base_spec.rb
- [x] T010 [P] Button component test in spec/component_ready/components/button_spec.rb  
- [x] T011 [P] Slider component test in spec/component_ready/components/slider_spec.rb
- [ ] T012 [P] Footer component test in spec/component_ready/components/footer_spec.rb
- [ ] T013 [P] Pricing component test in spec/component_ready/components/pricing_spec.rb
- [ ] T014 [P] Login component test in spec/component_ready/components/login_spec.rb
- [ ] T015 [P] Banner component test in spec/component_ready/components/banner_spec.rb

### Helper Integration Tests
- [x] T016 [P] Component helper test in spec/component_ready/helpers/component_helper_spec.rb
- [ ] T017 [P] Rails integration test in spec/integration/rails_integration_spec.rb

### Contract Validation Tests  
- [ ] T018 [P] Component API contract test in spec/contracts/component_api_spec.rb
- [ ] T019 [P] Template rendering test in spec/contracts/template_rendering_spec.rb

## Phase 3.3: Core Implementation (ONLY after tests are failing)

### Base Infrastructure
- [ ] T020 Implement Base component class with validation and rendering in lib/component_ready/base.rb
- [ ] T021 Implement Rails helper integration in lib/component_ready/helpers/component_helper.rb
- [ ] T022 Configure Engine for automatic helper inclusion in lib/component_ready/engine.rb

### Component Classes (Parallel Implementation)
- [x] T023 [P] Button component class in lib/component_ready/components/button.rb
- [x] T024 [P] Slider component class in lib/component_ready/components/slider.rb  
- [ ] T025 [P] Footer component class in lib/component_ready/components/footer.rb
- [ ] T026 [P] Pricing component class in lib/component_ready/components/pricing.rb
- [ ] T027 [P] Login component class in lib/component_ready/components/login.rb
- [x] T028 [P] Banner component class in lib/component_ready/components/banner.rb

### Template Implementation (Parallel)
- [ ] T029 [P] Button ERB templates in lib/component_ready/templates/button/_default.html.erb + variants
- [ ] T030 [P] Slider ERB templates in lib/component_ready/templates/slider/_default.html.erb + variants
- [ ] T031 [P] Footer ERB templates in lib/component_ready/templates/footer/_default.html.erb + variants
- [ ] T032 [P] Pricing ERB templates in lib/component_ready/templates/pricing/_default.html.erb + variants
- [ ] T033 [P] Login ERB templates in lib/component_ready/templates/login/_default.html.erb + variants
- [ ] T034 [P] Banner ERB templates in lib/component_ready/templates/banner/_default.html.erb + variants

## Phase 3.4: Integration & Demo
- [ ] T035 Create demo Rails app in demo_app/ with ComponentReady integration
- [ ] T036 System integration tests in spec/system/ using demo app
- [ ] T037 Performance validation - ensure <1ms rendering overhead

## Phase 3.5: Polish & Documentation
- [x] T038 [P] Update README.md with installation, usage examples, and component gallery
- [ ] T039 [P] Generate YARD documentation for all component classes
- [ ] T040 [P] Create quickstart guide validation in demo_app/
- [ ] T041 Validate WCAG accessibility compliance across all components
- [ ] T042 Final gem packaging and version tagging

## Dependencies

### Setup Dependencies
- T001 → T002 → T004 (gem structure → main file → engine)
- T005 → T020 (base class spec → base implementation) 
- T006 → T021 (helper spec → helper implementation)

### Test-First Dependencies (Critical Path)
- T009-T019 (all tests) → T020-T034 (all implementations)
- T020 (Base) → T023-T028 (component classes depend on base)
- T021 (helper) → T017, T036 (integration tests need helper)

### Component Dependencies
- T023-T028 (component classes) → T029-T034 (templates need classes)
- T020-T034 (all core) → T035-T037 (integration needs implementation)
- T035-T037 (integration) → T038-T042 (polish needs working system)

## Parallel Execution Examples

### Setup Phase (T003, T007, T008 can run together)
```bash
# Launch setup tasks in parallel:
Task: "Configure RSpec in spec/spec_helper.rb and spec/rails_helper.rb"  
Task: "Configure Bundler and development dependencies in Gemfile"
Task: "Set up linting with RuboCop in .rubocop.yml"
```

### Test Writing Phase (T010-T015 can run together)
```bash
# Launch component tests in parallel:
Task: "Button component test in spec/component_ready/components/button_spec.rb"
Task: "Slider component test in spec/component_ready/components/slider_spec.rb" 
Task: "Footer component test in spec/component_ready/components/footer_spec.rb"
Task: "Pricing component test in spec/component_ready/components/pricing_spec.rb"
Task: "Login component test in spec/component_ready/components/login_spec.rb"
Task: "Banner component test in spec/component_ready/components/banner_spec.rb"
```

### Component Implementation Phase (T023-T028 can run together)
```bash
# Launch component implementations in parallel:
Task: "Button component class in lib/component_ready/components/button.rb"
Task: "Slider component class in lib/component_ready/components/slider.rb"
Task: "Footer component class in lib/component_ready/components/footer.rb" 
Task: "Pricing component class in lib/component_ready/components/pricing.rb"
Task: "Login component class in lib/component_ready/components/login.rb"
Task: "Banner component class in lib/component_ready/components/banner.rb"
```

### Template Creation Phase (T029-T034 can run together)  
```bash
# Launch template creation in parallel:
Task: "Button ERB templates in lib/component_ready/templates/button/_default.html.erb + variants"
Task: "Slider ERB templates in lib/component_ready/templates/slider/_default.html.erb + variants"
Task: "Footer ERB templates in lib/component_ready/templates/footer/_default.html.erb + variants"
Task: "Pricing ERB templates in lib/component_ready/templates/pricing/_default.html.erb + variants"
Task: "Login ERB templates in lib/component_ready/templates/login/_default.html.erb + variants" 
Task: "Banner ERB templates in lib/component_ready/templates/banner/_default.html.erb + variants"
```

### Polish Phase (T038, T039, T040 can run together)
```bash
# Launch documentation tasks in parallel:
Task: "Update README.md with installation, usage examples, and component gallery"
Task: "Generate YARD documentation for all component classes"
Task: "Create quickstart guide validation in demo_app/"
```

## Notes
- **TDD Critical**: All tests (T009-T019) must be written and failing before any implementation
- **Component Independence**: Each component (button, slider, etc.) can be developed in parallel
- **Template Dependencies**: Templates require their component classes to be implemented first
- **Integration Last**: Demo app and system tests require all core components to be complete
- **Commit Strategy**: Commit after each task completion for clear progress tracking

## Task Generation Rules Applied
✅ Each component entity → component class + test + template tasks  
✅ Each contract interface → contract validation test  
✅ Different files marked [P] for parallel execution  
✅ Tests before implementation (TDD enforced)  
✅ Dependencies clearly mapped  
✅ File paths specified for all tasks