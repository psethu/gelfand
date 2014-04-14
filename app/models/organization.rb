class Organization < ActiveRecord::Base

    # Relationships
    # ------------- 
    belongs_to :contact
    has_many :affiliations
    has_many :programs, through: :affiliations
    has_many :org_users
    has_many :users, through: :org_users
    has_many :memberships
    has_many :individuals, through: :memberships

  # Scopes
  default_scope { where(active: true) }
  scope :alphabetical, -> { order('name') }
  scope :cmu_orgs, -> { where(is_partner: false) }
  scope :partner_orgs, -> { where(is_partner: true) }
  scope :inactive, -> { where(active: false) }

  # Validations
  validates_presence_of :name, :description, :department
  validates_uniqueness_of :name

  # This doesn't work.
  #validates_format_of :department, :with => /\A[\w]+\Z/i, :multiline => true, :message => "Can only contain alphabetical characters, lower or uppercase"
  #validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"

end
