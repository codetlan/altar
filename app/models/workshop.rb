class Workshop < ActiveRecord::Base
  attr_accessible :address, :video, :name, :wall
  mount_uploader :video, WorkshopUploader 
  mount_uploader :wall, WallWorkshopUploader
  has_many :users
end
