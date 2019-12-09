module CrudHelpers
  def handle_listing(model, pagination_data, where = {}, order = nil)

    dataset = CrudHelpers.scoped_dataset(model, where)

    modified_since_time = Time.at(pagination_data[:modified_since])
    dataset = dataset.where { system_mtime >= modified_since_time }
    # BEGIN: DTS OVERRIDE
    dataset = order ? dataset.order(*order) : dataset.order(:id)
    # END: DTS OVERRIDE

    if pagination_data[:page]
      # Classic pagination mode
      paginated = dataset.extension(:pagination).paginate(pagination_data[:page], pagination_data[:page_size])

      listing_response(paginated, model)

    elsif pagination_data[:all_ids]
      # Return a JSON array containing all IDs for the matching records
      json_response(dataset.select(:id).map {|rec| rec[:id]})

    elsif pagination_data[:id_set]
      # Return the requested set of IDs
      listing_response(dataset.filter(:id => pagination_data[:id_set]), model)
    end
  end
end
