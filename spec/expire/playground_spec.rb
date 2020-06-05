# frozen_string_literal: true

RSpec.describe Expire::Playground do
  describe '.create' do
    context 'without any options' do
      let(:basedir) { 'tmp/my_playground' }
      let(:backups_dir) { Pathname.new("#{basedir}/backups") }

      before do
        FileUtils.rm_rf(basedir)
        described_class.create(basedir)
      end

      it 'creates 15 backup directories' do
        expect(backups_dir.children.length).to eq(15)
      end

      it 'creates backup directories in the format YYYYY-mm-ddTHH:MM' do
        backups_dir.children.each do |backup|
          expect(backup.to_s).to match(/\d\d\d\d-\d\d-\d\dT\d\d:\d\d\z/)
        end
      end
    end
  end
end
