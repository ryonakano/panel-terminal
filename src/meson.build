sources = [
  'Indicator.vala',
  'TerminalWindow.vala',
]

prefix = get_option('prefix')
libdir = prefix / get_option('libdir')

wingpanel_dep = dependency('wingpanel-9')
indicatorsdir = wingpanel_dep.get_variable('indicatorsdir', pkgconfig_define: ['libdir', libdir])

shared_module(
  'terminal-indicator',
  sources,
  dependencies: [
    dependency('granite-7'),
    dependency('gtk4'),
    dependency('gtk4-wayland'),
    dependency('vte-2.91-gtk4', version: '>= 0.48'),
    dependency('wayland-client'),
    pantheon_desktop_shell_dep,
    wingpanel_dep,
  ],
  install: true,
  install_dir: indicatorsdir,
)
