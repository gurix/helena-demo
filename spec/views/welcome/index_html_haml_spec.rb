require 'spec_helper'

describe 'welcome/index.html.haml' do
  before { render }

  it 'shows title and description' do
    expect(rendered).to have_content 'Helena Demo App'
    expect(rendered).to have_content 'Helena is an online survey/test
    framework designed for agile survey/test development, longitudinal studies and instant feedback.'
  end
end
