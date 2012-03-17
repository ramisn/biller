module TableHelper
  ##
  # Provide a link for sorting a column.
  #
  # @param  <String> label The string that is displayed
  # @param  <String> key The sort field
  # @param  <String|Symbol> default_direction Either :asc or :desc
  # @return <String> An Anchor tag that allows the user to sort the column
  def sortable_header(label, key, default_direction = nil)
    default_dir_arg = default_direction
    default_direction ||= :asc
    values = params.dup
    values[:sort] = key
    values[:sort_dir] = default_direction

    classes = [:sortable]

    if params[:sort].to_s == key.to_s
      if params[:sort_dir].blank? || params[:sort_dir].to_s == default_direction.to_s
        values[:sort_dir] = params[:sort_dir].to_s == "asc" ? "desc" : "asc"
      end

      classes << values[:sort_dir]
    elsif default_dir_arg
      classes << default_dir_arg
    else
      classes << :unsorted
    end

    content_tag :a, label, :href => url_for(values), :id => "sort-by-#{key.to_s}-link", :class => classes
  end
end