require 'rails_helper'

RSpec.describe Admin, type: :model do

   subject(:admin) { FactoryGirl.create(:admin) }

 end

 describe Admin do
   it { should validate_presence_of(:email) }
   it { should validate_presence_of(:username)}
   it { should validate_presence_of(:password)}
 end
