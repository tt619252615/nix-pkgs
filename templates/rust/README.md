# Rust Development Environment

## Quick Start

```bash
# Enter development shell
nix develop

# Create new project
cargo new myproject
cd myproject

# Build and run
cargo run
```

## Adding Rust Tools

Edit `nix/development.nix`:

```nix
packages = [
  rustc
  cargo
  fish
  rustfmt
  clippy
  rust-analyzer
  # Add more tools here
  cargo-watch     # Auto-rebuild on changes
  cargo-edit      # cargo add/rm/upgrade
  cargo-expand    # Expand macros
  cargo-audit     # Security audit
  cargo-outdated  # Check outdated deps
  cargo-flamegraph # Performance profiling
];
```

## Adding System Dependencies

For crates that need C libraries:

```nix
packages = [
  # ... existing
  pkg-config
  openssl
  sqlite
];

shellHook = ''
  export PKG_CONFIG_PATH="${openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
  export OPENSSL_DIR="${openssl.dev}"
  # ...
'';
```

## Common Dependencies

```nix
packages = [
  # ... existing

  # For openssl-sys
  openssl
  pkg-config

  # For sqlite
  sqlite

  # For graphics/GUI
  xorg.libX11
  xorg.libXcursor
  xorg.libXrandr
  xorg.libXi
  vulkan-loader
];
```

## Customizing Shell Theme

Edit the `fishConfig` section in `nix/development.nix`:

```nix
# Change colors
set -g fish_color_command brred --bold
set -g fish_color_param yellow

# Change prompt icon (already using crab emoji)
set_color brred; echo -n "🦀 $rust_version"
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

## Environment Variables

Set automatically:

- `CARGO_HOME` - Set to `$PWD/.cargo`
- `RUSTUP_HOME` - Set to `$PWD/.rustup`

To customize, edit `shellHook`:

```nix
shellHook = ''
  export RUST_BACKTRACE=1
  export RUST_LOG=debug
  # ...
'';
```

## Cross Compilation

Add target toolchains:

```nix
packages = [
  # ... existing

  # For cross compilation
  gcc

  # Target-specific
  pkgsCross.mingwW64.buildPackages.gcc  # Windows
];
```

## Project Structure

```
.
├── flake.nix           # Flake entry point
├── flake.lock          # Locked dependencies
├── nix/
│   └── development.nix # Shell configuration
├── Cargo.toml          # Rust dependencies
├── src/
│   └── main.rs
└── README.md
```

## Common Issues

### OpenSSL errors

```nix
packages = [ openssl pkg-config ];

shellHook = ''
  export OPENSSL_DIR="${openssl.dev}"
  export OPENSSL_LIB_DIR="${openssl.out}/lib"
  export OPENSSL_INCLUDE_DIR="${openssl.dev}/include"
'';
```

### Linker errors

```nix
packages = [
  # ... existing
  gcc
  binutils
];
```
