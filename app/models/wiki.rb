class Wiki < ActiveRecord::Base
  belongs_to :user

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: { minimum: 6 }, presence: true
  validates :user, presence: true

  # scope :visible_to, -> (user) do
  #   return all if user.premium? || user.admin?
  #   where(private: [false, nil])
  # end

end
