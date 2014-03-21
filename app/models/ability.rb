class Ability
  include CanCan::Ability

=begin
can accepts 2 arguments
    1st is the action, 2nd is the model class u want to perform action on - "all" would accept all models
=end

  def initialize(user)
    # if no login has been done, ie. user object is nil:
    user  ||= User.new # creates user so can use methods like .role?

     can :read, :all
=begin
- this code was giving problems since there is no "role?" method for user
    if user.role? :admin
        can :manage, :all
    else
        can :read, :all
    end
=end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
