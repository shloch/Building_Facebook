FactoryBot.define do
    
    factory :invalid_post, class: 'Post' do
      post_text { ' '}
      
    end
    factory :post1, class: 'Post' do
      post_text { 'FactoryBot sample post' }
      #author_id { FactoryBot.create(:user1).id }
    end
  end

  