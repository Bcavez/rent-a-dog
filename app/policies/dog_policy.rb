class DogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  def show?
    true
  end

  def preview?
    true
  end

  private

  def user_is_owner_or_admin?
   record.owner == user || user.admin
  end
end
