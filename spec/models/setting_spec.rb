require 'spec_helper'

describe Setting do
  context 'must validate presence of required fields' do
    it { should validate_presence_of(:scope) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:subscribed) }
    it { should validate_presence_of(:max_emails_per_day) }
    it { should validate_presence_of(:clickthrough_rate) }
  end

  context 'must validate format of email' do
    it { should validate_format_of(:email).with(/^.+@.+$/) }
  end

  context 'must validate subscribed can only accept boolean values' do
    it { should ensure_inclusion_of(:subscribed).in_array([0,1]) }
  end
  
  context 'must validate max_emails_per_days is an integer' do
    it { should validate_numericality_of(:max_emails_per_day) }
  end

  context 'must validate clickthrough_rate is a float' do
    it 'should throw error when it is not' do
      setting = Setting.new(:configuration_settings => {:clickthrough_rate => 1})
      setting.send :is_clickthrough_rate_float? #force validation to run
      setting.errors[:clickthrough_rate].should be_present
    end

    it 'should not throw an error when it is' do
      setting = Setting.new(:configuration_settings => {:clickthrough_rate => 1.0})
      setting.send :is_clickthrough_rate_float? #force validation to run
      setting.errors[:clickthrough_rate].should_not be_present
    end

  end
end
