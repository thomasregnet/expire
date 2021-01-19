# frozen_string_literal: true

require 'support/shared_examples_for_formats'
require 'support/shared_examples_for_report_base_descendants'

RSpec.describe Expire::ReportBase do
  it_behaves_like 'a format'
  it_behaves_like 'a ReportBase descendant'
end
