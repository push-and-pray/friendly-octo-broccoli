{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
with lib; {
  imports = ["${modulesPath}/profiles/qemu-guest.nix"];

  services.openssh = {
    enable = true;

    settings.PermitRootLogin = "prohibit-password";
    settings.PasswordAuthentication = mkDefault false;
  };

  networking = {
    usePredictableInterfaceNames = false;
    useDHCP = false;
    interfaces.eth0 = {
      useDHCP = true;
      tempAddress = "disabled";
    };
  };

  # Install diagnostic tools for Linode support
  environment.systemPackages = with pkgs; [
    inetutils
    mtr
    sysstat
  ];

  # Enable LISH and Linode Booting w/ GRUB
  boot = {
    # Add Required Kernel Modules
    # NOTE: These are not documented in the install guide
    initrd.availableKernelModules = [
      "virtio_pci"
      "virtio_scsi"
      "ahci"
      "sd_mod"
    ];

    # Set Up LISH Serial Connection
    kernelParams = ["console=ttyS0,19200n8"];
    kernelModules = ["virtio_net"];

    loader = {
      timeout = lib.mkForce 10;

      grub = {
        enable = true;
        forceInstall = true;
        device = "nodev";

        extraConfig = ''
          serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
          terminal_input serial;
          terminal_output serial
        '';
      };
    };
  };
}
