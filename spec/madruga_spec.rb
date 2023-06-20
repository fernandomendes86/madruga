# frozen_string_literal: true

RSpec.describe Madruga do
  let(:file) { "spec/fixtures/files/test.txt" }
  let(:beginning_column) { 2 }

  it "has a version number" do
    expect(Madruga::VERSION).not_to be nil
  end

  it "has the first line been modified" do
    old_first_line = File.open(file, &:readline)
    Madruga::FormatFile.perform(file, beginning_column)
    new_first_line = File.open(file, &:readline)
    diff_amount = old_first_line.size - new_first_line.size

    expect(diff_amount).to eq(beginning_column)
  end
end
