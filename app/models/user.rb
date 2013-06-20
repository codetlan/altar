class User < ActiveRecord::Base  
  has_many :products
  belongs_to :workshop
  before_create :set_role  
  # has_many :authentications, :dependent => :delete_all 
  
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :gender,
    :bio, :name, :interview, :avatar , :role, :workshop_id, :current_password, :address
  # attr_accessible :title, :body
  
  mount_uploader :avatar, AvatarUploader 
  mount_uploader :interview, InterviewUploader
  
  def set_role
    self.role = 'User'
  end

  acts_as_commentable
  acts_as_votable

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    # user = User.where(:provider => auth.provider, :uid => auth.uid).first
    user = User.where(:email => auth.info.email).first
    
    puts auth.info.to_yaml
    puts "--------------------"
    puts auth.extra.raw_info.to_yaml

    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           # provider:auth.provider,
                           # uid:auth.uid,
                           avatar:auth.info.image,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
      user.remote_avatar_url =  auth.info.image
      user.save
    end    
    user
  end

end
