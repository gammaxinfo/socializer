module Socializer
  class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    # FIXME: Not sure why protect_from_forgery is no longer working
    # protect_from_forgery with: :exception

    helper_method :current_user
    helper_method :signed_in?

    before_action :set_locale

    private

    def current_user
      @current_user ||= Person.find_by(id: cookies[:user_id]) if cookies[:user_id].present?
    end

    def signed_in?
      current_user.present?
    end

    def set_locale
      if signed_in? && current_user.language.present? && params[:locale].nil?
        I18n.locale =  current_user.language
      else
        I18n.locale =  params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
      end
    end

    def extract_locale_from_accept_language_header
      if request.present? && request.env['HTTP_ACCEPT_LANGUAGE'].present?
        request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      end
    end
  end
end
