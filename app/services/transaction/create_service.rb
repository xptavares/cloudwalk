class Transaction::CreateService

  attr_accessor :params

  def initialize(params)
    @params = params
  end
  

  def perform
    { transaction_id: '2342357', recommendation: 'approve' }
  end
end
