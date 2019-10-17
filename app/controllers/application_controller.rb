class ApplicationController < ActionController::Base
  
  def list_error_messages(rejected_obj)
    msgs = rejected_obj.errors.full_messages
    if msgs
      final_string = ""
      msgs.each_with_index do |msg, index|
        final_string << "#{index+1}: #{msg.capitalize}.  "
      end
      return final_string
    else
      raise ArgumentError, "Your rejected_obj.save was successful..."
    end
  end
  
end
