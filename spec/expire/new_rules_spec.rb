# frozen_string_literal: true

RSpec.describe Expire::NewRules do
  it { should respond_to(:one_per_hour) }
  it { should respond_to(:one_per_day) }
  it { should respond_to(:one_per_week) }
  it { should respond_to(:one_per_month) }
  it { should respond_to(:one_per_year) }

  it { should respond_to(:one_per_hour_for) }
  it { should respond_to(:one_per_day_for) }
  it { should respond_to(:one_per_week_for) }
  it { should respond_to(:one_per_month_for) }
  it { should respond_to(:one_per_year_for) }

  it { should respond_to(:from_now_one_per_hour) }
  it { should respond_to(:from_now_one_per_day) }
  it { should respond_to(:from_now_one_per_week) }
  it { should respond_to(:from_now_one_per_month) }
  it { should respond_to(:from_now_one_per_year) }

  it { should respond_to(:from_now_one_per_hour_for) }
  it { should respond_to(:from_now_one_per_day_for) }
  it { should respond_to(:from_now_one_per_week_for) }
  it { should respond_to(:from_now_one_per_month_for) }
  it { should respond_to(:from_now_one_per_year_for) }
end
