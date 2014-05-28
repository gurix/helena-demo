module Seeds
  class Survey
    def self.generate_data
      puts 'Seeding surveys ...'.green
      create_satisfaction_scale_survey
    end

    def self.create_satisfaction_scale_survey
      satisfaction_matrix = build :radio_matrix_question, code:          :satisfaction,
                                                          required:      true,
                                                          question_text: 'Below are five statements with which you may agree or disagree. Using the 1-7 scale below, indicate your agreement with each item by placing the appropriate number in the line preceding that item. Please be open and honest in your responding.',
                                                          required:      true,
                                                          position:      1

      satisfaction_matrix.labels << build(:label, position: 1, text: 'Strongly Disagree', value: 1)
      satisfaction_matrix.labels << build(:label, position: 2, text: 'Disagree', value: 2)
      satisfaction_matrix.labels << build(:label, position: 3, text: 'Slightly Disagree', value: 3)
      satisfaction_matrix.labels << build(:label, position: 4, text: 'Neither Agree or Disagree', value: 4)
      satisfaction_matrix.labels << build(:label, position: 5, text: 'Slightly Agree', value: 5)
      satisfaction_matrix.labels << build(:label, position: 6, text: 'Agree', value: 6)
      satisfaction_matrix.labels << build(:label, position: 7, text: 'Strongly Agree', value: 7)

      satisfaction_matrix.sub_questions << build(:sub_question, text: 'In most ways my life is close to my ideal.', code: 'life_is_ideal', position: 1)
      satisfaction_matrix.sub_questions << build(:sub_question, text: 'The conditions of my life are excellent.', code: 'condition', position: 2)
      satisfaction_matrix.sub_questions << build(:sub_question, text: 'I am satisfied with life.', code: 'satisfied_with_life', position: 3)
      satisfaction_matrix.sub_questions << build(:sub_question, text: 'So far I have gotten the important things I want in life.', code: 'important_things', position: 4)
      satisfaction_matrix.sub_questions << build(:sub_question, text: 'If I could live my life over, I would change almost nothing.', code: 'nothing_to_change', position: 5)

      satisfaction_details = build :question_group, questions: [satisfaction_matrix]


      survey = create :survey, name: 'The Satisfaction with Life Scale'
      base_version = survey.versions.create version: 0
      base_version.survey_detail = build :survey_detail, title:       'The Satisfaction with Life Scale',
                                                         description: 'A 5-item scale designed to measure global cognitive judgments of ones life satisfaction. – Ed Diener'

      base_version.question_groups << satisfaction_details
      published_version = publish(base_version)

      generate_sessions(survey, published_version)
    end

    def self.publish(version)
      published_version = Helena::VersionPublisher.publish(version)
      published_version.notes = Faker::Lorem.paragraph(1)
      published_version.save
      published_version
    end

    def self.generate_sessions(survey, version)
      3.times {
       survey.sessions << build(:session, version: version, updated_at: DateTime.now - rand(999), completed: false)
      }

      3.times {
        session = build :session, version: version, updated_at: DateTime.now - rand(999), completed: true
        version.questions.each do |question|
          case question
          when Helena::Questions::ShortText
            session.answers << build(:string_answer, code: question.code, value: Faker::Skill.tech_skill )
          when Helena::Questions::LongText
            session.answers << build(:string_answer, code: question.code, value: Faker::Skill.tech_skill )
          when Helena::Questions::RadioGroup
            session.answers << Helena::Answer.build_generic(question.code, question.labels.sample.value, Faker::Internet.ip_v4_address)
          when Helena::Questions::CheckboxGroup
            question.sub_questions.sample(2).each do |sub_question|
              session.answers << Helena::Answer.build_generic(sub_question.code, sub_question.value, Faker::Internet.ip_v4_address)
            end
          when Helena::Questions::RadioMatrix
            question.sub_questions.each do |sub_question|
              session.answers << Helena::Answer.build_generic(sub_question.code, question.labels.sample.value, Faker::Internet.ip_v4_address)
            end
          end
        end
        survey.sessions << session
      }
    end
  end
end
