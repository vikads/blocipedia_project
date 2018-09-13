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
      if user.nil?
        wikis = scope.where(private: false)
      elsif user.admin?
        wikis =  scope.all # if the user is an admin, show them all the wikis

      elsif user.premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || user == wiki.user || wiki.collaborators.exists?(user_id: user.id)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else #this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private || wiki.collaborators.exists?(user_id: user.id)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end


  def is_authorized?(user, record)
    !record.private || user.admin? || user == record.user || record.collaborators.exists?(user_id: user.id)
  end
end
