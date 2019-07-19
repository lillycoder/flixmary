Rails.configuration.strip = {
  publishable_key: ENV["PUBLISHABLE_KEY"],
  secret_key: ENV["SECRET_KEY"]
}

Stripe.api_key = Rails.configuration.strip[:secret_key]