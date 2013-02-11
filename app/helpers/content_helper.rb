module ContentHelper
  def resource_name
    :student
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:student]
  end
end
