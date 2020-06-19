# frozen_string_literal: true

module Expire
  # Rules how to expire backups
  class NewRules
    include Constants

    ONE_PER_UNIT_RULE_NAMES = STEP_NOUNS.map do |unit|
      "one_per_#{unit}"
    end.freeze

    ONE_PER_UNIT_FOR_RULE_NAMES = STEP_NOUNS.map do |unit|
      "one_per_#{unit}_for"
    end.freeze

    FROM_NOW_ONE_PER_UNIT_RULE_NAMES = STEP_NOUNS.map do |unit|
      "from_now_one_per_#{unit}"
    end.freeze

    FROM_NOW_ONE_PER_UNIT_FOR_RULE_NAMES = STEP_NOUNS.map do |unit|
      "from_now_one_per_#{unit}_for"
    end.freeze

    ALL_RULE_NAMES = [
      'at_least',
      ONE_PER_UNIT_RULE_NAMES,
      ONE_PER_UNIT_FOR_RULE_NAMES,
      FROM_NOW_ONE_PER_UNIT_RULE_NAMES,
      FROM_NOW_ONE_PER_UNIT_FOR_RULE_NAMES
    ].flatten.freeze

    ALL_RULE_NAMES.each { |rule_name| attr_reader rule_name }
  end
end
