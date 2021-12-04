{ config, lib, pkgs, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    package = pkgs.nixUnstable;
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "nixos";

    wireless = {
      enable = true;

      networks = {
        RAY = {
          pskRaw = "24afa51053e9ecf702d53c75ff10798e33059ca535882d8918e46ff1b029760b";
        };
      };
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "gb";
      xkbOptions = "eurosign:e";
      videoDrivers = [ "nvidia" ];

      windowManager.leftwm.enable = true;
      displayManager.sessionCommands = ''
        xrandr --output DP-4 --mode 1920x1080 --rate 144
      '';
    };

    picom.enable = true;
  };

  time.timeZone = "Europe/London";

  networking.useDHCP = false;
  networking.interfaces.enp9s0.useDHCP = true;
  networking.interfaces.wlp6s0.useDHCP = true;

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.brandon = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    rofi
    firefox
    vscode
    direnv
    spotify
    discord
    minecraft
    alacritty
    haskellPackages.xmobar
    # https://godbolt.org/z/qxq5KMsco :troll:
    (multimc.override { msaClientID = "499546d9-bbfe-4b9b-a086-eb3d75afb78f"; })
  ];

  programs.mtr.enable = true;
  programs.steam.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "21.11";

}

