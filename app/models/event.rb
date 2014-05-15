class Event < ActiveRecord::Base
  validates_presence_of :name, :data
  validates_uniqueness_of :name
  
  validate :data_is_json, unless: ->{ self.data.nil? }
  
  def data_is_json
    errors[:data] << "not in json format" unless data.is_json?
  end
end
