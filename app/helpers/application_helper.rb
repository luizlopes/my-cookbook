module ApplicationHelper
  def user_present(user)
    UserPresenter.new(user)
  end
end
