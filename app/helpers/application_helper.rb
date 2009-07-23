# The methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def to_object(object_name)
    instance_variable_get('@' + object_name)
  end

  def collection_value_to_s(collection, selected_value)
    collection.map {|display, value| return display if (value == selected_value)}
  end

  def render_csv
    report = StringIO.new
    CSV::Writer.generate(report, ';') do |csv|
      yield csv
    end
    report.rewind
    return report.read
  end

  def sidebar_hidden?
    session['sidebar_hidden']
  end

  def tip_uplate_to_s(value)
    collection_value_to_s(Izdatak::TIP_UPLATE, value)
  end
  
  def render_custom(options = {}, old_local_assigns = {}, &block)    
    if options[:partial] && @user
      path, partial_name = partial_pieces(options[:partial])
      if file_exists?("custom/#{@user.username}/#{path}/_#{partial_name}")
        partial_path = "custom/#{@user.username}/#{path}/#{partial_name}"
        logger.debug("render_custom - redirecting to partial: #{partial_path}")
        options[:partial] = partial_path
      end
    end  
    render(options, old_local_assigns, &block)
  end
  
  def partial_pieces(partial_path)
    if partial_path.include?('/')
      return File.dirname(partial_path), File.basename(partial_path)
    else
      return controller.class.controller_path, partial_path
    end
  end

end
