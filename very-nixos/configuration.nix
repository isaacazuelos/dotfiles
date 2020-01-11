# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let passwords = import ./passwords.nix;
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
    hostName = "very.software";
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

  security.acme.certs = {
    "very.software" = {
      email = "isaac@azuelos.ca";
      group = "matrix-synapse";
      allowKeysForGroup = true;
      postRun =
        "systemctl reload nginx.service; systemctl restart matrix-synapse.service";
    };
  };

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "UTC";

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
    postgresql.enable = true;
    matrix-synapse = {
      enable = true;
      server_name = "very.software";
      registration_shared_secret = passwords.matrixPSK;
      public_baseurl = "https://very.software";
      enable_registration = true;

      tls_certificate_path = "/var/lib/acme/very.software/fullchain.pem";
      tls_private_key_path = "/var/lib/acme/very.software/key.pem";

      listeners = [
        { # federation
          bind_address = "";
          port = 8448;
          resources = [
            {
              compress = true;
              names = [ "client" "webclient" ];
            }
            {
              compress = false;
              names = [ "federation" ];
            }
          ];
          tls = true;
          type = "http";
          x_forwarded = false;
        }
        { # client
          bind_address = "127.0.0.1";
          port = 8008;
          resources = [{
            compress = true;
            names = [ "client" "webclient" ];
          }];
          tls = false;
          type = "http";
          x_forwarded = true;
        }
      ];

    };
    nginx = {
      enable = true;
      virtualHosts = {
        "very.software" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = { proxyPass = "http://localhost:8008"; };
        };
      };
    };
    openssh = {
      enable = true;
      permitRootLogin = "yes";
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
  system.stateVersion = "19.09"; # Did you read the comment?
}

