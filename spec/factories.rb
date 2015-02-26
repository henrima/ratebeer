FactoryGirl.define do

  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :rating3, class: Rating do
    score 25
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :brewery2 do
    name "paras panimo"
    year 2015
  end

  factory :beer do
    name "Testiolut IVA"
    brewery
    style
  end

  factory :style do
    name "Jallumainen"
    description "hedelmaisan aromikas"
  end

end
