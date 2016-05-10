module PersonHelper
  # Returns the gravatar for given user
  def gravatar_for(person)
    gravatar_id = Digest::MD5::hexdigest(person.mail.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: person.name, class: 'gravatar')
  end
end
