require 'spec_helper'

feature 'I18n' do
  scenario 'Visitor visits the root path without a locale' do
    visit '/'

    expect(page.current_path).to eq '/en'
  end

  scenario 'Visitor switches to german' do
    visit '/de'

    expect(I18n.locale).to eq :de
  end
end
