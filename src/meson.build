sources = [
  'Indicator.vala',
]

prefix = get_option('prefix')
libdir = prefix / get_option('libdir')

indicatorsdir = wingpanel_dep.get_variable('indicatorsdir', pkgconfig_define: ['libdir', libdir])

shared_module(
  'terminal-indicator',
  sources,
  dependencies: [
    dependency('granite-7'),
    dependency('gtk4'),
    dependency('wingpanel-9'),
  ],
  install: true,
  install_dir: indicatorsdir,
)
