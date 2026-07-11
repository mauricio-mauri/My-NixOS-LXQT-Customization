#!/usr/bin/env bash
# MangoWM Keybind Reference
# Launched via SUPER+F1

cat << 'EOF'

  ╔══════════════════════════════════════════════╗
  ║           MANGO WM — KEYBINDS                ║
  ╚══════════════════════════════════════════════╝

  DMS Launchers
  ─────────────────────────────────────────────
  Super + Space         Spotlight
  Super + V             Clipboard
  Super + M             Process List
  Super + ,             Settings
  Super + N             Notifications
  Super + Y             Wallpaper
  Super + Alt + L       Lock Screen

  General
  ─────────────────────────────────────────────
  Alt + Return          Terminal
  Alt + Q               Kill Client
  Super + R             Reload Config
  Super + F1            This Help

  Window Focus
  ─────────────────────────────────────────────
  Super + Tab           Next Window
  Alt + Arrow           Move Focus
  Alt + Tab             Jump Window

  Window Management
  ─────────────────────────────────────────────
  Super + Shift + Arr   Swap Window
  Alt + Backslash       Toggle Floating
  Alt + A               Toggle Maximize
  Alt + F               Toggle Fullscreen
  Alt + Shift + F       Fake Fullscreen
  Super + G             Toggle Global
  Super + I             Minimize
  Super + Shift + I     Restore Minimized
  Super + O             Toggle Overlay
  Alt + Z               Scratchpad

  Layout & Tags
  ─────────────────────────────────────────────
  Super + N             Switch Layout
  Super + Arrow         Switch Tag
  Ctrl + Arrow          Tag with Client
  Ctrl + Super + Arr    Move Tag
  Ctrl + 1-9            View Tag
  Alt + 1-9             Send to Tag

  Monitor
  ─────────────────────────────────────────────
  Alt + Shift + Arrow   Focus Monitor
  Super + Alt + Arrow   Move to Monitor

  Gaps
  ─────────────────────────────────────────────
  Alt + Shift + X       Increase Gaps
  Alt + Shift + Z       Decrease Gaps
  Alt + Shift + R       Toggle Gaps

  Move/Resize
  ─────────────────────────────────────────────
  Ctrl + Shift + Arr    Move Window
  Ctrl + Alt + Arr      Resize Window
  Super + LMB           Move Window
  Super + RMB           Resize Window
  Middle Click          Toggle Maximize

  Media
  ─────────────────────────────────────────────
  Audio Raise/Lower     Volume
  Audio Mute            Mute
  Brightness Up/Down    Screen Brightness

EOF

echo ""
read -n 1 -s -r -p "  Press any key to close..."
echo ""
