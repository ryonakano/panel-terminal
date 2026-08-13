/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2011-2026 elementary, Inc. (https://elementary.io)
 *                         2026 Ryo Nakano <ryonakaknock3@gmail.com>
 */

public class TerminalIndicator.TerminalWindow : Gtk.Window {
    public TerminalWindow () {
    }

    construct {
        title = "Terminal";
        default_width = 600;
        default_height = 800;

        var terminal = new Vte.Terminal ();

        try {
            terminal.spawn_async (Vte.PtyFlags.DEFAULT,
                                  null,
                                  { "/bin/bash" },
                                  null,
                                  SpawnFlags.SEARCH_PATH,
                                  null,
                                  -1,
                                  null,
                                  null);

            child = terminal;
        } catch (Error err) {
            warning ("Failed to Vte.Terminal.spawn_async(): %s", err.message);
        }

        ((Gtk.Widget) this).realize.connect (() => Idle.add_once (() => init_wl ()));
    }

    public void registry_handle_global (Wl.Registry wl_registry, uint32 name, string @interface, uint32 version) {
        if (@interface == "io_elementary_pantheon_shell_v1") {
            var desktop_shell = wl_registry.bind<PantheonDesktop.Shell> (name, ref PantheonDesktop.Shell.iface, uint32.min (version, 1));
            unowned var surface = get_surface ();
            if (surface is Gdk.Wayland.Surface) {
                unowned var wl_surface = ((Gdk.Wayland.Surface) surface).get_wl_surface ();
                var extended_behavior = desktop_shell.get_extended_behavior (wl_surface);
                extended_behavior.set_keep_above ();
            }
        }
    }

    private static Wl.RegistryListener registry_listener;
    private void init_wl () {
        registry_listener.global = registry_handle_global;
        unowned var display = Gdk.Display.get_default ();
        if (display is Gdk.Wayland.Display) {
            unowned var wl_display = ((Gdk.Wayland.Display) display).get_wl_display ();
            var wl_registry = wl_display.get_registry ();
            wl_registry.add_listener (
                registry_listener,
                this
            );

            if (wl_display.roundtrip () < 0) {
                return;
            }
        }
    }
}
