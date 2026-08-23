-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = "auto"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- GL.iNet Comet PoE KVM: keep the sharp 1920x1440 4:3 signal while
-- presenting a more comfortable 1536x1152 logical desktop on the 13-inch
-- iPad. The reserved area protects tiled windows from its rounded corners.
hl.monitor({
  output = "desc:GLI GLKVM 891247",
  mode = "preferred",
  position = "auto",
  scale = 1.25,
  reserved_area = 12,
})

-- Round windows only while they are displayed on the GLKVM workspace.
hl.window_rule({
  name = "glkvm-rounded-windows",
  match = { workspace = "m[HDMI-A-1]" },
  rounding = 12,
})

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
