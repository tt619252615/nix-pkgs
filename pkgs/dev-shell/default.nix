{ mkShell, python3 }:

let
  nix-pkgs-dev = python3.withPackages (pyPkgs:
    with pyPkgs;
    [
      tushare
    ]);

  pythonIcon = "f3e2";

in mkShell rec {
  name = "nix-pkgs";

  packages = [ nix-pkgs-dev ];

  shellHook = ''
    export AIRFLOW_HOME="$(pwd)/airflow"
    export PS1="$(echo -e '\u${pythonIcon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
  '';
}