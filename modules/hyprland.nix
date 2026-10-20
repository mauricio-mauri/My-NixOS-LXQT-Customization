{ ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Links estáveis para as GPUs (os nomes card* mudam entre boots).
  # AMD (01:00.0) é a primária; Intel (00:02.0) é o fallback e alimenta a tela do notebook.
  services.udev.extraRules = ''
    SUBSYSTEM=="drm", KERNEL=="card[0-9]*", KERNELS=="0000:01:00.0", SUBSYSTEMS=="pci", SYMLINK+="dri/amd-gpu"
    SUBSYSTEM=="drm", KERNEL=="card[0-9]*", KERNELS=="0000:00:02.0", SUBSYSTEMS=="pci", SYMLINK+="dri/intel-gpu"
  '';

  # Ordem de prioridade das GPUs usadas pelo Hyprland (aquamarine).
  # Sem efeito nas sessões X11/Openbox.
  environment.sessionVariables.AQ_DRM_DEVICES = "/dev/dri/amd-gpu:/dev/dri/intel-gpu";
}
