class ActionView::Base
  @@field_error_proc = Proc.new{ |html_tag, instance| "<span class=\"error\">#{html_tag}</span>" } 
end

module ActionView
  module Helpers
    module FormTagHelper
    private
      def extra_tags_for_form(html_options)
        case method = html_options.delete("method").to_s
        when /^get$/i # must be case-insentive, but can't use downcase as might be nil
          html_options["method"] = "get"
          ''
        when /^post$/i, "", nil
          html_options["method"] = "post"
          protect_against_forgery? ? content_tag(:fieldset, token_tag, :class => 'hidden') : ''
        else
          html_options["method"] = "post"
          content_tag(:fieldset, tag(:input, :type => "hidden", :name => "_method", :value => method) + token_tag, :class => 'hidden')
        end
      end
    end

    module FormOptionsHelper
      def option_groups_from_collection_for_select(collection, group_method, group_label_method, option_key_method, option_value_method, selected_key = nil)
        collection.inject("") do |options_for_select, group|
          group_label_string = eval("group.#{group_label_method}")
          
          options =  options_from_collection_for_select(eval("group.#{group_method}"), option_key_method, option_value_method, selected_key)
          
          if options != ""
            options_for_select += "<optgroup label=\"#{html_escape(group_label_string)}\">"
            options_for_select += options
            options_for_select += '</optgroup>'
          end
          
          options_for_select
        end
      end
    end
  end
end


