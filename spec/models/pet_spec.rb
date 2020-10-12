require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "realtionships" do
    it {should belong_to :shelter}
  end
end
