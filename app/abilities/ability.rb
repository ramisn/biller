class Ability
  include CanCan::Ability
  
  def initialize(user = nil)
    return unless user
    can :manage, :all
  end
end