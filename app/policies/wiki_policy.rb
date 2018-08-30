class WikiPolicy < ApplicationPolicy
  def destroy?
    user.role == 'admin' || record.user == user
  end

  def index?
    true #(all users can see the index)
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
    edit?
  end

  def edit?
    user.present? && is_authorized?(user,record)
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        return scope.all
      else
        wikis = []
        scope.all.each do |wiki|
          if !wiki.private || user.admin? || user == wiki.user
            wikis.push(wiki)
          end
        end
        wikis
      end
    end
  end

  def is_authorized?(user, record)
    !record.private || user.admin? || user == record.user
  end
end
