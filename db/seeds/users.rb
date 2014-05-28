module Seeds
  class User
    def self.generate_data
      puts 'Seeding users ...'.green
      user = create :user, email: 'hans.muster@somedomain.tld', password: 'test123', name: 'Hans Muster'
      user.confirm!
    end
  end
end
