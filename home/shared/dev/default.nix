{ pkgs, ... }: {
  imports = [
    ./helix
    ./flutter.nix
  ];

  home.packages =
    with pkgs;
    with nodePackages;
    with python311Packages; [
    clang go # Compilers
    python3 pip pipx # Python3
    bun esbuild live-server  # JavaScript

    # awscli2
    # kubectl kubernetes-helm

    insomnia
    distrobox
    podman-tui 
    podman-compose 
  ];
}
