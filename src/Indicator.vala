/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2011-2026 elementary, Inc. (https://elementary.io)
 *                         2026 Ryo Nakano <ryonakaknock3@gmail.com>
 */

public class TerminalIndicator.Indicator : Wingpanel.Indicator {
    private Gtk.Overlay display_widget;
    private Gtk.Box main_widget;

    public Indicator () {
        Object (
            code_name: "terminal-indicator"
        );
    }

    construct {
        var main_image = new Gtk.Image () {
            icon_name = "utilities-terminal-symbolic",
            pixel_size = 24,
        };

        var overlay_image = new Gtk.Image () {
            pixel_size = 24,
        };

        display_widget = new Gtk.Overlay () {
            child = main_image,
        };
        display_widget.add_overlay (overlay_image);

        var separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL) {
            margin_top = 3,
            margin_bottom = 3,
        };

        var terminal_button = new Wingpanel.PopoverMenuItem.with_text ("Launch Terminal");

        main_widget = new Gtk.Box (VERTICAL, 0);
        main_widget.append (terminal_button);

        terminal_button.clicked.connect (() => {
            var window = new TerminalWindow ();
            window.present ();
        });

        visible = true;
    }

    public override Gtk.Widget get_display_widget () {
        return display_widget;
    }

    public override Gtk.Widget? get_widget () {
        return main_widget;
    }

    public override void opened () {
        // NOP
    }

    public override void closed () {
        // NOP
    }
}

public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
    debug ("Activating Terminal Indicator");

    var indicator = new TerminalIndicator.Indicator ();
    return indicator;
}
