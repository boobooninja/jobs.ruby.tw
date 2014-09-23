require 'spec_helper'

feature 'View homepage' do
  background do
    # @user = build_user
    # @job = build_job(owner: @user)
    @user = FactoryGirl.create(:user)
    @job  = FactoryGirl.create(:job)
  end

  scenario 'User should see job title in homepage' do
    visit root_path
    expect(page).to have_content(@job.title)
    expect(page).to have_content(@job.company_name)
    expect(page).to have_content(@job.location)
  end

  scenario 'User should see job description in job page' do
    expect(Job.count).to eq 1
    visit job_path(@job)
    expect(page).to have_content(@job.job_type)
    expect(page).to have_content(@job.occupation)
    expect(page).to have_content(@job.url)
    # page.should have_content(@job.description)
    # page.should have_content(@job.apply_information)
  end

  scenario 'User could post new job' do
    # login!
    signin(@user.email, @user.password)
    visit new_job_path

    within('#new_job') do
      fill_in 'Job Title', with: 'job title'
      fill_in 'Company Name', with: 'foobar'
      fill_in 'URL', with: 'http://ruby.tw'
      choose 'Part-time'
      choose 'Web front-end'
      fill_in 'Location', with: 'hsinchu'
      fill_in 'Description', with: 'description Ruby'
      fill_in 'Apply Information', with: 'apply infor.'
      check 'Forever'
    end

    click_button 'Submit'

    expect(page).to have_content('job title')
    expect(page).to have_content('foobar')
    expect(page).to have_content('hsinchu')
  end

end
