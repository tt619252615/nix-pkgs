{ mkShell, rustc, cargo, rustfmt, clippy, rust-analyzer, fish, writeText }:

let
  # Fish shell theme configuration - Rust style
  fishConfig = writeText "config.fish" ''
    # Rust dev environment theme
    set -g fish_greeting ""

    # Color scheme - Orange/Red (Rust colors)
    set -g fish_color_normal normal
    set -g fish_color_command brred --bold
    set -g fish_color_param yellow
    set -g fish_color_error red --bold
    set -g fish_color_comment brblack
    set -g fish_color_quote green
    set -g fish_color_operator bryellow

    # Custom prompt
    function fish_prompt
      set -l last_status $status
      set -l cwd (prompt_pwd)

      # Rust version
      set -l rust_version (rustc --version 2>&1 | string match -r '[0-9]+\.[0-9]+\.[0-9]+')

      # Git branch
      set -l git_branch ""
      if git rev-parse --git-dir >/dev/null 2>&1
        set git_branch (git branch --show-current 2>/dev/null)
        if test -n "$git_branch"
          set git_branch " 󰊢 $git_branch"
        end
      end

      # Status indicator
      set -l status_color brred
      if test $last_status -ne 0
        set status_color red
      end

      echo ""
      set_color brred; echo -n "🦀 $rust_version"
      set_color brblack; echo -n " │"
      set_color yellow; echo -n " $cwd"
      set_color magenta; echo -n "$git_branch"
      echo ""
      set_color $status_color; echo -n "❯ "
      set_color normal
    end

    function fish_right_prompt
      set_color brblack
      echo -n "🦀 rust"
      set_color normal
    end
  '';

in mkShell {
  name = "rust-dev";

  packages = [
    rustc
    cargo
    fish
    # Development tools
    rustfmt         # Code formatter
    clippy          # Linter
    rust-analyzer   # Language server
  ];

  shellHook = ''
    export SHELL=${fish}/bin/fish
    export CARGO_HOME="$PWD/.cargo"
    export RUSTUP_HOME="$PWD/.rustup"
    export PATH="$CARGO_HOME/bin:$PATH"
    export XDG_CONFIG_HOME="$PWD/.config"
    mkdir -p $XDG_CONFIG_HOME/fish $CARGO_HOME

    cp ${fishConfig} $XDG_CONFIG_HOME/fish/config.fish

    echo "🦀 Rust development environment"
    echo "   Rust: $(rustc --version | grep -oP '[0-9]+\.[0-9]+\.[0-9]+')"
    echo "   Tools: cargo, rustfmt, clippy, rust-analyzer"
    echo ""

    exec fish
  '';
}
