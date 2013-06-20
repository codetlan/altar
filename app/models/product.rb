class Product < ActiveRecord::Base
  attr_accessible :description, :name, :photo, :poem, :price, :category_id, :user_id 
  mount_uploader :photo, ProductUploader
  belongs_to :category
  belongs_to :user

  acts_as_commentable
  acts_as_votable

  def self.search(search)
	if search
		puts "-----------"
		puts search
		puts "-----------"
	    # where('name LIKE ?', "%#{search}%")
		Product.scoped(:include => [:user,:category],
      		:conditions => ['(users.name LIKE ? OR categories.name LIKE ? OR products.name LIKE ?)',"%#{search}%","%#{search}%","%#{search}%"]).order('products.created_at DESC')
  	else
	    scoped
	end
  end

 # def publications (user_id, network_id)
 #    Wall.scoped(:include => {
 #          :users => :userpublicationings,
 #          :courses => :coursepublicationings,
 #          :courses => :members_in_courses
 #    },
 #      :conditions => ['(walls.network_id = ?) AND (userpublicationings.user_id = ? OR walls.public = ?) OR (members_in_courses.accepted = ? AND members_in_courses.user_id = ?) ',network_id,user_id,true,true, user_id]).order('walls.created_at DESC')
 #  end
end
