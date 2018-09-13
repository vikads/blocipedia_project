class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: { minimum: 6 }, presence: true
  validates :user, presence: true

  # scope :visible_to, -> (user) do
  #   return all if user.premium? || user.admin?
  #   where(private: [false, nil])
  # end

end
