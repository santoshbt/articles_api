FactoryBot.define do
    factory :article do
        title {"Sample article"}
        content {"Sample Content"}
        sequence :slug do |n|
            "sample-#{n}"
        end
    end
end