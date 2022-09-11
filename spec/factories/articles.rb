FactoryBot.define do
    factory :article do
        title {"Sample article"}
        content {"Sample Content"}
        slug {"sample-article"}
    end

    sequence :slug do |n|
        "sample-#{n}"
    end
end