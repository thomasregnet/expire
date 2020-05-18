# frozen_string_literal: true

require 'test_dates'
require 'spec_helper'
require 'support/shared_examples_for_keep_services'

RSpec.describe Expire::KeepFirstOfIntervalService do
  it_behaves_like 'a keep service' do
    let(:constructor_args) { {} }
  end

  describe 'calculate yearly' do
    let(:test_backups) do
      TestDates.create(years: 1857..1860, months: 1..5, days: 17)
               .to_audited_backup_list
    end

    let(:rules) { Expire::Rules.new(yearly: 3) }

    let(:backups) do
      first_to_keep = described_class.new(
        adjective: 'yearly',
        backups:   test_backups,
        noun:      'year',
        rules:     rules
      )
      first_to_keep.call
      first_to_keep.backups
    end

    it 'keeps the expected amount of backups' do
      expect(backups.select(&:keep?).length).to eq(3)
    end

    it 'keeps the right first backup' do
      expect(backups.select(&:keep?).first.year).to eq(1860)
    end
  end

  describe 'calculate monthly' do
    let(:test_backups) do
      TestDates.create(years: 1859..1860, months: 1..12, days: (1..28).step(3))
               .to_audited_backup_list
    end

    let(:rules) { Expire::Rules.new(monthly: 18) }

    let(:backups) do
      first_to_keep = described_class.new(
        adjective: 'monthly',
        backups:   test_backups,
        noun:      'month',
        rules:     rules
      )
      first_to_keep.call
      first_to_keep.backups
    end

    it 'keeps the expected amount of backups' do
      expect(backups.select(&:keep?).length).to eq(18)
    end

    it 'keeps the right first backup' do
      expect(backups.select(&:keep?).first.to_s)
        .to eq('1860-12-28T12:00:00+00:00')
    end

    it 'keeps the right second backup' do
      expect(backups.select(&:keep?)[1].to_s)
        .to eq('1860-11-28T12:00:00+00:00')
    end

    it 'keeps the right laste backup' do
      expect(backups.select(&:keep?).last.to_s)
        .to eq('1859-07-28T12:00:00+00:00')
    end
  end
end