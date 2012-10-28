class Setting < ActiveRecord::Base
   attr_accessible :scope, :configuration_settings
   store :configuration_settings, accessors: [:email,:subscribed, :max_emails_per_day, :clickthrough_rate]
   validates_presence_of :scope, :email, :subscribed, :max_emails_per_day, :clickthrough_rate
   validates_format_of :email, :with => /^.+@.+$/
   validates :subscribed, :inclusion => {:in => [0,1]}
   validates :max_emails_per_day, numericality: { only_integer: true }
   validate :is_clickthrough_rate_float?


   def is_clickthrough_rate_float?
     errors.add(:clickthrough_rate, 'Not a Float') unless self.clickthrough_rate.is_a?(Float)
   end


end
