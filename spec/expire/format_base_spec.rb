# frozen_string_literal: true

require 'support/shared_examples_for_formats'
require 'support/shared_examples_for_format_base_descendants'

RSpec.describe Expire::FormatBase do
  it_behaves_like 'a format'
  it_behaves_like 'a FormatBase descendant'
end
