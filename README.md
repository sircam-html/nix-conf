# NixOS Configuration Summary: 
This NixOS configuration provides a robust, desktop-focused setup optimized for both performance and convenience, particularly on systems with AMD CPUs and NVIDIA GPUs.


# Key Features:


# Hardware Integration
• Environment variables are set for optimal NVIDIA support in both Wayland and X11 sessions.
• Hardware-specific settings are imported from hardware-configuration.nix, which is automatically generated to match your system's devices and should not be edited manually.  

• Proprietary NVIDIA drivers are enabled for optimal graphics performance, with 32-bit library support for gaming and multimedia.  AMD CPU microcode updates are activated to ensure stability and best performance.

 # Cooler and Fan Control   
 • CoolerControl with NVIDIA support is enabled for advanced fan management.  

# Boot and System
• Uses systemd-boot as the bootloader with EFI support. 
• Boot splash via Plymouth for a polished startup experience.  

# Virtualization and Gaming      
• Virtualization enabled via libvirtd and QEMU support.  
• Steam enabled with open firewall for Remote Play and LAN transfers, and unfree packages allowed for gaming. 

 # Power and Thermal Management 
• TLP and Thermald are enabled for advanced power and thermal management, with settings optimized for desktop usage.
• Power-profiles-daemon is disabled to avoid conflicts. 
• Automatic suspend and hibernation are disabled to prevent unwanted sleep on desktop systems.

# System Maintenance
• Automatic garbage collection (GC) and store optimization are scheduled daily to keep the system clean.  
• Nix Flakes and the new nix command are enabled for advanced package and configuration management. 

# Security and Convenience 
• Sudo is configured for passwordless access in the terminal for the main user. 
• Flatpak is enabled for access to a wide range of desktop applications.  


System Version:

    Configured for NixOS 25.05.
    

Personally i do not recommend to copy and paste an entire configuration.  Study, analyze, pick what you need it and paste to your configuration.

In the case you ignore this warning, by default this particular system will always boot and login to desktop without password prompts.

Repo mirror: [Gitlab](https://gitlab.com/S1RCAM/personal-nix-configuration)
