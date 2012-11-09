class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.super_admin
    user.permissions.each do |permission|
      can permission.action.to_sym, permission.subject_class.constantize
    end
  end
end
