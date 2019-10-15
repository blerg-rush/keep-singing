FactoryBot.define do
  factory :video do
    uid { 'fVhPqZWbfmd' }
    link { 'https://www.youtube.com/watch?v=fVhPqZWbfmd' }
    title { 'Test Video' }
    description { 'A test video.' }
    channel_uid { 'UxK5sQmjBp3GCxHOtqWBlyEg' }
    published_at { '2019-10-09 07:31:29' }
  end
end
