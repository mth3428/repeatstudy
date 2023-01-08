FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'test@example'}
    password              {'abc123'}
    password_confirmation {password}
    introduction          {'hogehogeです'}
  end
end