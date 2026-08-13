project(
  'io.github.ryonakano.panel.terminal',
  'vala', 'c',
  version: '0.1.0',
  meson_version: '>= 0.58.0',
)

add_project_arguments(
  '-DG_LOG_DOMAIN="@0@"'.format(meson.project_name()),
  language: 'c',
)

subdir('protocol')
subdir('src')
