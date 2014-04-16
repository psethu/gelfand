class Ability
  include CanCan::Ability

=begin
can accepts 2 arguments
    1st is the action, 2nd is the model class u want to perform action on - "all" would accept all models
=end

  def initialize(user)
    # Note: if no login has been done, ie. user object is nil:
# can :read, :all # this is a guest
    
    if user.nil?
      user ||= User.new # guest user (not logged in)
      user.member = false;
      user.admin = false;
    end
#=begin
       if user.admin?
         can :manage, :all
       elsif user.member?
          can :create, :all

          can :update, User do |u|
            u.id == user.id
          end 

          can :show, User do |u|
            u.id == user.id
          end

          can :update, Individual do |i|
            i.id == user.individual_id
          end
          
          can :show, Individual do |i|
            i.id == user.individual_id
          end

          can :show, BgCheck do |b|
            b.id == user.get_bg_check_id
          end


          can :read, Organization
          can :show, Organization

          user.get_org_ids.each do |i|
            can :update, Organization do |o|
              o.id == i
            end
          end

          user.get_admin_prog_ids.each do |i|
            can :update, Program do |p|
              p.id == i
            end
          end




       else
         can :read, :all # this is a guest
       end
#=end

=begin
 Summary: admins can do anything
          members can edit but not destroy
          guests can only see the index page of all other models, but allowed to do nothing else
=end

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
