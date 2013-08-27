Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, "300675606745815", "8243d8c845f5961ad8c142e8f8186ed9",
           :scope => 'email,user_birthday,read_stream,read_page_mailboxes'

end
