## NixOS Configuration Overview

💡 Philosophy

- This configuration exemplifies a modern, declarative NixOS desktop setup, balancing performance, usability, and maintainability. It leverages NixOS's modularity and reproducibility, making it easy to adapt or extend for future needs.

## 

## 🖥️ Hardware & Boot   

    Proprietary NVIDIA drivers (with 32-bit support for gaming and multimedia)

    AMD CPU microcode updates for stability and performance

    Plymouth splash screen for a polished boot experience
    

## 🖱️ Desktop Environment

    KDE Plasma 6.3.5 desktop environment

    SDDM display manager with automatic login    

## 🌍 Localization & Networking

    Locale: US English (en_US.UTF-8)    

    Networking: Managed by NetworkManager

    Hostname: nixos
    

## 🔊 Audio

    PipeWire audio stack (with PulseAudio compatibility)

## 👤 User & Software   

    Groups: networkmanager, wheel, qemu-libvirtd, libvirtd

    Pre-installed KDE apps: Kate, KCalc, Yakuake, Filelight, KolourPaint

    Essential tools: htop, devenv, libvirt, fastfetch
    

## 🕹️ Virtualization & Gaming

    Virtualization: Enabled via libvirtd and QEMU

    Steam: Enabled with open firewall for Remote Play, LAN transfers, and Source Dedicated Server hosting

    Unfree packages: Allowed for gaming
    

## 🌡️ Power & Thermal Management

    TLP and Thermald for advanced power and thermal management (desktop-optimized)

    Power-profiles-daemon: Disabled to avoid conflicts

    Suspend/Hibernate: Disabled on desktop systems
    

## 🛠️ System Maintenance

    Automatic garbage collection and store optimization (daily)

    Nix Flakes and new nix command enabled
    

## 🔐 Security & Convenience

    Passwordless sudo in terminal for main user

    Environment variables set for optimal NVIDIA support (Wayland/X11)

    Flatpak enabled for a wider range of desktop apps
    
    

 ## 📁 Structure

    configuration.nix: Main system configuration (this file)

    hardware-configuration.nix: Auto-generated hardware settings


## ❄️ Cooler & Fan Control

    CoolerControl with NVIDIA support for advanced fan management
    

## 📝 System Version

    NixOS: 25.05 

##

## 🔗 Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Wiki](https://nixos.wiki/)
- [KDE Plasma](https://kde.org/plasma-desktop/)
- [CoolerControl](https://github.com/codifryed/coolercontrol)


Adapt and learn! 🚀

Repo mirror: [Gitlab](https://gitlab.com/S1RCAM/personal-nix-configuration)
