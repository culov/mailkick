module Mailkick
  class Engine < ::Rails::Engine
    isolate_namespace Mailkick

    initializer "mailkick" do |app|
      Mailkick.discover_services unless Mailkick.services.any?

      Mailkick.secret_token ||= begin
        # Use credentials if available
        if app.respond_to?(:credentials) && app.credentials.secret_key_base
          app.credentials.secret_key_base
        # Fallback to Rails.application.secret_key_base
        else
          Rails.application.secret_key_base
        end
      end
    end
  end
end