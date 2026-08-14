-- Personal input overrides migrated from the pre-Quattro input.conf.
hl.config({
  input = {
    -- Custom UK Macintosh layout from ~/.config/xkb/symbols/gbmac_fixed.
    kb_layout = "gbmac_fixed",
    kb_options = "compose:caps,altwin:swap_lalt_lwin,altwin:swap_ralt_rwin,ctrl:rctrl_ralt",

    repeat_rate = 40,
    repeat_delay = 600,
    numlock_by_default = true,

    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = true,
      scroll_factor = 0.3,
    },
  },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
