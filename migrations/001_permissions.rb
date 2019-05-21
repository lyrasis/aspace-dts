Sequel.migration do
  up do
    permission = 'dts_only'
    permission_id = self[:permission].filter(
      permission_code: permission
    ).get(:id)

    if permission_id.nil?
      self[:permission].insert(
        permission_code: permission,
        description: 'DTS only',
        level: 'global',
        created_by: 'admin',
        last_modified_by: 'admin',
        create_time: Time.now,
        system_mtime: Time.now,
        user_mtime: Time.now
      )
    end
  end
end
