require 'rails_helper'

RSpec.describe Team, type: :model do
  describe ".is_complete?" do
    context "if the team has no drivers" do
      let(:team) { Team.create(name: "Able") }

      it "should raise an error" do
        expect { team.is_complete? }.to raise_error(NoDriversError)
      end
    end

    context "if the team has only one driver" do
      let(:team) do
        team = Team.create(name: "Able")
        team.drivers.create(number: 1, ui_name: ["TES"])
        team
      end

      it "should return false" do
        expect(team.is_complete?).to eq(false)
      end
    end

    context "if the team has two drivers" do
      let(:team) do
        team = Team.create(name: "Able")
        team.drivers.create(number: 1, ui_name: ["TES"])
        team.drivers.create(number: 2, ui_name: ["TST"])
        team
      end

      it "should return true" do
        expect(team.is_complete?).to eq(true)
      end
    end

    context "if the team has more than two driver" do
      let(:team) do
        team = Team.create(name: "Able")
        team.drivers.create(number: 1, ui_name: ["TES"])
        team.drivers.create(number: 2, ui_name: ["TST"])
        team.drivers.create(number: 3, ui_name: ["EST"])
        team
      end

      fit "should raise an error" do
        expect { team.is_complete? }.to raise_error(TooManyDriversError)
      end
    end
  end
end
