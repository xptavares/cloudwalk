class Transaction::ValidateScoreService

  attr_accessor :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def perform
    return false unless validate
    true
  end

  private
    def current_user
      @current_user ||= User.find_by(id: user_id)
    end

    def validate
      current_user.A? || current_user.B?
    end
end
