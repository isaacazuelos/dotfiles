# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "david";
    defaultGateway = "10.0.1.1";
    nameservers = [ "10.0.1.9" ];
    useDHCP = true;
    interfaces.enp5s0.ipv4.addresses = [{
      address = "10.0.1.10";
      prefixLength = 24;
    }];
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 
        22 # SSH 
      ];
      allowedUDPPortRanges = [
        { from = 60000; to = 61000; } # Mosh
      ];
    };
  };

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Canada/Mountain";


  programs = {
    mosh.enable = true;
    fish.enable = true;
  };

  # Most packages should be installed per-user with `nix-env`, but these are
  # here to help make that easier.
  environment.systemPackages = with pkgs; [
    neovim
    rofi
    git
  ];

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    source-code-pro
    unifont
    siji
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    openssh = { 
      enable = true;
      permitRootLogin = "no";
      # See https://superuser.com/questions/161609 for why we need both.
      passwordAuthentication = false;
      challengeResponseAuthentication = false;
    };
    compton = {
      enable = true;
      backend = "glx";
      vSync = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      videoDrivers = [ "nvidia" ];
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };

  users.users.iaz = {
    isNormalUser = true;
    description = "Isaac Azuelos";
    extraGroups = [ "audio" "wheel" ];
    home = "/home/iaz";
    shell = pkgs.fish;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}

