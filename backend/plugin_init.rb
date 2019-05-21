ArchivesSpaceService.loaded_hook do
  ArchivesSpaceService.create_group(
    'dts_group', 'DTS Group', ['admin'], ['dts_only']
  )
end
