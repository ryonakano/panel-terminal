# Terminal Indicator
## Building and Installation
You'll need the following dependencies:

* libgranite-7-dev
* libgtk-4-dev
* libvte-2.91-gtk4-dev (>= 0.48)
* libwingpanel-9-dev
* meson
* valac

Run `meson setup` to configure the build environment and run `meson compile` to build:

```bash
meson setup builddir --prefix=/usr
meson compile -C builddir
```

To install, use `meson install`:

```bash
meson install -C builddir
```
