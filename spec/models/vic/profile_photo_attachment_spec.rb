# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VIC::ProfilePhotoAttachment, type: :model do
  describe '#set_file_data!' do
    it 'stores the filename' do
      attachment = build_stubbed(:profile_photo_attachment,
                                 file_path: 'spec/fixtures/files/va.gif',
                                 file_type: 'image/gif')

      expect(attachment.parsed_file_data).to have_key('filename')
    end
  end

  describe '#get_file' do
    let!(:attachment) do
      build_stubbed(:profile_photo_attachment,
                    file_path: 'spec/fixtures/files/va.gif',
                    file_type: 'image/gif')
    end

    it 'uses the new filename to get the file' do
      ProcessFileJob.drain
      expect(attachment.get_file.exists?).to eq(true)
    end
  end
end
