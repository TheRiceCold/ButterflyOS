# DOCS: https://github.com/hyprland-community/pyprland/wiki
{ inputs, pkgs, ... }:
let
  apps = import ../../../apps/get-apps.nix pkgs;
  configFile = with apps; /* toml */ ''

    [pyprland]
    plugins = [ "scratchpads", "magnify", "layout_center" ]

    [scratchpads.term]
    lazy = false
    size = "38% 40%" # width height
    command = "${term}"
    animation = "fromBottom"

  '';
in {
  home.packages = [ inputs.pyprland.packages.${pkgs.system}.default ];
  xdg.configFile."hypr/pyprland.toml".text = configFile;

  programs.bash.initExtra = /* bash */ ''

    # Runs only on first instance (scratchpad terminal)
    LIVE_COUNTER=$(ps a | awk '{print $2}' | grep -vi "tty*" | uniq | wc -l);
    if [ $LIVE_COUNTER -eq 1 ]; then
      fastfetch
    fi

  '';
}