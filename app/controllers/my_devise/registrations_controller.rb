class MyDevise::RegistrationsController < Devise::RegistrationsController

# want to override default Devise create method so can delete
	# the temp Membership and associated temp Individual
# POST /resource
#------------------------------------------------------------------------------
	  def create
	    build_resource(sign_up_params)
	    resource_saved = resource.save
	    yield resource if block_given?
	    if resource_saved

	    	#---------------- CURRENT PROBLEM
=begin
	
below only replaces 1 indiv id but when Admin or OrgUser types in email
	he/she creates multiple individuals so multipl indiv ids are created for the same email
=end
			# below is to get tempIndiv with email given during Sign Up
			indiv_Objects = Individual.where(f_name: @user.email)
			indiv_ids = []
			membership_ids = []
			indiv_Objects.each do |indiv|
				indiv_ids << indiv.id
			end
			indiv_ids.each do |indiv_id|
				membership_ids << Membership.find_by(individual_id: indiv_id).id
			end
			# By here should have populated indiv_ids and membership_ids
			
			# Note 1: membership_ids and indiv_ids should be the same size because I made it so in the Org
				# show page that a new Membership and Indiv is created (thus a new Indiv id created for each new Indiv)
			# Note 2: where returns Active Record relation (basically an array) even if there is only 1 object 
				# that meets the criteria, BUT find_by always returns the single object itself
			indiv_ids.each do |indiv_id|
				Individual.delete(indiv_id)
			end
			# now here I should have deleted all temp Indivs, so now there are Membership objects with
				# their individual_id foreign keys pointing to a nil object
			
			# Below is where I go through my mem_ids, find the Membership with that id, 
				# assign that membership to the id of the Individual that just signed up
			indiv_of_new_user = resource.individual.id
			membership_ids.each do |m_id|
				@m = Membership.find_by_id(m_id)
				@m.individual_id = indiv_of_new_user
				@m.save
			end

	      if resource.active_for_authentication?
	        set_flash_message :notice, :signed_up if is_flashing_format?
	        sign_up(resource_name, resource)
	        respond_with resource, location: after_sign_up_path_for(resource)
	      else
	        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
	        expire_data_after_sign_in!
	        respond_with resource, location: after_inactive_sign_up_path_for(resource)
	      end
	    else
	      clean_up_passwords resource
	      respond_with resource
	    end

	  end

	 private
	 def user_params
	 	params.require(:user).permit(:email, :password, :password_confirmation, :encrypted_password, :salt, {individual_attributes: [:f_name, :l_name, :role, :active]})
	 end
end