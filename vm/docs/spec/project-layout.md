# Spec. Project Layout

Languages:
- C++
- CMake
- YAML (+ GitHub Workflow)
- Shell
- Nix
- Markdown

Environment:
- Nix
- Pre-Commit
- Zed

Scripts (directory scripts):
- prelude.sh
- cpp (see C++ build)
- yaml/lint.sh
- shell/lint.sh
- nix/lint.sh
- markdown/lint.sh

C++:
- CMake
- Ninja
- C++23
- Export compile_commands.json
- Scripts (scripts/cpp):
    - format.sh
    - build.sh <debug|asan|ubsan|release>
    - analyze
        - clang-tidy.sh
        - cppcheck.sh
        - infer.sh
    - test.sh
- Directories for CMake:
    - build/debug
    - build/asan
    - build/release

C++ QA:
- GTest
- GBenchmark
C++ QA:
- Sanitizers: ASan, UBSan
- Clang Format, Clang Tidy
- CppCheck
- Facebook Infer
C++ QA*:
- libFuzzer
