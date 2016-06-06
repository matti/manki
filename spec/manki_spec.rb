require 'spec_helper'

describe Manki do
  it 'has a version number' do
    expect(Manki::VERSION).not_to be nil
  end

  it 'can be instantiated' do
    expect(Manki.new).to be_a(Manki)
  end
end
