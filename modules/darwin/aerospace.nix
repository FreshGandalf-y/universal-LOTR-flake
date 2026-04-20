{ pkgs, lib, config, ... }:
{
  options.modules.darwin.aerospace = {
    enable = lib.mkEnableOption "aerospace";
  };
  config = lib.mkIf config.modules.darwin.aerospace.enable {
    services.aerospace = {
      enable = true;
      settings = {
        gaps = {
          outer.left = 8;
          outer.bottom = 8;
          outer.top = 8;
          outer.right = 8;
        };
        mode.main.binding = {
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";

          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";

          #moving the windows
          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";

          alt-g = "exec-and-forget open -a 'Ghostty'";
          alt-e = "exec-and-forget open -a 'Emacs'";
          alt-b = "exec-and-forget open -a 'Firefox'";

          alt-f = "fullscreen";

        };
        key-mapping.preset = "qwerty";
        on-focused-monitor-changed = [
          "move-mouse monitor-lazy-center"
        ];
        workspace-to-monitor-force-assignment = {
          "1" = "^built-in retina display";
          "2" = [
            "secondary"
            "2470W"
          ];
        };
      };
    };
  };
}
