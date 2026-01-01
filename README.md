# nix-pkgs

Extra Python packages and development environment templates for Nix.

## Development Environment Templates

This flake provides ready-to-use development environment templates with beautiful fish shell themes.

### Available Templates

| Template | Description | Icon |
|----------|-------------|------|
| `python` | Python with ruff, black, mypy, poetry | 🐍 |
| `go`     | Go with gopls, delve, golangci-lint | 🐹 |
| `cpp`    | C++ with gcc, clang, cmake, ninja, gdb | ⚙️ |
| `rust`   | Rust with cargo, clippy, rust-analyzer | 🦀 |
| `java`   | Java 21 with maven, gradle | ☕ |

### Quick Start

```bash
# Create a new project directory
mkdir my-project && cd my-project

# Initialize with a template (choose one)
nix flake init -t "git+ssh://git@github.com/tt619252615/nix-pkgs#python"
nix flake init -t "git+ssh://git@github.com/tt619252615/nix-pkgs#go"
nix flake init -t "git+ssh://git@github.com/tt619252615/nix-pkgs#cpp"
nix flake init -t "git+ssh://git@github.com/tt619252615/nix-pkgs#rust"
nix flake init -t "git+ssh://git@github.com/tt619252615/nix-pkgs#java"

# Enter the development shell
nix develop
```

### Using HTTPS (Alternative)

```bash
nix flake init -t "github:tt619252615/nix-pkgs#python"
```

### Force Refresh Template

If you've updated the template and want to get the latest version:

```bash
nix flake init -t "git+ssh://git@github.com/tt619252615/nix-pkgs#python" --refresh
```

### Template Structure

Each template creates the following structure:

```
my-project/
├── flake.nix           # Flake entry point
└── nix/
    └── development.nix # Shell config, packages, and theme
```

### Customization

After initialization, edit `nix/development.nix` to:

- Add language-specific packages
- Add system dependencies
- Customize the fish shell theme
- Modify environment variables

See the `README.md` in each template for detailed instructions.

---

## Python Packages

This flake also provides extra Python packages not available in nixpkgs.

### Usage as Overlay

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nix-pkgs.url = "git+ssh://git@github.com/tt619252615/nix-pkgs";
  };

  outputs = { nixpkgs, nix-pkgs, ... }: {
    # Apply overlay
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [{
        nixpkgs.overlays = [ nix-pkgs.overlays.default ];
      }];
    };
  };
}
```

### Build a Package Directly

```bash
nix build "git+ssh://git@github.com/tt619252615/nix-pkgs#tushare"
```
