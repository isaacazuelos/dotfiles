# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# Also, use https://nixos.org/nixos/options.html to search for 
# configuration options.

{ config, pkgs, ... }:

let passwords = import ./passwords.nix;
in {
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

    wireless = {
      enable = true;
      networks = passwords.wifiNetworks;
    };

    interfaces.wlp4s0 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "10.0.1.10";
        prefixLength = 24;
      }];
    };

    firewall = {
      enable = true;
      allowPing = true;
      # SSH
      allowedTCPPorts = [ 22 ];
      # Mosh
      allowedUDPPortRanges = [{
        from = 60000;
        to = 61000;
      }];
    };
  };

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Canada/Mountain";

  programs = {
    mosh.enable = true;
    fish.enable = true;
  };

  # Most packages should be installed per-user with `nix-env`, but these are
  # here to help make that easier.
  environment.systemPackages = with pkgs; [ neovim git tmux ];

  fonts.fonts = with pkgs; [ fira-code fira-code-symbols source-code-pro ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    ddclient = {
      # See https://www.namecheap.com/support/knowledgebase/article.aspx/583/
      # for more on how this is configured.
      enable = true;
      username = "azuelos.ca";
      password = passwords.dynamicDNS;
      domains = [ "home" ];
      use = "web, web=dynamicdns.park-your-domain.com/getip";
      protocol = "namecheap";
      server = "dynamicdns.park-your-domain.com";
    };
    openssh = {
      enable = true;
      permitRootLogin = "no";
      # See https://superuser.com/questions/161609 for why we need both.
      passwordAuthentication = false;
      challengeResponseAuthentication = false;
    };
    xserver = {
      enable = true;
      layout = "us";
      videoDrivers = [ "nvidia" ];
      desktopManager.plasma5.enable = true;
    };
  };

  users.users.iaz = {
    isNormalUser = true;
    description = "Isaac Azuelos";
    extraGroups = [ "audio" "wheel" "networkmanager" ];
    home = "/home/iaz";
    shell = pkgs.fish;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
