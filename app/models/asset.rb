class Asset < ActiveRecord::Base
  mount_uploader :asset, AssetUploader
  belongs_to :ticket
end
