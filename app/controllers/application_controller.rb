class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def set_locale
  	I18n.locale = extract_locale_from_accept_language_header || I18n.default
  end

  private
    def extract_locale_from_accept_language_header
  	  http_accept_language.compatible_language_from(I18n.available_locales)  	
    end
end
