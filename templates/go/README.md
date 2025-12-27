# Go Development Environment

## Quick Start

```bash
# Enter development shell
nix develop

# Or run directly
nix develop -c go run main.go
```

## Project Initialization

```bash
# Initialize a new Go module
go mod init github.com/username/project

# Download dependencies
go mod tidy
```

## Adding Go Tools

Edit `nix/development.nix`, add to the `packages` list:

```nix
packages = [
  go
  fish
  gopls
  delve
  golangci-lint
  # Add more tools here
  go-tools        # staticcheck, etc.
  gomodifytags    # Modify struct tags
  impl            # Generate interface implementations
  gotests         # Generate tests
  mockgen         # Generate mocks
];
```

## Adding System Dependencies

For packages that require C libraries (CGO):

```nix
packages = [
  # ... existing packages

  # CGO dependencies
  gcc
  pkg-config

  # Common C libraries
  sqlite
  openssl
];

# Set CGO environment
shellHook = ''
  export CGO_ENABLED=1
  # ... rest of shellHook
'';
```

## Customizing Shell Theme

Edit the `fishConfig` section in `nix/development.nix`:

```nix
# Change colors
set -g fish_color_command cyan --bold    # Command color
set -g fish_color_param brblue           # Parameter color

# Change prompt icon
set_color cyan; echo -n "󰟓 $go_version"  # Change 󰟓 to other icon
```

## Using with direnv

Create `.envrc` in your project root:

```bash
use flake
```

Then run:

```bash
direnv allow
```

## Environment Variables

The following are set automatically:

- `GOPATH` - Set to `$PWD/.go`
- `GOBIN` - Set to `$GOPATH/bin`

To customize, edit `shellHook` in `nix/development.nix`:

```nix
shellHook = ''
  export GOPATH="$HOME/go"
  export GOPROXY="https://goproxy.cn,direct"  # For China users
  # ...
'';
```

## Project Structure

```
.
├── flake.nix           # Flake entry point
├── flake.lock          # Locked dependencies
├── nix/
│   └── development.nix # Shell configuration
└── README.md
```

## Common Issues

### CGO errors

Ensure `gcc` and required libraries are in `packages`:

```nix
packages = [
  gcc
  pkg-config
  # Add required C libraries
];
```

### Private modules

```bash
export GOPRIVATE="github.com/your-org/*"
```
