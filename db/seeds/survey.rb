module Seeds
  class Survey
    def self.generate_data
      puts 'Seeding surveys ...'
      create_satisfaction_scale_survey_en
      create_satisfaction_scale_survey_de
    end

    def self.create_satisfaction_scale_survey_en
      survey_importer = Helena::SurveyImporter.new File.read(File.dirname(__FILE__) + '/files/swls_survey.en.yml')
      survey = survey_importer.survey

      session_report = File.read Rails.root.join('db/seeds/files/report_satisfaction_scale_survey.en.html.slim')

      survey.newest_version.update_attributes session_report: session_report, active: true
    end

    def self.create_satisfaction_scale_survey_de
      survey_importer = Helena::SurveyImporter.new File.read(File.dirname(__FILE__) + '/files/swls_survey.de.yml')
      survey = survey_importer.survey

      session_report = File.read Rails.root.join('db/seeds/files/report_satisfaction_scale_survey.de.html.slim')

      survey.newest_version.update_attributes session_report: session_report, active: true
    end
  end
end
