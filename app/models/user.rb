class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  # has_many :wikis, through: :collaborators

  before_save { self.email = email.downcase if email.present? }
  before_save { self.role ||= :standard }

  enum role: [:standard, :premium, :admin,]
  after_initialize :set_defaults, :if => :new_record?

  def set_defaults
    self.role ||= :standard
  end
end
