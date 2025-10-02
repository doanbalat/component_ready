
# Implementation Plan: ComponentReady Ruby Gem - Modern Web Component Library

**Branch**: `001-i-want-to` | **Date**: October 2, 2025 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-i-want-to/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
   → If not found: ERROR "No feature spec at {path}"
2. Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Detect Project Type from file system structure or context (web=frontend+backend, mobile=app+api)
   → Set Structure Decision based on project type
3. Fill the Constitution Check section based on the content of the constitution document.
4. Evaluate Constitution Check section below
   → If violations exist: Document in Complexity Tracking
   → If no justification possible: ERROR "Simplify approach first"
   → Update Progress Tracking: Initial Constitution Check
5. Execute Phase 0 → research.md
   → If NEEDS CLARIFICATION remain: ERROR "Resolve unknowns"
6. Execute Phase 1 → contracts, data-model.md, quickstart.md, agent-specific template file (e.g., `CLAUDE.md` for Claude Code, `.github/copilot-instructions.md` for GitHub Copilot, `GEMINI.md` for Gemini CLI, `QWEN.md` for Qwen Code or `AGENTS.md` for opencode).
7. Re-evaluate Constitution Check section
   → If new violations: Refactor design, return to Phase 1
   → Update Progress Tracking: Post-Design Constitution Check
8. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
9. STOP - Ready for /tasks command
```

**IMPORTANT**: The /plan command STOPS at step 7. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary
Create a Ruby gem that provides modern, pre-styled web components for Rails applications. Components (buttons, sliders, footers, pricing tables, login forms, banners) will be built exclusively with Tailwind CSS for consistency and customizability. The gem targets solo Rails developers who need professional UI components without custom CSS design work, with minimal configuration required beyond Tailwind CSS setup.

## Technical Context
**Language/Version**: Ruby 3.0+ for gem compatibility with modern Rails applications  
**Primary Dependencies**: Rails view helpers, Tailwind CSS (peer dependency), minimal JavaScript for interactive components  
**Storage**: No database storage - components are pure view templates with local metadata  
**Testing**: RSpec for gem testing, Rails system tests for integration validation  
**Target Platform**: Rails web applications with Tailwind CSS configured
**Project Type**: single - Ruby gem library structure  
**Performance Goals**: Minimal overhead - components should add <1ms to view rendering  
**Constraints**: Pure Tailwind CSS styling, no external images, minimal JavaScript, local metadata only  
**Scale/Scope**: 15-20 initial components covering common UI patterns (buttons, forms, navigation, content sections)

**User Implementation Details**: Purely vanilla Tailwind CSS, HTML and JavaScript. No external image uploads. Metadata stored locally. Minimal configuration - only requires Tailwind CSS setup in Rails application.

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Code Quality**: ✅ PASS - Will follow Ruby/Rails best practices for gem development  
**Testing Standards**: ✅ PASS - RSpec for gem unit tests, Rails integration tests for component validation  
**User Experience Consistency**: ✅ PASS - Consistent design system via Tailwind classes, responsive components  
**Performance Requirements**: ✅ PASS - Minimal view rendering overhead, no N+1 queries (pure templates)

## Project Structure

### Documentation (this feature)
```
specs/[###-feature]/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### Source Code (repository root)
```
lib/
├── component_ready/
│   ├── components/
│   │   ├── button.rb
│   │   ├── slider.rb
│   │   ├── footer.rb
│   │   ├── pricing.rb
│   │   ├── login.rb
│   │   ├── banner.rb
│   │   └── base.rb
│   ├── helpers/
│   │   └── component_helper.rb
│   ├── templates/
│   │   └── [component_name]/
│   │       ├── default.html.erb
│   │       └── variants/
│   ├── version.rb
│   └── engine.rb
├── component_ready.rb

spec/
├── components/
├── helpers/
├── integration/
└── fixtures/

demo_app/           # Rails demo application
├── app/
├── config/
└── Gemfile
```

**Structure Decision**: Single Ruby gem project with Rails engine integration. Components are Ruby classes that generate HTML with Tailwind CSS classes. Templates stored as ERB partials. Demo Rails app for showcasing and testing integration.

## Phase 0: Outline & Research
1. **Extract unknowns from Technical Context** above:
   - For each NEEDS CLARIFICATION → research task
   - For each dependency → best practices task
   - For each integration → patterns task

2. **Generate and dispatch research agents**:
   ```
   For each unknown in Technical Context:
     Task: "Research {unknown} for {feature context}"
   For each technology choice:
     Task: "Find best practices for {tech} in {domain}"
   ```

3. **Consolidate findings** in `research.md` using format:
   - Decision: [what was chosen]
   - Rationale: [why chosen]
   - Alternatives considered: [what else evaluated]

**Output**: research.md with all NEEDS CLARIFICATION resolved

## Phase 1: Design & Contracts
*Prerequisites: research.md complete*

1. **Extract entities from feature spec** → `data-model.md`:
   - Entity name, fields, relationships
   - Validation rules from requirements
   - State transitions if applicable

2. **Generate API contracts** from functional requirements:
   - For each user action → endpoint
   - Use standard REST/GraphQL patterns
   - Output OpenAPI/GraphQL schema to `/contracts/`

3. **Generate contract tests** from contracts:
   - One test file per endpoint
   - Assert request/response schemas
   - Tests must fail (no implementation yet)

4. **Extract test scenarios** from user stories:
   - Each story → integration test scenario
   - Quickstart test = story validation steps

5. **Update agent file incrementally** (O(1) operation):
   - Run `.specify/scripts/powershell/update-agent-context.ps1 -AgentType copilot`
     **IMPORTANT**: Execute it exactly as specified above. Do not add or remove any arguments.
   - If exists: Add only NEW tech from current plan
   - Preserve manual additions between markers
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency
   - Output to repository root

**Output**: data-model.md, /contracts/*, failing tests, quickstart.md, agent-specific file

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:
- Load `.specify/templates/tasks-template.md` as base
- Generate tasks from Phase 1 design docs (contracts, data model, quickstart)
- Each component class → component implementation task + spec test [P]
- Base infrastructure → gem structure, engine, helpers [Sequential]
- Each template → ERB template creation task [P]
- Integration → Rails helper integration, demo app setup
- Documentation → README, component gallery, deployment

**Ordering Strategy**:
- TDD order: Specs before implementation, integration tests before components
- Dependency order: Base classes → Component classes → Templates → Integration
- Infrastructure first: Gem structure, engine setup, base component class
- Components parallel: All component classes can be built independently [P]
- Templates parallel: ERB templates can be created independently [P]
- Integration last: Helper registration, demo app, final testing

**Component Task Breakdown**:
1. Infrastructure (sequential): Gem setup, Engine, Base class, Helper module
2. Component specs (parallel): RSpec tests for each component class  
3. Component classes (parallel): Button, Slider, Footer, Pricing, Login, Banner
4. Template creation (parallel): ERB templates for each component + variants
5. Integration (sequential): Helper integration, demo app, system tests
6. Documentation (parallel): README, quickstart validation, component gallery

**Estimated Output**: 35-40 numbered, ordered tasks in tasks.md

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation
*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)  
**Phase 4**: Implementation (execute tasks.md following constitutional principles)  
**Phase 5**: Validation (run tests, execute quickstart.md, performance validation)

## Complexity Tracking
*Fill ONLY if Constitution Check has violations that must be justified*

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |


## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
- [x] Phase 2: Task planning complete (/plan command - describe approach only)
- [ ] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
- [x] Complexity deviations documented (none required)

---
*Based on Constitution v2.1.1 - See `/memory/constitution.md`*
