# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Santo_Domingo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sircam = {
    isNormalUser = true;
    description = "Cristian J. Hidalgo";
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "sircam";

  # Enable CoolerControl
  programs.coolercontrol.enable = true;
  programs.coolercontrol.nvidiaSupport = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;

  [
      htop
      devenv
      libvirt
      fastfetch
      kdePackages.kcalc
      kdePackages.yakuake
      kdePackages.filelight
      kdePackages.kolourpaint
  ];

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable virtualisation
  virtualisation.libvirtd.enable = true;

  # Enable Flatpak (Discover usage)
  services.flatpak.enable = true;

   # Disable password prompt in terminal
  security.sudo.extraRules = [
    {
      users = [ "sircam" ];
      commands = [
        {
          command = "ALL";
          options = [ "SETENV" "NOPASSWD" ];
        }
      ];
    }
  ];

# Enable graphics stack
hardware.graphics.enable = true;

# Enable proprietary NVIDIA driver with modesetting
hardware.nvidia = {
  modesetting.enable = true;
  nvidiaSettings = true;
  open = false;  # Use proprietary driver, not open-source kernel module
  package = config.boot.kernelPackages.nvidiaPackages.stable;
};

# Enable X server with NVIDIA driver
services.xserver = {
  enable = true;
  videoDrivers = [ "nvidia" ];
};

# Enable OpenGL and DRI support
hardware.opengl = {
  enable = true;
};

# Environment variables for Wayland or X11
environment.sessionVariables = {
  GBM_BACKEND = "nvidia-drm";
  LIBVA_DRIVER_NAME = "nvidia";
  XDG_SESSION_TYPE = "wayland"; # or "x11" if not using Wayland
};

# Accept NVIDIA license
nixpkgs.config.nvidia.acceptLicense = true;

 # Enable AMD CPU microcode updates for stability and performance
  hardware.cpu.amd.updateMicrocode = true;

  # Enable thermald for dynamic thermal management (good for desktops)
  services.thermald.enable = true;

  # Enable TLP for advanced power management, desktop-optimized
  services.tlp.enable = true;

  # TLP settings optimized for desktop (no battery-specific tuning)
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "schedutil";      # Balanced performance and efficiency
    CPU_BOOST_ON_AC = 0;                            # Disable CPU boost to reduce heat
    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power"; # Favor power saving while maintaining performance
  };

  # Disable power-profiles-daemon to avoid conflicts with TLP
  services.power-profiles-daemon.enable = false;

  # Enable powerManagement for Powertop tuning; disable CPU governor management to avoid conflicts
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = null;
  powerManagement.powertop.enable = true;

  # Disable automatic suspend and hibernation on desktop to prevent unwanted sleep
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

    # Play Steam games locally
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "steam" "steam-unwrapped" ];

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true;        # For Steam Remote Play
  dedicatedServer.openFirewall = true;   # For Source Dedicated Server hosting
  localNetworkGameTransfers.openFirewall = true;  # For LAN transfers
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
