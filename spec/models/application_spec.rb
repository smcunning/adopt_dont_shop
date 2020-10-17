require 'rails_helper'

describe Application, type: :model do
  describe "relationships" do
    it {should belong_to(:user)}
    it {should have_many(:pet_applications)}
    it {should have_many(:pets).through(:pet_applications)}
  end
end
