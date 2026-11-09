---- CURVES ----
hl.curve("wind",   { type = "bezier", points = { -1.05, 0.9, 0.1, 1.05 } })
hl.curve("winIn",  { type = "bezier", points = { -1.1, 1.1, 0.1, 1.1 } })
hl.curve("winOut", { type = "bezier", points = { -1.3, -0.3, 0, 1 } })
hl.curve("liner",  { type = "bezier", points = { 0, 1, 1, 1 } })

---- ANIMATIONS ----
-- Speeds reduced ~40% from original for snappier feel
hl.animation({ leaf = "windows",      enabled = true, speed = 10, bezier = "wind",  style = "slide" })
hl.animation({ leaf = "windowsIn",    enabled = true, speed = 10, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut",   enabled = true, speed = 8,  bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove",  enabled = true, speed = 8,  bezier = "wind",  style = "slide" })
hl.animation({ leaf = "border",       enabled = true, speed = 2,  bezier = "liner" })
hl.animation({ leaf = "fade",         enabled = true, speed = 16, bezier = "default" })
hl.animation({ leaf = "workspaces",   enabled = true, speed = 8,  bezier = "wind" })
