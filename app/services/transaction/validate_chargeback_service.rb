class Transaction::ValidateChargebackService

  attr_accessor :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def perform
    return false if validate
    true
  end

  private
    def current_user
      @current_user ||= User.find_by(id: user_id)
    end

    def validate
      current_user.try(:has_cbk)
    end
end
