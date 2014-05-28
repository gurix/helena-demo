require 'spec_helper'

describe User do
  it { expect(subject).to validate_presence_of(:name) }
end
