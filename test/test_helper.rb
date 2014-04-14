ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Prof. H's deny method to improve readability of tests
  def deny(condition, msg="")
    # a simple transformation to increase readability IMO
    assert !condition, msg
  end

  def create_individual_context
  	#Populate db
  	@standard = FactoryGirl.create(:individual)
  	@alvin = FactoryGirl.create(:individual, f_name: 'Alvin', l_name: 'Chipmunk')
  	@dave = FactoryGirl.create(:individual, f_name: 'Dave', l_name: 'Peterson', role: 1)
  	@max = FactoryGirl.create(:individual, f_name: 'Max', l_name: 'Payne', role: 2)
  	@zena = FactoryGirl.create(:individual, f_name: 'Zena', l_name: 'Atwell')

  	#Lists for verification
  	@alphabetical_by_last = ['Zena', 'Alvin', 'John', 'Max', 'Dave']
  	@alphabetical_by_first = ['Alvin', 'Dave', 'John', 'Max', 'Zena']
    @students_only = ['Zena', 'Alvin', 'John']
    @faculty_only = ['Dave']
    @off_campus_only = ['Max']
  end

  def remove_individual_context
  	@standard.delete
  	@alvin.delete
  	@dave.delete
  	@max.delete
  	@zena.delete
  end

  def create_organization_context
  	@standard = FactoryGirl.create(:organization)
  	@scotch = FactoryGirl.create(:organization, name: "Scotch'n'Soda", description: "A student-run theatre troupe")
  	@civE = FactoryGirl.create(:organization, name: "Civil Engineering", description: "The Civil Engineering Department at Carnegie Mellon", department: "CIT")
  	@partner = FactoryGirl.create(:organization, name: "Pittsburgh Public Schools", description: "Public Schooling in Allegheny County", is_partner: true, department: "OffCampus")
    @inactive = FactoryGirl.create(:organization, name: "Inactive Org", description: "Mortem est.", department:"The Olde KGB", active: false)
  	@alpha_list = ["Civil Engineering", "Fringe", "Pittsburgh Public Schools", "Scotch'n'Soda"]
    @non_partners_list = ["Civil Engineering", "Fringe", "Scotch'n'Soda"]
    @partners_list = ["Pittsburgh Public Schools"]
    @inactive_orgs = ["Inactive Org"]
  end

  def remove_organization_context
  	@standard.delete
  	@scotch.delete
  	@civE.delete
  	@partner.delete
  end

end
