FactoryBot.define do
    
    factory :invalid_post, class: 'Post' do
      post_text { ' '}
      
    end
    factory :post1, class: 'Post' do
      post_text { 'FactoryBot sample post' }
    end
  end

  