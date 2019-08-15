class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record == user || user.admin
  end

  def dashboard?
    # raise
    record == user || user.admin
  end
end
