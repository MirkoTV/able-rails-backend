require 'rails_helper'
require 'time_utils'

RSpec.describe TimeUtils do
  describe ".format" do
    it "should convert from milliseconds to readable time" do
      time = 74938
      expect(TimeUtils.format(time)).to eq("1:14.938")
    end

    it "should convert from zero time to DNF" do
      time = 0.0
      expect(TimeUtils.format(time)).to eq("DNF")
    end
  end
end
