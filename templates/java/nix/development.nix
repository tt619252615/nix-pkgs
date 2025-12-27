{ mkShell, jdk21, maven, gradle, fish, writeText }:

let
  # Fish shell theme configuration - Java style
  fishConfig = writeText "config.fish" ''
    # Java dev environment theme
    set -g fish_greeting ""

    # Color scheme - Red/Orange (Java colors)
    set -g fish_color_normal normal
    set -g fish_color_command red --bold
    set -g fish_color_param bryellow
    set -g fish_color_error brred --bold
    set -g fish_color_comment brblack
    set -g fish_color_quote green
    set -g fish_color_operator yellow

    # Custom prompt
    function fish_prompt
      set -l last_status $status
      set -l cwd (prompt_pwd)

      # Java version
      set -l java_version (java --version 2>&1 | head -1 | string match -r '[0-9]+\.[0-9]+\.[0-9]+')

      # Git branch
      set -l git_branch ""
      if git rev-parse --git-dir >/dev/null 2>&1
        set git_branch (git branch --show-current 2>/dev/null)
        if test -n "$git_branch"
          set git_branch " 󰊢 $git_branch"
        end
      end

      # Status indicator
      set -l status_color red
      if test $last_status -ne 0
        set status_color brred
      end

      echo ""
      set_color red; echo -n " $java_version"
      set_color brblack; echo -n " │"
      set_color yellow; echo -n " $cwd"
      set_color magenta; echo -n "$git_branch"
      echo ""
      set_color $status_color; echo -n "❯ "
      set_color normal
    end

    function fish_right_prompt
      set_color brblack
      echo -n "☕ java"
      set_color normal
    end
  '';

in mkShell {
  name = "java-dev";

  packages = [
    jdk21
    fish
    # Build tools
    maven
    gradle
  ];

  shellHook = ''
    export SHELL=${fish}/bin/fish
    export JAVA_HOME=${jdk21}
    export M2_HOME="$PWD/.m2"
    export GRADLE_USER_HOME="$PWD/.gradle"
    export XDG_CONFIG_HOME="$PWD/.config"
    mkdir -p $XDG_CONFIG_HOME/fish $M2_HOME $GRADLE_USER_HOME

    cp ${fishConfig} $XDG_CONFIG_HOME/fish/config.fish

    echo "☕ Java development environment"
    echo "   Java: $(java --version 2>&1 | head -1)"
    echo "   Tools: maven, gradle"
    echo ""

    exec fish
  '';
}
