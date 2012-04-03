class MultipleWordsValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    unless value.strip =~ /\s/
      record.errors[attribute] = "it is not multiple words "
    end
  end
end

class Project < ActiveRecord::Base
  
  has_many :tasks
  has_many :users
  has_and_belongs_to_many :tags
  
  
  validates_length_of :name,:minimum => 4,
           :message => "should be longer!"
      
  validates_presence_of :desciption, :due
  validates_inclusion_of :priority, :in => 1..5  

  has_attached_file :image


  PRIORITY_NAMES= {
    1 => "Very High",
    2 => "High",
    3 => "Medium",
    4 => "Low",
    5 => "Very Low"
  }
  def priority_name 
    PRIORITY_NAMES[priority]
  end

  def self.priority_name_options
    PRIORITY_NAMES.to_a.sort
  end
  
  def to_s
    name
  end
  
end


