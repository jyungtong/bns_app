module ApplicationHelper
	def broadcast(channel, &block)
		message = { channel: channel, data: capture(&block), ext: { auth_token: FAYE_TOKEN } }
    uri = URI.parse("#{APP_CONFIG["faye_url"]}/faye")
		Net::HTTP.post_form(uri, message: message.to_json)
	end

  def greet_message
    "Logged in as #{content_tag :b, user_email}".html_safe
  end

  protected
  def user_email
    return current_student.email if student_signed_in?
    return current_admin.email if admin_signed_in?
    return "Anonymous"
  end
end
