class User < ActiveRecord::Base

    # Relationships
    # ------------- 
    has_many :org_users
    has_many :organizations, through: :org_users
    belongs_to :individual

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
  	admin # this is a boolean that holds a true or false value
  end

  def member?
  	member # this is a boolean that holds a true or false value
  end

  def organizations
    self.organizations
  end

  


end
