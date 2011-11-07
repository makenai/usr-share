class Authorship < ActiveRecord::Base
  belongs_to :author
  belongs_to :media
  attr_accessible :author_id, :media_id, :author_attributes
  accepts_nested_attributes_for :author
end
