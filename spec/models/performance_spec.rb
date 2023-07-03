require 'rails_helper'

RSpec.describe Performance, type: :model do
  let(:team) { Team.create(name: "Able") }
  let(:driver) { team.drivers.create(ui_name: "TST", number: 1) }
  let(:session) { Session.create(name: "Able GP") }

  describe "#has_valid_times?" do
    context "when marked as DNF" do
      let(:performance) { Performance.create(driver: driver, session: session, dnf: true) }
      let(:lap) { performance.laps.create(driver: performance.driver) }

      context "with sectors with times at zero" do
        let!(:sector) { lap.sectors.create(driver: lap.driver, time: 0) }

        it "should return true" do
          expect(performance.has_valid_times?).to eq(true)
        end
      end

      context "with sectors with non-zero times" do
        let!(:sector) { lap.sectors.create(driver: lap.driver, time: 20) }

        it "should return true" do
          expect(performance.has_valid_times?).to eq(true)
        end
      end
    end

    context "when not marked as DNF" do
      let(:performance) { Performance.create(driver: driver, session: session) }
      let(:lap) { performance.laps.create(driver: performance.driver) }

      context "with sectors with times at zero" do
        let!(:sector) { lap.sectors.create(driver: lap.driver, time: 0) }

        it "should return false" do
          expect(performance.has_valid_times?).to eq(false)
        end
      end

      context "with sectors with non-zero times" do
        let!(:sector) { lap.sectors.create(driver: lap.driver, time: 20) }

        it "should return true" do
          expect(performance.has_valid_times?).to eq(true)
        end
      end
    end
  end
end
