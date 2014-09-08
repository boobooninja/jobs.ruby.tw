# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    title "Ruby Developer"
    job_type "Full-time"
    occupation "Web back-end"
    company_name "ACME Corp"
    location "Taipei"
    url "http://jobs.ruby.tw"
    description "Ruby on Rails Back-end Developer"
    apply_information "Send resume"
    deadline "2014-09-08"
    user_id 1
    aasm_state "published"
  end
end
