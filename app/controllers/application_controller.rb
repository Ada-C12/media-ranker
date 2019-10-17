class ApplicationController < ActionController::Base
  
  def list_error_messages(rejected_obj)
    msgs = rejected_obj.errors.full_messages
    if msgs
      msgs_strs_in_array = []
      msgs.each do |msg|
        msgs_strs_in_array << "#{msg.capitalize}"
      end
      return msgs_strs_in_array
    else
      raise ArgumentError, "You Don't need this method! Your #{rejected_obj}.save was successful..."
    end
  end
  
end
