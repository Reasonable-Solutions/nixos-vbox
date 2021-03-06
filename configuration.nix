# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let myemacs = import ./emacs.nix { inherit pkgs;};
    all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
    unstableTarball = fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
    ghcs = with pkgs; [haskell.compiler.ghc844 haskell.compiler.ghc822 haskell.compiler.ghc864];
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

nix = {
  binaryCaches = [
    "https://cache.nixos.org/"
    "https://nixcache.reflex-frp.org"
  ];
  binaryCachePublicKeys = [
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
  ];
  trustedUsers = [ "root" "carl" ];
  };

nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

# fix always failing fsck on virtualbox
boot.initrd.checkJournalingFS = false;

# add virtualbox additions
virtualisation.virtualbox.host.enableHardening = false;
virtualisation.virtualbox.guest.enable = true;
nixpkgs.config.virtualbox.enableExtensionPack = true;

nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     cabal2nix
     hicolor_icon_theme ## this is a thing emacs complains about not finding?
     darcs
     evince
     wget
     ripgrep
     vim
     alacritty
     tmux
     dmenu
     unstable.racket
     git
     jq
     dhall-json
     firefox
     unstable.chromium
     silver-searcher
     sqlite
    (all-hies.selection { selector = p: { inherit (p) ghc864 ghc863 ghc843; }; })
     unstable.alacritty
     myemacs
     unstable.ghc
     unstable.cabal-install

   ] ++ ghcs;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
    programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.compton.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

networking.interfaces.enp0s8.ipv4.addresses = [ { address = "192.168.56.14"; prefixLength = 24; } ];
networking.extraHosts = "192.168.56.1 winwin";

services.xserver = {
  enable = true;
  layout = "us";
    dpi = 180;
    windowManager = {
      xmonad.enable = true;
      xmonad.enableContribAndExtras = true;
    };
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
};

 users.extraUsers.carl = {
    isNormalUser = true;
    home = "/home/carl";
    extraGroups = ["docker" "lp" "vboxfs" "wheel" "networkmanager" "vboxusers"];

    packages = with pkgs; [
      xclip
    ];
};

 fonts.fonts = with pkgs; [ source-code-pro
    iosevka
    fira-code
    dejavu_fonts
    emacs-all-the-icons-fonts
];
  services.redshift.enable = true;
  services.redshift.latitude = "59.911491";
  services.redshift.longitude = "10.757933";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
