class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # test用
  # has_secure_password の内部実装参考
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
