require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:justin) { Admin.new({:username => "jtam11", :email => "justinktam@gmail.com", :password => "justin", :confirmed_at => Date.today})}
 it { expect(justin.valid?).to eq(true)}
end

RSpec.describe Admin, type: :model do
  let(:justin) { Admin.new({:username => "jtam11", :email => "justinktamgmail.com", :password => "justin", :confirmed_at => Date.today})}
 it { expect(justin.valid?).to eq(false)}
end
