module ApplicationHelper

  def format_date(datum)
    if datum == nil
      return ''
    else
      #datum.strftime('%d.%m.%Y')
      return "#{datum.day}.#{datum.month}.#{datum.year}"
    end
  end

  def format_date_time(cas)
    if cas==nil
      return ''
    else
      cas.strftime('%d.%m.%Y %H:%M')
    end
  end

  def allowed_acc(account = nil)
    @accounts = current_user.accounts
    unless account == nil
      @acc = Account.find(account)
      ok = false
      for acount in @accounts do
        ok = true if acount == @acc
      end
    end
    return ok
  end

  def notallowed
    flash[:notice] = "Not allowed."
    redirect_to my_accounts_url
  end

end
