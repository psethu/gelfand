class Organization < ActiveRecord::Base

    # Relationships
    # ------------- 
    has_one :contact
    has_many :affiliations
    has_many :programs, through: :affiliations
    has_many :org_users
    has_many :users, through: :org_users
    has_many :memberships
    has_many :individuals, through: :memberships

  # Scopes
  scope :alphabetical, order('name')
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)

  # Validations
  validates_presence_of :name, :description, :department
  validates_uniqueness_of :name
  validates_format_of :department, :with => /^[ a-zA-Z]+$/, :multiline => true, 
  									:message => "Can only contain alphabetical characters, lower or uppercase"
  #validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"

end
