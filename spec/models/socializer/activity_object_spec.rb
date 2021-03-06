require 'spec_helper'

module Socializer
  describe ActivityObject do
    let(:activity_object) { build(:socializer_activity_object) }

    it 'has a valid factory' do
      expect(activity_object).to be_valid
    end

    context 'mass assignment' do
      it { expect(activity_object).to allow_mass_assignment_of(:scope) }
      it { expect(activity_object).to allow_mass_assignment_of(:object_ids) }
      it { expect(activity_object).to allow_mass_assignment_of(:activitable_id) }
      it { expect(activity_object).to allow_mass_assignment_of(:activitable_type) }
      it { expect(activity_object).to allow_mass_assignment_of(:like_count) }
      it { expect(activity_object).to allow_mass_assignment_of(:unread_notifications_count) }
      it { expect(activity_object).to allow_mass_assignment_of(:object_ids) }
    end

    context 'relationships' do
      it { expect(activity_object).to belong_to(:activitable) }
      it { expect(activity_object).to have_many(:notifications) }
      it { expect(activity_object).to have_many(:audiences) }
      it { expect(activity_object).to have_many(:activities).through(:audiences) }
      it { expect(activity_object).to have_many(:actor_activities) }
      it { expect(activity_object).to have_many(:object_activities) }
      it { expect(activity_object).to have_many(:target_activities) }
      it { expect(activity_object).to have_many(:notes) }
      it { expect(activity_object).to have_many(:comments) }
      it { expect(activity_object).to have_many(:groups) }
      it { expect(activity_object).to have_many(:circles) }
      it { expect(activity_object).to have_many(:ties) }
      it { expect(activity_object).to have_many(:memberships).conditions(active: true) }
    end

    context 'when liked' do
      let(:liking_person) { create(:socializer_person) }
      let(:liked_activity_object) { create(:socializer_activity_object) }

      before do
        liked_activity_object.like! liking_person
        liked_activity_object.reload
      end

      it { expect(liked_activity_object.like_count).to eq(1) }
      # it { expect(liked_activity_object.likes.size).to eq(1) }

      context 'and unliked' do
        before do
          liked_activity_object.unlike! liking_person
          liked_activity_object.reload
        end

        it { expect(liked_activity_object.like_count).to eq(0) }
        # it { expect(liked_activity_object.likes.size).to eq(0) }
      end
    end

    it '#scope' do
      expect(activity_object).to respond_to(:scope)
    end

    it '#like_count' do
      expect(activity_object).to respond_to(:like_count)
    end

    it '#note?' do
      expect(activity_object).to respond_to(:note?)
    end

    it '#activity?' do
      expect(activity_object).to respond_to(:activity?)
    end

    it '#comment?' do
      expect(activity_object).to respond_to(:comment?)
    end

    it '#person?' do
      expect(activity_object).to respond_to(:person?)
    end

    it '#group?' do
      expect(activity_object).to respond_to(:group?)
    end

    it '#circle?' do
      expect(activity_object).to respond_to(:circle?)
    end

    it '#likes' do
      expect(activity_object).to respond_to(:likes)
    end

    it '#like!' do
      expect(activity_object).to respond_to(:like!)
    end

    it '#unlike!' do
      expect(activity_object).to respond_to(:unlike!)
    end

    it '#share!' do
      expect(activity_object).to respond_to(:share!)
    end

    %w(Person Activity Note Comment Group Circle).each do |type|

      it sprintf('is type of %s', type) do
        activity_object.activitable_type = "Socializer::#{type}"
        expect(activity_object.send("#{type.downcase}?")).to be_true
      end

    end

  end
end
