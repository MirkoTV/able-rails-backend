require 'rails_helper'

RSpec.describe Session, type: :model do
  describe ".current" do
    context "with an active session" do
      before do
        Session.create(name: "Test 1", active_at: Time.now)
        Session.create(name: "Test 2")
      end

      it "should retrieve the active or most recent session" do
        expect(Session.current).to eq(Session.find_by(name: "Test 1"))
      end
    end

    context "with no active sessions" do
      before do
        Session.create(name: "Test 1")
        Session.create(name: "Test 2")
      end

      it "should retrieve the most recent session" do
        expect(Session.current).to eq(Session.find_by(name: "Test 2"))
      end
    end
  end
end
