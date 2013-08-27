json.array!(@pages) do |page|
  json.extract! page, :page_id, :name, :link, :category, :likes, :unread_message_count, :unread_notif_count, :unread_message_count
  json.url page_url(page, format: :json)
end
