class Event < ActiveRecord::Base
  validates_presence_of :name, :data
  validates_uniqueness_of :name
  
  validate :data_is_json, unless: ->{ self.data.nil? }
  after_validation :prettyup, if: -> { data.is_json? }
  
  def data_is_json
    errors[:data] << "not in json format" unless data.is_json?
  end
  
  def prettyup
    self.data = JSON.pretty_generate(JSON.parse(self.data))
  end
  
  def as_json(options={})
    JSON.parse(self.data).merge(id: id, name: name)
  end
end
