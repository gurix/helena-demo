module Seeds
  class Survey
    def self.generate_data
      puts 'Seeding surveys ...'.green
      create_satisfaction_scale_survey_en
      create_satisfaction_scale_survey_de
    end

    def self.create_satisfaction_scale_survey_en
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


      survey = create :survey, name: 'The Satisfaction with Life Scale', tag_list: 'Life satisfaction', language: 'en'
      base_version = survey.versions.create version: 0
      base_version.survey_detail = build :survey_detail, title:       'The Satisfaction with Life Scale',
                                                         description: 'A 5-item scale designed to measure global cognitive judgments of ones life satisfaction. – Ed Diener'

      base_version.question_groups << satisfaction_details
      published_version = publish(base_version)
    end

    def self.create_satisfaction_scale_survey_de
      satisfaction_matrix = build :radio_matrix_question, code:          :satisfaction,
                                                          required:      true,
                                                          question_text: 'Es folgen fünf Aussagen, denen Sie zustimmen bzw. die Sie ablehnen koennen. Bitte benutzen Sie die folgende Skala, um Ihre Zustimmung bzw. Ablehnung zu jeder Aussage zum Ausdruck zu bringen.',
                                                          required:      true,
                                                          position:      1

      satisfaction_matrix.labels << build(:label, position: 1, text: 'starke Ablehnung', value: 1)
      satisfaction_matrix.labels << build(:label, position: 2, text: 'Ablehnung', value: 2)
      satisfaction_matrix.labels << build(:label, position: 3, text: 'leichte Ablehnung', value: 3)
      satisfaction_matrix.labels << build(:label, position: 4, text: 'weder Ablehnung noch Zustimmung', value: 4)
      satisfaction_matrix.labels << build(:label, position: 5, text: 'leichte Zustimmung', value: 5)
      satisfaction_matrix.labels << build(:label, position: 6, text: 'Zustimmung', value: 6)
      satisfaction_matrix.labels << build(:label, position: 7, text: 'starke Zustimmung', value: 7)

      satisfaction_matrix.sub_questions << build(:sub_question, text: 'In den meisten Punkten ist mein Leben meinem Ideal nahe.', code: 'life_is_ideal', position: 1)
      satisfaction_matrix.sub_questions << build(:sub_question, text: 'Meine Lebensbedingungen sind hervorragend.', code: 'condition', position: 2)
      satisfaction_matrix.sub_questions << build(:sub_question, text: 'Ich bin zufrieden mit meinem Leben.', code: 'satisfied_with_life', position: 3)
      satisfaction_matrix.sub_questions << build(:sub_question, text: 'Ich habe bisher die wichtigen Dinge, die ich mir vom Leben wünsche, auch bekommen.', code: 'important_things', position: 4)
      satisfaction_matrix.sub_questions << build(:sub_question, text: 'Wenn ich mein Leben noch einmal leben koennte, wuerde ich fast nichts ändern.', code: 'nothing_to_change', position: 5)

      satisfaction_details = build :question_group, questions: [satisfaction_matrix]


      survey = create :survey, name: 'Fragebogen zur Erfassung der Lebenszufriedenheit', tag_list: 'Lebenszufriedenheit', language: 'de'
      base_version = survey.versions.create version: 0
      base_version.survey_detail = build :survey_detail, title:       'Fragebogen zur Erfassung der Lebenszufriedenheit',
                                                         description: 'Die Lebenszufriedenheit wird anhand von 5 Fragen erfasst. – Ed Diener'

      base_version.question_groups << satisfaction_details
      published_version = publish(base_version)
    end

    def self.publish(version)
      published_version = Helena::VersionPublisher.publish(version)
      published_version.notes = Faker::Lorem.paragraph(1)
      published_version.save
      published_version
    end
  end
end
