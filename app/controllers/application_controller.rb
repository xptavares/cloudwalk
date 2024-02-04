class ApplicationController < ActionController::API
  def protect_request(key, &block)
    if RequestStore.items[key]
      render json: { status: 422, message: 'to many transactions' }
      return
    end

    RequestStore.items[key] = true
    block.call if block
    RequestStore.items[key] = false
  end
end
