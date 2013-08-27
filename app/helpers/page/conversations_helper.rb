module Page::ConversationsHelper


  def display_sender_name_of_latest_msg(msg)
    unless msg.nil?
      msg.sender.name
    else
      "Not exist msg."
    end
  end

  def display_content_of_latest_msg(msg)
    unless msg.nil?
      msg.content
    else
      "Not exist msg."
    end
  end

end
