module Seeds
  class User
    def self.generate_data
      puts 'Seeding users ...'
      user = create :user, email: 'hans.muster@somedomain.tld', password: 'test123', name: 'Hans Muster'
    end
  end
end
