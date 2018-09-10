class WikiPolicy < ApplicationPolicy
  def destroy?
    user.role == 'admin' || record.user == user
  end

  def index?
    false
  end

  def show?
    is_authorized?(user,record)
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && is_authorized?(user,record)
  end

  def edit?
    update?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      # if user.admin?
      #   scope.all
      if user.nil?
        wikis = scope.where(private: false)
      elsif user.premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || user = wiki.user || user.admin?
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private || user.admin? || user == wiki.user
            wikis<<wiki
          end
        end
      end
      wikis
      end
    end
  # end

  def is_authorized?(user, record)
    !record.private || user.admin? || user == record.user
  end
end
