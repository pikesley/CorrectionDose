class GlucoseMeasurement < ActiveRecord::Base
  def self.short_name
    'Glucose'
  end

  def self.fields
    [
      'value'
    ]
  end

  validates :datetime, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates_uniqueness_of :datetime
end
