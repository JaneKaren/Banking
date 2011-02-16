class ApplicationController < ActionController::Base
  include ControllerAuthentication
  helper :all # include all helpers, all the time JUST IN VIEWS! NOT CONTROLLERS
  include ApplicationHelper # to use it in controllers
  include HogwartsHelper

  before_filter :login_required
  before_filter :zapis_uzivatele_do_logu

  protect_from_forgery

  PER_PAGE = 20

  helper_method :admin?  #aby to slo pouzit i ve view
  def admin?
    return false if current_user.blank?
    current_user.admin?
  end

  def zapis_uzivatele_do_logu
    logger.info("\n-----------------------------------------------------\nV #{format_date_time(Time.now)}  provadi uzivatel #{(current_user.blank? ? request.env['REMOTE_HOST'] : current_user.username)}, kontroler #{params[:controller]}::#{params[:action]} id=#{params[:id]} akce=#{params[:akce]}\n-----------------------------------------------------\n ")
  end
end
