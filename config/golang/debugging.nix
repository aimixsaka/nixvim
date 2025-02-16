{pkgs, ...}: {
  plugins.dap.settings.dap-go = {
    enable = true;
    delve.path = "${pkgs.delve}/bin/dlv";
  };
}
