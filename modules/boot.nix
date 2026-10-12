{ ... }:
{
  boot.loader.grub = {
    enable = true;
    useOSProber = false;
    timeoutStyle = "menu";
  };

  boot.loader.timeout = 5;

  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=auto"
  ];
}
