json.array!(@jobs) do |job|
  json.extract! job, :id, :title, :job_type, :occupation, :company_name, :location, :url, :description, :apply_information, :deadline, :user_id, :aasm_state
  json.url job_url(job, format: :json)
end
