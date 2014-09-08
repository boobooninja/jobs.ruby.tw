# include Warden::Test::Helpers
# Warden.test_mode!

# Feature: Job listing page
#   As a visitor
#   I want to visit a job listing page
#   So I can see the job details
feature 'Job listing page' do

  # after(:each) do
  #   Warden.test_reset!
  # end

  # Scenario: Visitor sees job listing
  #   When I visit the job listing page
  #   Then I see the job details
  scenario 'visitor sees job details' do
    user = FactoryGirl.create(:user)
    job  = FactoryGirl.create(:job)
    # login_as(user, :scope => :user)
    visit job_path(job)
    expect(page).to have_content 'Job'
    expect(page).to have_content job.title
  end

end
