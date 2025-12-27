# C++ Development Environment

## Quick Start

```bash
# Enter development shell
nix develop

# Build with CMake
mkdir build && cd build
cmake ..
make
```

## Build System Setup

### CMake (Recommended)

Create `CMakeLists.txt`:

```cmake
cmake_minimum_required(VERSION 3.20)
project(myproject)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(main src/main.cpp)
```

Build:

```bash
cmake -B build -G Ninja
cmake --build build
```

### Meson

```nix
# Add to packages in nix/development.nix
packages = [
  # ... existing
  meson
  ninja
];
```

## Adding Libraries

Edit `nix/development.nix`:

```nix
packages = [
  gcc
  clang
  cmake
  ninja
  gdb
  lldb
  clang-tools
  fish
  # Add libraries here
  boost
  fmt
  spdlog
  nlohmann_json
  catch2
  gtest
];
```

## Adding pkg-config Libraries

```nix
packages = [
  # ... existing
  pkg-config
  openssl
  curl
  sqlite
];

shellHook = ''
  export PKG_CONFIG_PATH="${openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
  # ...
'';
```

## Compiler Selection

### Use GCC

```bash
export CC=gcc
export CXX=g++
cmake -B build
```

### Use Clang

```bash
export CC=clang
export CXX=clang++
cmake -B build
```

## Customizing Shell Theme

Edit the `fishConfig` section in `nix/development.nix`:

```nix
# Change colors
set -g fish_color_command brblue --bold
set -g fish_color_param blue

# Change prompt icon
set_color brblue; echo -n " $gcc_version"
```

## LSP Setup (clangd)

Generate `compile_commands.json`:

```bash
cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -s build/compile_commands.json .
```

## Using with direnv

Create `.envrc`:

```bash
use flake
```

Then:

```bash
direnv allow
```

## Project Structure

```
.
├── flake.nix           # Flake entry point
├── flake.lock          # Locked dependencies
├── nix/
│   └── development.nix # Shell configuration
├── CMakeLists.txt      # Build configuration
├── src/
│   └── main.cpp
└── README.md
```

## Common Issues

### Missing headers

Search for package:

```bash
nix search nixpkgs packagename
```

### Linking errors

Ensure library is in `packages` and properly linked in CMakeLists.txt:

```cmake
find_package(OpenSSL REQUIRED)
target_link_libraries(main OpenSSL::SSL OpenSSL::Crypto)
```
