# AGENTS.md — Bubberstation

A downstream of [/tg/station](https://github.com/tgstation/tgstation) Space Station 13. DM (Dream Maker, BYOND) + TGUI (React/Rspack).

## Project structure

| Path | Role |
|---|---|
| `code/` | Core TG upstream code (read-only unless marked `// BUBBER EDIT`) |
| `modular_zubbers/` | Bubber's own modular additions; mirror TG paths |
| `modular_skyrat/` | Skyrat modules; free to edit existing files, no new files (being removed) |
| `code/__DEFINES/~~bubber_defines/` | Modular defines |
| `tgui/` | Bun workspace — React UI framework (packages: `tgui`, `tgui-panel`, `tgui-say`). Bundled via Rspack. |
| `_maps/` | Map JSON manifests + `.dmm` files (TGM format required) |
| `tools/ci/` | CI scripts; run_server.sh runs integration tests via DreamDaemon |

## Build & dev commands

Use `BUILD.bat` (Windows) or `tools/build/build.sh` (Linux). Powered by Juke Build.

```bash
tools/build/build.sh all          # test + lint + build (full CI)
tools/build/build.sh build         # DM compile + TGUI bundle
tools/build/build.sh test          # DM unit tests + TGUI tests
tools/build/build.sh lint          # TGUI lint + typecheck
tools/build/build.sh server        # compile + run DreamDaemon
tools/build/build.sh tgui          # just TGUI bundle
tools/build/build.sh tgui-test     # just TGUI tests
tools/build/build.sh tgui-lint     # just TGUI lint+tsc
tools/build/build.sh tgui-dev      # TGUI dev server
tools/build/build.sh --help        # list all targets
```

From `tgui/` directory directly:
```bash
bun tgui:build    # production bundle
bun tgui:dev      # dev server (requires open tgui window in-game)
bun tgui:test     # run tgui tests
bun tgui:tsc      # typecheck only
```

Root-level:
```bash
bun tgui:lint     # biome check --write --unsafe tgui (auto-fix)
```

## DM specifics

- **Entrypoint**: `tgstation.dme` — MUST include `code/genesis_call.dme` first (BYOND static init hack)
- **Compiler**: `BUILD.cmd`/`BUILD.bat` only; DreamMaker directly will fail (needs TGUI bundle)
- **Required BYOND**: `516.1659` (see `dependencies.sh`)
- **Unit tests**: `code/modules/unit_tests/` — activated by `#define UNIT_TESTS` in `code/_compile_options.dm:95`. Use `TEST_ASSERT`, `TEST_FAIL`, etc. Always use `mob/living/carbon/human/consistent` (not `/human`). Rerun with `TEST_REPEAT`; focus with `TEST_FOCUS`.
- **Linters**: DreamChecker (SpacemanDMM), OpenDream compile check, grep-based checks (`tools/ci/check_grep.sh`), ticked_file_enforcement, define_sanity, trait_validity, maplint
- **Debugging**: VSCode F5 builds + runs with Auxtools debugger (configured in `SpacemanDMM.toml`)
- **Preload**: `#define PRELOAD_RSC 0` in `_compile_options.dm` for CDN delivery
- **Rust-g**: native library (v4.2.0), prebuilt DLL for Windows, build on Linux

## Modularization conventions

- **New code**: mirror TG path under `modular_zubbers/` (e.g., `modular_zubbers/code/game/...`)
- **Core edits**: wrap in comments:
  ```
  // BUBBER EDIT - CHANGE - START - FEATURE_NAME
  ...changed code...
  // BUBBER EDIT - CHANGE - END
  ```
  Same pattern for `ADDITION`, `REMOVAL`. For removals, comment out the block with `/* */`.
- **TGUI edits** in upstream files: use `// BUBBER EDIT` inline or `/* BUBBER EDIT */`
- **New TGUI files** (Bubber-specific): start with `// THIS IS A BUBBER UI FILE` on line 1
- **Single-use defines**: define at top and `#undef` at bottom of file. Multi-file defines go in `code/__DEFINES/~~bubber_defines/`
- **Map changes**: use automapper (template or simple-area), never edit TG `.dmm` files directly

## CI pipeline (ci_suite.yml)

1. `run_linters` — grep checks, DreamChecker, OpenDream, map checks, TGUI lint
2. `collect_data` — determines required BYOND versions and maps
3. `compile_all_maps` — compiles each map's DME separately
4. `setup_build_artifacts` — compiles DMBs for each BYOND version
5. `run_all_tests` — runs DreamDaemon integration tests per map (requires MySQL, rust-g, dreamluau)
6. `compare_screenshots` — screenshot diff comparison

## Testing quirks

- Integration tests need MySQL/MariaDB (`SQL/` schema files), rust-g, dreamluau
- Screenshot tests output to `data/screenshots_new/`
- Flaky tests: rerun with `TEST_REPEAT(/datum/unit_test/name, 5)` — never push
- Map tests use `_maps/<map>.json` config; server runs on `runtimestation` for low-mem mode
- TGUI tests use Bun + happy-dom (no browser needed), preloaded via `tgui/happydom.ts`

## Code style

- **DM**: tab indentation (`.editorconfig`), space indentation is an error
- **TGUI/JS/TS**: single quotes, space indentation (Biome config), organize imports on save
- No `var/` in proc arguments, no `global vars` without helper, no `.proc/` syntax
- `balloon_alert` messages: lowercase start, no spans
- `to_chat()` requires content argument
- Trait sources must be string keys (`REF(src)`), not datum references
- `forceMove(x, y)` is wrong (caller.method, not static method)
