require_relative 'lib/crud_helpers_override'

ArchivesSpaceService.loaded_hook do
  ArchivesSpaceService.create_group(
    'dts_group', 'DTS Group', ['admin'], ['dts_only']
  )
end
