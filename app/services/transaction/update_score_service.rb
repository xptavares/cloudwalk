class Transaction::UpdateScoreService

  attr_accessor :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def perform
    return false unless validate
    sharing_device
    true
  end

  private
    def current_user
      @current_user ||= User.find_by(id: user_id)
    end

    def validate
      user_id
    end

    def sharing_device
      count = max_count_device_in_use
      return if count <= 1
      return try_update_to_B if count == 2
      return try_update_to_C if count == 3
      try_update_to_E
    end

    def max_count_device_in_use
      ids = current_user.devices.map(&:id)
      counts = ids.map { |id| Device.where(id: id).count }
      counts.max || 0
    end
    

    def try_update_to_B
      current_user.B! if current_user.A?
    end

    def try_update_to_C
      current_user.C! if current_user.A? || current_user.B?
    end

    def try_update_to_E
      current_user.E!
    end
end
