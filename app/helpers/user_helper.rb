module UserHelper
  # Returns the gravatar for given user
  def gravatar_for(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.mail.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url + '/?s=' + size.to_s, alt: user.name, class: 'gravatar')
  end
end
