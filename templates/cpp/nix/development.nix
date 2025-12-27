{ mkShell, gcc, clang, cmake, ninja, gdb, lldb, clang-tools, fish, writeText }:

let
  # Fish shell theme configuration - C++ style
  fishConfig = writeText "config.fish" ''
    # C++ dev environment theme
    set -g fish_greeting ""

    # Color scheme - Blue/Purple (C++ style)
    set -g fish_color_normal normal
    set -g fish_color_command brblue --bold
    set -g fish_color_param blue
    set -g fish_color_error red --bold
    set -g fish_color_comment brblack
    set -g fish_color_quote green
    set -g fish_color_operator magenta

    # Custom prompt
    function fish_prompt
      set -l last_status $status
      set -l cwd (prompt_pwd)

      # Compiler version
      set -l gcc_version (gcc --version 2>&1 | head -1 | string match -r '[0-9]+\.[0-9]+\.[0-9]+')

      # Git branch
      set -l git_branch ""
      if git rev-parse --git-dir >/dev/null 2>&1
        set git_branch (git branch --show-current 2>/dev/null)
        if test -n "$git_branch"
          set git_branch " 󰊢 $git_branch"
        end
      end

      # Status indicator
      set -l status_color brblue
      if test $last_status -ne 0
        set status_color red
      end

      echo ""
      set_color brblue; echo -n " $gcc_version"
      set_color brblack; echo -n " │"
      set_color yellow; echo -n " $cwd"
      set_color magenta; echo -n "$git_branch"
      echo ""
      set_color $status_color; echo -n "❯ "
      set_color normal
    end

    function fish_right_prompt
      set_color brblack
      echo -n "⚙️ c++"
      set_color normal
    end
  '';

in mkShell {
  name = "cpp-dev";

  packages = [
    gcc
    clang
    fish
    # Build tools
    cmake
    ninja
    # Debug tools
    gdb
    lldb
    # Development tools
    clang-tools   # clangd, clang-format, clang-tidy
  ];

  shellHook = ''
    export SHELL=${fish}/bin/fish
    export XDG_CONFIG_HOME="$PWD/.config"
    mkdir -p $XDG_CONFIG_HOME/fish

    cp ${fishConfig} $XDG_CONFIG_HOME/fish/config.fish

    echo " C++ development environment"
    echo "   GCC: $(gcc --version | head -1 | grep -oP '[0-9]+\.[0-9]+\.[0-9]+')"
    echo "   Clang: $(clang --version | head -1 | grep -oP '[0-9]+\.[0-9]+\.[0-9]+')"
    echo "   Tools: cmake, ninja, gdb, lldb, clangd"
    echo ""

    exec fish
  '';
}
