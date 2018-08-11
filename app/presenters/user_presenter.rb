class UserPresenter
  def initialize(user)
    @user = user
  end

  def checkout_partial
    if @user
      @user.admin? ? 'admin' : 'user'
    else
      'visitor'
    end
  end

  def can_edit(recipe)
    @user&.admin? || @user&.eql?(recipe.user)
  end
end
