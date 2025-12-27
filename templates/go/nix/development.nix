{ mkShell, go, gopls, delve, golangci-lint, fish, writeText }:

let
  # Fish shell theme configuration - Gopher style
  fishConfig = writeText "config.fish" ''
    # Go dev environment theme
    set -g fish_greeting ""

    # Color scheme - Cyan/Teal (Go colors)
    set -g fish_color_normal normal
    set -g fish_color_command cyan --bold
    set -g fish_color_param brblue
    set -g fish_color_error red --bold
    set -g fish_color_comment brblack
    set -g fish_color_quote green
    set -g fish_color_operator yellow

    # Custom prompt
    function fish_prompt
      set -l last_status $status
      set -l cwd (prompt_pwd)

      # Go icon and version
      set -l go_version (go version 2>&1 | string match -r 'go[0-9.]+' | string replace "go" "")

      # Git branch
      set -l git_branch ""
      if git rev-parse --git-dir >/dev/null 2>&1
        set git_branch (git branch --show-current 2>/dev/null)
        if test -n "$git_branch"
          set git_branch " 󰊢 $git_branch"
        end
      end

      # Status indicator
      set -l status_color cyan
      if test $last_status -ne 0
        set status_color red
      end

      echo ""
      set_color cyan; echo -n "󰟓 $go_version"
      set_color brblack; echo -n " │"
      set_color yellow; echo -n " $cwd"
      set_color magenta; echo -n "$git_branch"
      echo ""
      set_color $status_color; echo -n "❯ "
      set_color normal
    end

    function fish_right_prompt
      set_color brblack
      echo -n "🐹 go"
      set_color normal
    end
  '';

in mkShell {
  name = "go-dev";

  packages = [
    go
    fish
    # Development tools
    gopls           # Language server
    delve           # Debugger
    golangci-lint   # Linter
  ];

  shellHook = ''
    export SHELL=${fish}/bin/fish
    export GOPATH="$PWD/.go"
    export GOBIN="$GOPATH/bin"
    export PATH="$GOBIN:$PATH"
    export XDG_CONFIG_HOME="$PWD/.config"
    mkdir -p $XDG_CONFIG_HOME/fish $GOPATH

    cp ${fishConfig} $XDG_CONFIG_HOME/fish/config.fish

    echo "󰟓 Go development environment"
    echo "   Go: $(go version | grep -oP 'go[0-9.]+')"
    echo "   Tools: gopls, delve, golangci-lint"
    echo ""

    exec fish
  '';
}
