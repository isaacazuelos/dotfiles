# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  passwords = import ./passwords.nix;
  fqdn = "${config.networking.hostName}.${config.networking.domain}";
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    kernelParams = [ "console=ttyS0,19200n8" ];
    loader = {
      timeout = 10;
      grub = {
        device = "nodev";
        version = 2;
        enable = true;
        extraConfig = ''
          serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
          terminal_input serial;
          terminal_output serial;
        '';
      };
    };
  };

  networking = {
    usePredictableInterfaceNames = false;
    useDHCP = false;
    hostName = "so";
    domain = "very.software";
    defaultGateway = "172.105.8.1";
    nameservers = [ "172.105.0.5" "172.105.3.5" ];
    interfaces."eth0".ipv4.addresses = [{
      address = "172.105.8.192";
      prefixLength = 24;
    }];
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 20 80 443 8448 ];
      allowedUDPPortRanges = [{
        from = 60000;
        to = 61000;
      }];
    };
  };

  security.acme = {
    acceptTerms = true;
    email = "isaac@azuelos.ca";
    certs = {
      "very.software" = {
        domain = "very.software";
        group = "matrix-synapse";
        extraDomains = {
          "so.very.software" = null;
        };
      };
    }; 
  }; 

  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "UTC";
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    mtr
    sysstat
    inetutils
  ];

  programs = {
    mtr.enable = true;
    fish.enable = true;
    mosh.enable = true;
  };

  services = {
    postgresql = { 
      enable = true;
      package = pkgs.postgresql;
    };
    matrix-synapse = {
      enable = true;
      server_name = config.networking.domain;

      # I don't want to allow public registration.
      # See the manual's section for how to manually register a user.
      registration_shared_secret = passwords.matrixPSK;
      enable_registration = false;

      listeners = [{
        port = 8008;
        bind_address = "::1";
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [{
          names = [ "client" "federation" ];
          compress = false;
        }];
      }];
    };
    minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = true;
      # from https://discourse.nixos.org/t/howto-setting-up-a-nixos-minecraft-server-using-the-newest-version-of-minecraft/3445
      package = let 
        version = "1.16.3";
	url = "https://launcher.mojang.com/v1/objects/f02f4473dbf152c23d7d484952121db0b36698cb/server.jar";
	sha256 = "0nxdyw23037cr9cfcsfq1cvpy75am5dzmbgvvh3fq6h89kkm1r1j";
     in (pkgs.minecraft-server.overrideAttrs (old: rec {
	name = "minecrat-server-${version}";
	inherit version;
	src = pkgs.fetchurl {
	  inherit url sha256;
        };
      }));
    };
    nginx = {
      enable = true;
      # only recommendedProxySettings and recommendedGzipSettings are strictly required,
      # but the rest make sense as well
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;

      virtualHosts = {
        # This host section can be placed on a different host than the rest,
        # i.e. to delegate from the host being accessible as ${config.networking.domain}
        # to another host actually running the Matrix homeserver.
        "${config.networking.domain}" = {
          enableACME = true;
          forceSSL = true;

          locations."/".extraConfig = ''
            return 404;
          '';

          locations."= /.well-known/matrix/server".extraConfig = let
            # use 443 instead of the default 8448 port to unite
            # the client-server and server-server port for simplicity
            server = { "m.server" = "${fqdn}:443"; };
          in ''
            add_header Content-Type application/json;
            return 200 '${builtins.toJSON server}';
          '';
          locations."= /.well-known/matrix/client".extraConfig = let
            client = {
              "m.homeserver" = { "base_url" = "https://${fqdn}"; };
              "m.identity_server" = { "base_url" = "https://vector.im"; };
            };
            # ACAO required to allow riot-web on any URL to request this json file
          in ''
            add_header Content-Type application/json;
            add_header Access-Control-Allow-Origin *;
            return 200 '${builtins.toJSON client}';
          '';
        };

        # Reverse proxy for Matrix client-server and server-server communication
        ${fqdn} = {
          enableACME = true;
          forceSSL = true;

          # Or do a redirect instead of the 404, or whatever is appropriate for you.
          # But do not put a Matrix Web client here! See the Riot Web section below.
          locations."/".extraConfig = ''
            return 404;
          '';

          # forward all Matrix API calls to the synapse Matrix homeserver
          locations."/_matrix" = {
            proxyPass = "http://[::1]:8008"; # without a trailing /
          };
        };
      };
    };
    openssh = {
      enable = true;
      permitRootLogin = "yes";

      passwordAuthentication = false;
      challengeResponseAuthentication = false;
    };
  };

  users.users."iaz" = {
    isNormalUser = true;
    description = "Isaac Azuelos";
    extraGroups = [ "wheel" ];
    home = "/home/iaz";
    shell = pkgs.fish;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}

